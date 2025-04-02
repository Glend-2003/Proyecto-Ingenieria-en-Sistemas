import React, { useState, useEffect } from "react";
import "bootstrap/dist/css/bootstrap.min.css";
import '../styles.min.css';
import axios from "axios";
import Snackbar from '@mui/material/Snackbar';
import MuiAlert from '@mui/material/Alert';
import { FaSpinner, FaArrowLeft, FaCheck, FaTimes } from 'react-icons/fa'; // Añadidos FaCheck y FaTimes

function PedidoCrud() {
  // Estados para los campos del formulario
  const [formData, setFormData] = useState({
    nombreUsuario: '',
    primerApellido: '',
    segundoApellido: '',
    telefonoUsuario: '',
    correoUsuario: '',
    tipoPersona: 'Física',
    cedulaUsuario: '',
    tipoCedula: 'Cédula Física',
    sucursal: 'Cairo de Cariari',
    provincia: 'Limón',
    localidad: 'El cairo Cariari en',
    horaRetiro: '',
    tipoPago: '' // Nuevo campo para tipo de pago
  });

  // Estado para almacenar los tipos de pago
  const [tiposPago, setTiposPago] = useState([]);

  // Estado para manejar errores y loading
  const [status, setStatus] = useState({
    loading: false,
    error: null,
    success: false
  });
  
  // Estado para el Snackbar
  const [snackbar, setSnackbar] = useState({
    open: false,
    message: '',
    severity: 'success'
  });
  
  // Estado para la validación de cédula
  const [cedulaValidation, setCedulaValidation] = useState({
    isValid: false,
    isChecking: false,
    wasChecked: false,
    message: ''
  });

  // Función para cerrar el Snackbar
  const handleCloseSnackbar = () => {
    setSnackbar({...snackbar, open: false});
  };

  // Recuperar carrito del localStorage
  const [cart, setCart] = useState([]);

  // Debounce para la validación de cédula
  useEffect(() => {
    const delayDebounceFn = setTimeout(() => {
      if (formData.cedulaUsuario && formData.cedulaUsuario.trim() !== '') {
        validateCedula(formData.cedulaUsuario);
      }
    }, 1000);
    return () => clearTimeout(delayDebounceFn);
  }, [formData.cedulaUsuario]);
  
  useEffect(() => {
    const savedCart = JSON.parse(localStorage.getItem("carrito")) || [];
    setCart(savedCart);
    
    // Llamada a la API para obtener los tipos de pago
    const fetchTiposPago = async () => {
      try {
        const response = await axios.get('http://localhost:8080/tipopago/');
        setTiposPago(response.data);
        
        // Si hay tipos de pago disponibles, establecer el primero como valor por defecto
        if (response.data && response.data.length > 0) {
          setFormData(prevData => ({
            ...prevData,
            tipoPago: response.data[0].idTipoPago // Usando el campo correcto idTipoPago
          }));
        }
        console.log('Tipos de pago cargados:', response.data); // Para depuración
      } catch (error) {
        console.error('Error al obtener tipos de pago:', error);
        setSnackbar({
          open: true,
          message: 'Error al cargar los tipos de pago',
          severity: 'error'
        });
      }
    };
    
    fetchTiposPago();
  }, []);

  // Calcular totales
  const subtotal = cart.reduce((total, item) => total + (item.montoPrecioProducto * item.cantidad), 0);
  const montoTotalPedido = cart.reduce((total, item) => total + (item.montoPrecioProducto * item.cantidad), 0) * 1.15;

  // Función para validar la cédula con la API de Hacienda
  const validateCedula = async (cedula) => {
    // Verificamos que la cédula tenga al menos un carácter antes de consultar la API
    if (!cedula || cedula.trim().length === 0) {
      setCedulaValidation({
        isValid: false,
        isChecking: false,
        wasChecked: true,
        message: 'Ingrese un número de cédula válido'
      });
      return;
    }
    setCedulaValidation({
      ...cedulaValidation,
      isChecking: true,
      message: 'Verificando cédula...'
    });

    try {
      const response = await axios.get(`https://api.hacienda.go.cr/fe/ae?identificacion=${cedula}`);
      
      if (response.data && response.status === 200) {
        setCedulaValidation({
          isValid: true,
          isChecking: false,
          wasChecked: true,
          message: 'Cédula verificada correctamente'
        });
      } else {
        setCedulaValidation({
          isValid: false,
          isChecking: false,
          wasChecked: true,
          message: 'La cédula no está registrada en Hacienda'
        });
      }
    } catch (error) {
      console.error('Error al validar cédula:', error);
      
      setCedulaValidation({
        isValid: false,
        isChecking: false,
        wasChecked: true,
        message: 'La cédula no está registrada o hubo un error de verificación'
      });
    }
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({
      ...formData,
      [name]: value
    });
    
    // Si se cambia la cédula, resetear la validación
    if (name === 'cedulaUsuario') {
      setCedulaValidation({
        isValid: false,
        isChecking: false,
        wasChecked: false,
        message: ''
      });
    }
  };

  // Alert personalizado para Snackbar
  const Alert = React.forwardRef(function Alert(props, ref) {
    return <MuiAlert elevation={6} ref={ref} variant="filled" {...props} />;
  });

  const handleSubmit = async (e) => {
    e.preventDefault();
  
    // Verificar que la cédula sea válida antes de enviar
    if (!cedulaValidation.isValid) {
      setSnackbar({
        open: true,
        message: 'La cédula no es válida. No se puede procesar el pedido.',
        severity: 'error'
      });
      return;
    }
  
    setStatus({ loading: true, error: null, success: false });
  
    try {
      // Obtener el ID de usuario del localStorage o usar uno por defecto
      const idUsuario = localStorage.getItem("idUsuario") || 56;
      
      // PASO 1: Crear un nuevo carrito en la base de datos
      const carritoData = {
        usuario: {
          idUsuario: parseInt(idUsuario, 10)
        },
        montoTotalCarrito: subtotal,
        estadoCarrito: true,
        cantidadCarrito: cart.length
      };
      
      const carritoResponse = await axios.post('http://localhost:8080/carrito', carritoData);
      console.log('Carrito creado:', carritoResponse.data);
      
      // Obtener el ID del carrito recién creado
      const idCarrito = carritoResponse.data.idCarrito;

      console.log('ID del carrito creado:', idCarrito);
      
      // PASO 2: Agregar los productos al carrito (en serie, no en paralelo)
      for (const item of cart) {
        const productoCarrito = {
          carrito: {
            idCarrito: idCarrito
          },
          idProducto: item.idProducto,
          cantidadProducto: item.cantidad
        };
        
        await axios.post(`http://localhost:8080/carrito/${idCarrito}/productos`, productoCarrito);
        console.log(`Producto ${item.idProducto} agregado al carrito ${idCarrito}`);
      }
    
      // PASO 3: Añadir un retraso para asegurar que la base de datos ha procesado todas las transacciones
      console.log(`Esperando para asegurar que el carrito ${idCarrito} se guarde completamente...`);
      await new Promise(resolve => setTimeout(resolve, 3000));
  
      // Verificación opcional del carrito
      try {
        const checkCarritoResponse = await axios.get(`http://localhost:8080/carrito/usuario/${idUsuario}`);
        console.log(`Verificación de carrito exitosa:`, checkCarritoResponse.data);
      } catch (verifyError) {
        console.error(`Error al verificar carrito para usuario ${idUsuario}:`, verifyError);
        // No interrumpir el flujo, solo registrar el error
      }
  
      // PASO 4: Crear el pedido con el carrito recién creado
      const pedidoData = {
        // Datos del usuario
        
        nombreUsuario: formData.nombreUsuario,
        primerApellido: formData.primerApellido,
        segundoApellido: formData.segundoApellido,
        telefonoUsuario: formData.telefonoUsuario,
        correoUsuario: formData.correoUsuario,
        tipoPersona: formData.tipoPersona,
        cedulaUsuario: formData.cedulaUsuario,
        tipoCedula: formData.tipoCedula,
        
        // Datos de la sucursal y retiro
        sucursal: formData.sucursal,
        provincia: formData.provincia,
        localidad: formData.localidad,
        horaRetiro: formData.horaRetiro,
        
        // Asociar con el carrito recién creado (usando objeto anidado)
        carrito: {
          idCarrito: idCarrito,
          usuario: {
            idUsuario: parseInt(idUsuario, 10)
          }
        },

        
        
        // Tipo de pago (usando objeto anidado)
        tipoPago: {
          idTipoPago: parseInt(formData.tipoPago, 10)
        },
        
        // Datos del pedido
        subtotal: subtotal,
        montoTotalPedido: montoTotalPedido,
        fechaPedido: new Date().toISOString(),
        estadoPedido: true,
        estadoEntregaPedido: "Pendiente"
      };
      
      console.log('Enviando datos del pedido:', JSON.stringify(pedidoData, null, 2));
      
      const pedidoResponse = await axios.post('http://localhost:8080/pedido/agregar', pedidoData);
      console.log('Pedido registrado de manera exitosa:', pedidoResponse.data);
      
      // PASO 5: Actualizar el estado del carrito a inactivo
      await axios.put(`http://localhost:8080/carrito/${idCarrito}`, {
        usuario: {
          idUsuario: parseInt(idUsuario, 10)
        },
        montoTotalCarrito: subtotal,
        estadoCarrito: false,  // Marcar como inactivo
        cantidadCarrito: cart.length
      });
  
      setStatus({ loading: false, error: null, success: true });
  
      setSnackbar({
        open: true,
        message: 'Pedido registrado de manera exitosa',
        severity: 'success'
      });
  
      localStorage.removeItem("carrito");
      setCart([]);
  
      setTimeout(() => {
        window.location.href = "/";
      }, 2000);
  
    } catch(error) {
      console.error('Error al registrar el pedido:', error);
  
      // Log detallado para diagnóstico
      console.log('Detalles del error:', {
        status: error.response?.status,
        statusText: error.response?.statusText,
        data: error.response?.data,
        message: error.message,
        stack: error.stack
      });
      
      setStatus({ 
        loading: false, 
        error: error.response?.data?.message || "Error al procesar el pedido", 
        success: false 
      });
      
      setSnackbar({
        open: true,
        message: error.response?.data?.message || "Error al procesar el pedido",
        severity: 'error'
      });
    }
  };

  // Renderizar productos del carrito
  const renderCartItems = () => {
    if (cart.length > 0) {
      return cart.map((item, index) => (
        <div className="row mb-2 pb-2 border-bottom" key={index}>
          <div className="col-8">{item.nombreProducto || "Producto"} × {item.cantidad}</div>
          <div className="col-4 text-end">₡{((item.montoPrecioProducto || 0) * item.cantidad).toLocaleString()}</div>
        </div>
      ));
    } else {
      return (
        <div className="row mb-2 pb-2 border-bottom">
          <div className="col-12 text-center">No hay productos en el carrito</div>
        </div>
      );
    }
  };

  // Determinar si el botón de finalizar debe estar deshabilitado
  const isSubmitDisabled = status.loading || 
                           tiposPago.length === 0 || 
                           !cedulaValidation.isValid || 
                           cedulaValidation.isChecking || 
                           cart.length === 0;

  return (
    <div className="container py-4 my-3">
      <h1 className="text-center">Finalizar pedido</h1>

      {/* Botón para regresar */}
      <div className="mb-3">
        <button 
          className="btn btn-outline-secondary" 
          onClick={() => window.history.back()}
        >
          <FaArrowLeft className="me-2" /> Volver
        </button>
      </div>

      <div className="row">
        <div className="col-md-6">
          <div className="mb-10">
            <h2 style={{ marginBottom: "25px", fontSize: "25px" }}>
              Detalles finales de la compra
            </h2>
            <div className="row">
              <div className="col-md-6">
                <label htmlFor="nombreUsuario" className="form-label">
                  Nombre
                </label>
                <input
                  type="text"
                  className="form-control"
                  id="nombreUsuario"
                  name="nombreUsuario"
                  value={formData.nombreUsuario}
                  onChange={handleChange}
                />
              </div>
              <div className="col-md-6">
                <label htmlFor="primerApellido" className="form-label">
                  Primer apellido
                </label>
                <input
                  type="text"
                  className="form-control"
                  id="primerApellido"
                  name="primerApellido"
                  value={formData.primerApellido}
                  onChange={handleChange}
                />
              </div>
            </div>
            <div className="row">
              <div className="col-md-6">
                <label htmlFor="segundoApellido" className="form-label">
                  Segundo apellido
                </label>
                <input
                  type="text"
                  className="form-control"
                  id="segundoApellido"
                  name="segundoApellido"
                  value={formData.segundoApellido}
                  onChange={handleChange}
                />
              </div>
              <div className="col-md-6">
                <label htmlFor="telefonoUsuario" className="form-label">
                  Teléfono
                </label>
                <input
                  type="text"
                  className="form-control"
                  id="telefonoUsuario"
                  name="telefonoUsuario"
                  value={formData.telefonoUsuario}
                  onChange={handleChange}
                />
              </div>
            </div>
            <div className="row">
              <div className="col-md-6">
                <label htmlFor="correoUsuario" className="form-label">
                  Correo electrónico
                </label>
                <input
                  type="email"
                  className="form-control"
                  id="correoUsuario"
                  name="correoUsuario"
                  value={formData.correoUsuario}
                  onChange={handleChange}
                />
              </div>
              <div className="col-md-6">
                <label htmlFor="tipoPersona" className="form-label">
                  Tipo de persona
                </label>
                <select
                  className="form-control"
                  id="tipoPersona"
                  name="tipoPersona"
                  value={formData.tipoPersona}
                  onChange={handleChange}
                >
                  <option value="Física">Física</option>
                  <option value="Jurídica">Jurídica</option>
                </select>
              </div>
            </div>
            <div className="row">
              <div className="col-md-6">
                <label htmlFor="cedulaUsuario" className="form-label">
                  Cédula
                </label>
                <div className="input-group">
                  <input
                    type="text"
                    className={`form-control ${cedulaValidation.wasChecked ? (cedulaValidation.isValid ? 'is-valid' : 'is-invalid') : ''}`}
                    id="cedulaUsuario"
                    name="cedulaUsuario"
                    value={formData.cedulaUsuario}
                    onChange={handleChange}
                  />
                  <div className="input-group-append">
                    <span className="input-group-text">
                      {cedulaValidation.isChecking ? (
                        <FaSpinner className="spinner" />
                      ) : cedulaValidation.wasChecked ? (
                        cedulaValidation.isValid ? (
                          <FaCheck className="text-success" />
                        ) : (
                          <FaTimes className="text-danger" />
                        )
                      ) : null}
                    </span>
                  </div>
                </div>
                {cedulaValidation.wasChecked && (
                  <div className={cedulaValidation.isValid ? "valid-feedback d-block" : "invalid-feedback d-block"}>
                    {cedulaValidation.message}
                  </div>
                )}
              </div>
              <div className="col-md-6">
                <label htmlFor="tipoCedula" className="form-label">
                  Tipo de cédula
                </label>
                <select
                  className="form-control"
                  id="tipoCedula"
                  name="tipoCedula"
                  value={formData.tipoCedula}
                  onChange={handleChange}
                >
                  <option value="Cédula Física">Cédula Física</option>
                  <option value="Cédula Jurídica">Cédula Jurídica</option>
                  <option value="DIMEX">DIMEX</option>
                </select>
              </div>
            </div>
            <div className="row">
              <div className="col-md-6">
                <label htmlFor="sucursal" className="form-label">
                  Sucursal
                </label>
                <input
                  type="text"
                  className="form-control"
                  id="sucursal"
                  name="sucursal"
                  value={formData.sucursal}
                  onChange={handleChange}
                />
              </div>
              <div className="col-md-6">
                <label htmlFor="provincia" className="form-label">
                  Provincia
                </label>
                <input
                  type="text"
                  className="form-control"
                  id="provincia"
                  name="provincia"
                  value={formData.provincia}
                  onChange={handleChange}
                />
              </div>
            </div>
            <div className="row">
              <div className="col-md-6">
                <label htmlFor="localidad" className="form-label">
                  Localidad
                </label>
                <input
                  type="text"
                  className="form-control"
                  id="localidad"
                  name="localidad"
                  value={formData.localidad}
                  onChange={handleChange}
                />
              </div>
              <div className="col-md-6">
                <label htmlFor="horaRetiro" className="form-label">
                  Hora de retiro
                </label>
                <input
                  type="time"
                  className="form-control"
                  id="horaRetiro"
                  name="horaRetiro"
                  value={formData.horaRetiro}
                  onChange={handleChange}
                />
              </div>
            </div>
            
            {/* Nuevo campo para Tipo de Pago */}
            <div className="row mt-3">
              <div className="col-md-6">
                <label htmlFor="tipoPago" className="form-label">
                  Tipo de Pago
                </label>
                <select
                  className="form-control"
                  id="tipoPago"
                  name="tipoPago"
                  value={formData.tipoPago}
                  onChange={handleChange}
                  disabled={tiposPago.length === 0} // Deshabilitar si no hay opciones
                >
                  {tiposPago.length > 0 ? (
                    tiposPago.map(tipo => (
                      <option key={tipo.idTipoPago} value={tipo.idTipoPago}>
                        {tipo.descripcionTipoPago}
                      </option>
                    ))
                  ) : (
                    <option value="">Cargando tipos de pago...</option>
                  )}
                </select>
              </div>
            </div>
          </div>
        </div>
        <div className="col-md-6">
          <h2 style={{ marginBottom: "25px", fontSize: "25px" }}>
            Productos en el carrito
          </h2>
          {renderCartItems()}
          <div className="row mt-3">
            <div className="col-8">
              <strong>Subtotal (sin I.V.A):</strong>
            </div>
            <div className="col-4 text-end">
              ₡{subtotal.toLocaleString()}
            </div>
          </div>
          <div className="row mt-3">
            <div className="col-8">
              <strong>Total (Con I.V.A):</strong>
            </div>
            <div className="col-4 text-end">
              ₡{montoTotalPedido.toLocaleString()}
            </div>
          </div>
          <div className="row mt-3">
            <div className="col-12 text-end">
              <button 
                className="btn btn-primary" 
                onClick={handleSubmit}
                disabled={isSubmitDisabled}
              >
                {status.loading ? (
                  <>
                    <FaSpinner className="spinner me-2" /> Procesando...
                  </>
                ) : (
                  'Finalizar Pedido'
                )}
              </button>
              {!cedulaValidation.isValid && cedulaValidation.wasChecked && (
                <p className="text-danger mt-2">
                  <small><FaTimes className="me-1" /> Debe ingresar una cédula válida para finalizar el pedido</small>
                </p>
              )}
            </div>
          </div>
        </div>
      </div>

      {/* Snackbar para mensajes de éxito/error */}
      <Snackbar 
        open={snackbar.open} 
        autoHideDuration={6000} 
        onClose={handleCloseSnackbar}
        anchorOrigin={{ vertical: 'bottom', horizontal: 'center' }}
      >
        <Alert onClose={handleCloseSnackbar} severity={snackbar.severity} sx={{ width: '100%' }}>
          {snackbar.message}
        </Alert>
      </Snackbar>

      {/* Para animar el spinner, añadimos estilos globales */}
      <style>
        {`
          .spinner {
            animation: spin 1s linear infinite;
          }
          @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
          }
        `}
      </style>
    </div>
  );
}

export default PedidoCrud;
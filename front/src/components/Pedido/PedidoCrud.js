import React, { useState, useEffect } from "react";
import "bootstrap/dist/css/bootstrap.min.css";
import '../styles.min.css';
import axios from "axios";
import Snackbar from '@mui/material/Snackbar';
import MuiAlert from '@mui/material/Alert';
import useAuth from '../../hooks/userInfo'; 
import { useNavigate } from 'react-router-dom';
import { useCart } from '../../contexto/ContextoCarrito';
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
    tipoPago: '' 
  });

  const {
      increaseQuantity,
      decreaseQuantity,
      removeFromCart,
      clearCart,
      showCartMenu,
      setShowCartMenu,
    } = useCart();

  

  const { usuario } = useAuth();
  const navigate = useNavigate();

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
  
  // Primero, modifiquemos el useEffect que actualmente carga el carrito desde localStorage
  useEffect(() => {
    // Verificar si hay un usuarioId guardado
    let usuarioId = localStorage.getItem("usuarioId");
    
    // Si no hay usuarioId almacenado, usar un ID predeterminado y guardarlo
    if (!usuarioId) {
      usuarioId = "56"; // ID predeterminado para pruebas
      localStorage.setItem("usuarioId", usuarioId);
    }
    
    console.log("ID de usuario usado para cargar los carritos:", usuarioId);
    
    const fetchCarritosUsuario = async () => {
      try {
        const response = await axios.get(`http://localhost:8080/carrito/usuario/${usuarioId}`);
        console.log('Datos de carritos obtenidos:', response.data);
        
        // Obtener carritos y productos del response
        const { carritos, productos } = response.data;
        
        // Si hay carritos disponibles
        if (carritos && carritos.length > 0) {
          // Filtrar solo los carritos activos
          const carritosActivos = carritos.filter(carrito => carrito[3] === true);
          
          if (carritosActivos.length > 0) {
            // Obtener todos los IDs de los carritos activos
            const idsCarritosActivos = carritosActivos.map(carrito => carrito[0]);
            
            // Recopilar todos los productos de todos los carritos activos
            const todosProductos = productos
              .filter(producto => idsCarritosActivos.includes(producto[1]))
              .map(producto => ({
                idCarritoProducto: producto[0],
                idCarrito: producto[1],
                idProducto: producto[2],
                cantidad: producto[3],
                nombreProducto: producto[8],
                imgProducto: producto[9],
                montoPrecioProducto: producto[10],
                descripcionProducto: producto[11],
                tipoPesoProducto: producto[12],
                codigoProducto: producto[13],
                stockProducto: producto[14],
                idCategoria: producto[15],
                estadoProducto: producto[16]
              }));
            
            setCart(todosProductos);
          } else {
            // No hay carritos activos, usar localStorage como respaldo
            const savedCart = JSON.parse(localStorage.getItem("carrito")) || [];
            setCart(savedCart);
          }
        } else {
          // No hay carritos disponibles, usar localStorage como respaldo
          const savedCart = JSON.parse(localStorage.getItem("carrito")) || [];
          setCart(savedCart);
        }
      } catch (error) {
        console.error('Error al obtener los carritos del usuario:', error);
        
        // Usar localStorage como respaldo
        const savedCart = JSON.parse(localStorage.getItem("carrito")) || [];
        setCart(savedCart);
      }
    };
    
    fetchCarritosUsuario();
    
    // Resto del código para obtener tipos de pago...
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
    // Obtener los IDs únicos de los carritos en el carrito actual
    const carritoIds = [...new Set(cart.map(item => item.idCarrito))];
    
    // Añadir los IDs de carrito al objeto userData
    const userData = {
      // Datos del usuario, sucursal, etc. (como ya los tienes)
      
      // Añadimos los IDs de carritos como string separado por comas
      carritosIds: carritoIds.join(','),
      
      // Tipo de pago
      tipoPago: {
        idTipoPago: formData.tipoPago
      },
      
      // Datos del pedido
      subtotal: subtotal,
      montoTotalPedido: montoTotalPedido,
      fechaPedido: new Date().toISOString(),
      estadoPedido: true,
      estadoEntregaPedido: "Pendiente",
      
      // Productos del carrito
      productos: cart.map(item => ({
        idProducto: item.idProducto,
        cantidad: item.cantidad,
        precioUnitario: item.montoPrecioProducto
      }))
    };

    console.log('Enviando datos:', JSON.stringify(userData, null, 2));

    const response = await axios.post('http://localhost:8080/pedido/agregar', userData);
    console.log('Pedido registrado de manera exitosa: '+response.data);

    // Ya no necesitamos actualizar los carritos aquí, el SP lo hará

    setStatus({ loading: false, error: null, success: true });

    setSnackbar({
      open: true,
      message: 'Pedido registrado de manera exitosa',
      severity: 'success'
    });

    // Limpiar localStorage y estado local
    localStorage.removeItem("carrito");
    setCart([]);

    setTimeout(() => {
      window.location.href = "/";
    }, 2000);

  } catch(error) {
      console.error('Error al registrar el pedido:', error);
  
      // Log más detallado para diagnosticar
      console.log('Detalles del error:', {
        status: error.response?.status,
        statusText: error.response?.statusText,
        data: error.response?.data,
        message: error.message,
        stack: error.stack
      });
      
      // Actualizar el estado para mostrar el error
      setStatus({ 
        loading: false, 
        error: error.response?.data?.message || "Error al procesar el pedido", 
        success: false 
      });
      
      // Mostrar mensaje de error con Snackbar
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

  const handlePagar = async () => {
    if (!usuario?.idUsuario) {
      navigate('/register');
      return;
    }

    try {
      const token = localStorage.getItem('token');
      const carritoLocal = JSON.parse(localStorage.getItem('carrito')) || [];
      
      if (carritoLocal.length === 0) {
        alert('El carrito está vacío');
        return;
      }

      // Calcular totales
      const total = carritoLocal.reduce((sum, item) => sum + (item.montoPrecioProducto || 0) * item.cantidad, 0);
      const cantidadTotal = carritoLocal.reduce((sum, item) => sum + item.cantidad, 0);

      // Crear objeto carrito como lo espera el backend
      const carritoData = {
        usuario: { idUsuario: usuario.idUsuario }, // Esto es lo más importante
        montoTotalCarrito: total,
        estadoCarrito: true,
        cantidadCarrito: cantidadTotal
      };

      // Primero crear el carrito
      const { data: carritoCreado } = await axios.post('http://localhost:8080/carrito', carritoData, {
        headers: { 'Authorization': `Bearer ${token}` }
      });

      // Luego agregar productos
      await Promise.all(
        carritoLocal.map(item => 
          axios.post(`http://localhost:8080/carrito/${carritoCreado.idCarrito}/productos`, {
            idProducto: item.idProducto,
            cantidadProducto: item.cantidad
          }, {
            headers: { 'Authorization': `Bearer ${token}` }
          })
        )
      );

      localStorage.removeItem('carrito');
      clearCart();
      navigate('/pedido', { 
        state: { 
          idCarrito: carritoCreado.idCarrito,
          total: total 
        }
      });

    } catch (error) {
      console.error('Error en el pago:', error);
      alert(error.response?.data?.message || 'Error al procesar el pago');
    }
  };

  return (
    <div className="container py-4 my-3">
      <h1 className="text-center" onClick={handlePagar}>Finalizar pedido</h1>

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
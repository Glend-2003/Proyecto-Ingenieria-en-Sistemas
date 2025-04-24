import React, { useState, useEffect } from "react";
import "bootstrap/dist/css/bootstrap.min.css";
import '../styles.min.css';
import './PedidoCrud.css';
import axios from "axios";
import Snackbar from '@mui/material/Snackbar';
import MuiAlert from '@mui/material/Alert';
import { FaSpinner, FaArrowLeft, FaCheck, FaTimes, FaShoppingCart, FaClock } from 'react-icons/fa';

function PedidoCrud() {
  // Estados para los campos del formulario
  const [formData, setFormData] = useState({
    nombreUsuario: '',
    primerApellido: '',
    segundoApellido: '',
    telefonoUsuario: '',
    correoUsuario: '',
    cedulaUsuario: '',
    // Valores fijos que no se editan
    sucursal: 'Cairo de Cariari',
    provincia: 'Limón',
    localidad: 'SuperMercado en el Centro Comercial',
    horaRetiro: '',
    tipoPago: ''
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

  // Estado para la validación de hora de retiro
  const [horaRetiroValidation, setHoraRetiroValidation] = useState({
    isValid: true,
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
            tipoPago: response.data[0].idTipoPago
          }));
        }
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
  const iva = subtotal * 0.13;
  const montoTotalPedido = subtotal + iva;

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

  // Función para validar la hora de retiro (entre 8:00 AM y 9:00 PM)
  const validateHoraRetiro = (hora) => {
    if (!hora) {
      setHoraRetiroValidation({
        isValid: false,
        wasChecked: true,
        message: 'Debe seleccionar una hora de retiro'
      });
      return false;
    }
    
    // Convertir la hora a minutos para facilitar la comparación
    const [horas, minutos] = hora.split(':').map(Number);
    const totalMinutos = horas * 60 + minutos;
    
    // 8:00 AM = 8 * 60 = 480 minutos
    // 9:00 PM = 21 * 60 = 1260 minutos
    const horaMinima = 8 * 60; // 8:00 AM
    const horaMaxima = 21 * 60; // 9:00 PM
    
    const isValid = totalMinutos >= horaMinima && totalMinutos <= horaMaxima;
    
    setHoraRetiroValidation({
      isValid: isValid,
      wasChecked: true,
      message: isValid ? '' : 'El horario de retiro debe ser entre 8:00 AM y 9:00 PM'
    });
    
    // Si no es válido, mostrar también un snackbar
    if (!isValid) {
      setSnackbar({
        open: true,
        message: 'El horario de retiro debe ser entre 8:00 AM y 9:00 PM',
        severity: 'warning'
      });
    }
    
    return isValid;
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
    
    // Si se cambia la hora de retiro, validar inmediatamente
    if (name === 'horaRetiro') {
      validateHoraRetiro(value);
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
    
    // Verificar que la hora de retiro sea válida
    if (!validateHoraRetiro(formData.horaRetiro)) {
      return;
    }
  
    setStatus({ loading: true, error: null, success: false });
  
    try {
      // Obtener el ID de usuario del localStorage o usar uno por defecto
      const idUsuario = localStorage.getItem("idUsuario");
      
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
        tipoPersona: "Física", // Valor por defecto ya que se eliminó el campo
        cedulaUsuario: formData.cedulaUsuario,
        tipoCedula: "Cédula Física", // Valor por defecto ya que se eliminó el campo
        
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
        <div className="cart-item" key={index}>
          <div className="cart-item-name">{item.nombreProducto || "Producto"} × {item.cantidad}</div>
          <div className="cart-item-price">₡{((item.montoPrecioProducto || 0) * item.cantidad).toLocaleString()}</div>
        </div>
      ));
    } else {
      return (
        <div className="empty-cart">
          <p>No hay productos en el carrito</p>
        </div>
      );
    }
  };

  // Determinar si el botón de finalizar debe estar deshabilitado
  const isSubmitDisabled = status.loading || 
                           tiposPago.length === 0 || 
                           !cedulaValidation.isValid || 
                           cedulaValidation.isChecking || 
                           !horaRetiroValidation.isValid ||
                           cart.length === 0;

  return (
    <div className="pedido-container">
      <div className="pedido-header">
        <h1>Finalizar pedido</h1>
        <button 
          className="btn-back" 
          onClick={() => window.history.back()}
        >
          <FaArrowLeft className="icon-back" /> Volver
        </button>
      </div>

      <div className="pedido-content">
        <div className="client-info-card">
          <div className="card-header">
            <h2>Información del cliente</h2>
          </div>
          <div className="card-body">
            <div className="form-row">
              <div className="form-group">
                <label htmlFor="nombreUsuario">Nombre</label>
                <input
                  type="text"
                  id="nombreUsuario"
                  name="nombreUsuario"
                  value={formData.nombreUsuario}
                  onChange={handleChange}
                  placeholder="Ingrese su nombre"
                />
              </div>
              <div className="form-group">
                <label htmlFor="primerApellido">Primer apellido</label>
                <input
                  type="text"
                  id="primerApellido"
                  name="primerApellido"
                  value={formData.primerApellido}
                  onChange={handleChange}
                  placeholder="Ingrese su primer apellido"
                />
              </div>
            </div>
            
            <div className="form-row">
              <div className="form-group">
                <label htmlFor="segundoApellido">Segundo apellido</label>
                <input
                  type="text"
                  id="segundoApellido"
                  name="segundoApellido"
                  value={formData.segundoApellido}
                  onChange={handleChange}
                  placeholder="Ingrese su segundo apellido"
                />
              </div>
              <div className="form-group">
                <label htmlFor="telefonoUsuario">Teléfono</label>
                <input
                  type="text"
                  id="telefonoUsuario"
                  name="telefonoUsuario"
                  value={formData.telefonoUsuario}
                  onChange={handleChange}
                  placeholder="Ej: 8888-8888"
                />
              </div>
            </div>
            
            <div className="form-row">
              <div className="form-group">
                <label htmlFor="correoUsuario">Correo electrónico</label>
                <input
                  type="email"
                  id="correoUsuario"
                  name="correoUsuario"
                  value={formData.correoUsuario}
                  onChange={handleChange}
                  placeholder="ejemplo@correo.com"
                />
              </div>
              <div className="form-group">
                <label htmlFor="cedulaUsuario">Cédula</label>
                <div className="cedula-input-group">
                  <input
                    type="text"
                    id="cedulaUsuario"
                    name="cedulaUsuario"
                    className={cedulaValidation.wasChecked ? (cedulaValidation.isValid ? 'valid' : 'invalid') : ''}
                    value={formData.cedulaUsuario}
                    onChange={handleChange}
                    placeholder="Ej: 101110111"
                  />
                  <div className="cedula-status">
                    {cedulaValidation.isChecking ? (
                      <FaSpinner className="spinner" />
                    ) : cedulaValidation.wasChecked ? (
                      cedulaValidation.isValid ? (
                        <FaCheck className="valid-icon" />
                      ) : (
                        <FaTimes className="invalid-icon" />
                      )
                    ) : null}
                  </div>
                </div>
                {cedulaValidation.wasChecked && (
                  <div className={`cedula-message ${cedulaValidation.isValid ? "valid-message" : "invalid-message"}`}>
                    {cedulaValidation.message}
                  </div>
                )}
              </div>
            </div>
            
            <div className="form-row">
              <div className="form-group">
                <label htmlFor="horaRetiro">
                  Hora de retiro
                  <span className="horario-info"> (8:00 AM - 9:00 PM)</span>
                </label>
                <div className="hora-input-group">
                  <input
                    type="time"
                    id="horaRetiro"
                    name="horaRetiro"
                    className={horaRetiroValidation.wasChecked ? (horaRetiroValidation.isValid ? 'valid' : 'invalid') : ''}
                    value={formData.horaRetiro}
                    onChange={handleChange}
                    min="08:00"
                    max="21:00"
                  />
                  <div className="hora-status">
                    {horaRetiroValidation.wasChecked && !horaRetiroValidation.isValid && (
                      <FaClock className="invalid-icon" />
                    )}
                  </div>
                </div>
                {horaRetiroValidation.wasChecked && !horaRetiroValidation.isValid && (
                  <div className="hora-message invalid-message">
                    {horaRetiroValidation.message}
                  </div>
                )}
              </div>
              <div className="form-group">
                <label htmlFor="tipoPago">Tipo de Pago</label>
                <select
                  id="tipoPago"
                  name="tipoPago"
                  value={formData.tipoPago}
                  onChange={handleChange}
                  disabled={tiposPago.length === 0}
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

        <div className="location-info-card">
          <div className="card-header">
            <h2>Información de la sucursal</h2>
          </div>
          <div className="card-body">
            <div className="location-item">
              <span className="location-label">Sucursal:</span>
              <span className="location-value">{formData.sucursal}</span>
            </div>
            <div className="location-item">
              <span className="location-label">Provincia:</span>
              <span className="location-value">{formData.provincia}</span>
            </div>
            <div className="location-item">
              <span className="location-label">Localidad:</span>
              <span className="location-value">{formData.localidad}</span>
            </div>
          </div>
        </div>

        <div className="cart-summary-card">
          <div className="card-header">
            <h2><FaShoppingCart className="cart-icon" /> Resumen del pedido</h2>
          </div>
          <div className="card-body">
            <div className="cart-items">
              {renderCartItems()}
            </div>
            
            <div className="cart-summary">
              <div className="summary-item">
                <span>Subtotal (sin I.V.A):</span>
                <span>₡{subtotal.toLocaleString()}</span>
              </div>
              <div className="summary-item">
                <span>I.V.A (13%):</span>
                <span>₡{iva.toLocaleString()}</span>
              </div>
              <div className="summary-item total">
                <span>Total a pagar:</span>
                <span>₡{montoTotalPedido.toLocaleString()}</span>
              </div>
            </div>
            
            <div className="submit-section">
              <button 
                className="btn-submit" 
                onClick={handleSubmit}
                disabled={isSubmitDisabled}
              >
                {status.loading ? (
                  <>
                    <FaSpinner className="spinner" /> Procesando...
                  </>
                ) : (
                  'Finalizar Pedido'
                )}
              </button>
              {!cedulaValidation.isValid && cedulaValidation.wasChecked && (
                <p className="validation-warning">
                  <FaTimes className="warning-icon" /> Debe ingresar una cédula válida para finalizar el pedido
                </p>
              )}
              {!horaRetiroValidation.isValid && horaRetiroValidation.wasChecked && (
                <p className="validation-warning">
                  <FaClock className="warning-icon" /> El horario de retiro debe ser entre 8:00 AM y 9:00 PM
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

      {/* Estilos para animación del spinner y elementos nuevos */}
      <style>
        {`
          .spinner {
            animation: spin 1s linear infinite;
          }
          @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
          }
          
          /* Estilos para la validación de la hora */
          .horario-info {
            font-size: 0.8em;
            color: #666;
            font-weight: normal;
          }
          
          .hora-input-group {
            position: relative;
            display: flex;
            align-items: center;
          }
          
          .hora-status {
            position: absolute;
            right: 10px;
            display: flex;
            align-items: center;
          }
          
          .hora-message {
            margin-top: 5px;
            font-size: 0.85em;
          }
          
          input[type="time"].valid {
            border-color: #4caf50;
          }
          
          input[type="time"].invalid {
            border-color: #f44336;
          }
          
          .invalid-message {
            color: #f44336;
          }
          
          .valid-message {
            color: #4caf50;
          }
        `}
      </style>
    </div>
  );
}

export default PedidoCrud;
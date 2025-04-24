import React, { useState, useEffect } from "react";
import "bootstrap/dist/css/bootstrap.min.css";
import '../styles.min.css';
import './PedidoCrud.css';
import axios from "axios";
import Snackbar from '@mui/material/Snackbar';
import MuiAlert from '@mui/material/Alert';
import { FaSpinner, FaArrowLeft, FaCheck, FaTimes, FaShoppingCart, FaClock, FaCalendarAlt } from 'react-icons/fa';

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
    fechaHoraRetiro: '', // Cambiado de horaRetiro a fechaHoraRetiro
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

  // Estado para la validación de fecha y hora de retiro
  const [fechaHoraRetiroValidation, setFechaHoraRetiroValidation] = useState({
    isValid: true,
    wasChecked: false,
    message: ''
  });

  // Estado para validaciones de campos de texto
  const [fieldValidations, setFieldValidations] = useState({
    nombreUsuario: { isValid: true, message: '' },
    primerApellido: { isValid: true, message: '' },
    segundoApellido: { isValid: true, message: '' },
    correoUsuario: { isValid: true, message: '' },
    telefonoUsuario: { isValid: true, message: '' }
  });

  // Estado para almacenar información del usuario logueado
  const [loggedUser, setLoggedUser] = useState({
    nombreUsuario: '',
    correoUsuario: ''
  });

  // Función para cerrar el Snackbar
  const handleCloseSnackbar = () => {
    setSnackbar({...snackbar, open: false});
  };

  // Recuperar carrito del localStorage
  const [cart, setCart] = useState([]);

  // Obtener información del usuario logueado
  useEffect(() => {
    // Intentar recuperar información del usuario del localStorage
    const userName = localStorage.getItem("nombreUsuario");
    const userEmail = localStorage.getItem("correoUsuario");
    
    if (userName && userEmail) {
      setLoggedUser({
        nombreUsuario: userName,
        correoUsuario: userEmail
      });
      
      // Pre-llenar los campos con la información del usuario logueado
      setFormData(prevData => ({
        ...prevData,
        nombreUsuario: userName,
        correoUsuario: userEmail
      }));
    }
  }, []);

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

  // Validar que solo se ingresen letras (para nombres y apellidos)
  const validateLettersOnly = (value, fieldName) => {
    // Expresión regular que permite solo letras, espacios y acentos (caracteres latinos)
    const lettersOnlyRegex = /^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$/;
    
    const isValid = value.trim() === '' || lettersOnlyRegex.test(value);
    
    setFieldValidations(prev => ({
      ...prev,
      [fieldName]: {
        isValid: isValid,
        message: isValid ? '' : 'Este campo solo permite letras'
      }
    }));
    
    return isValid;
  };

  // Validar formato de correo electrónico
  const validateEmail = (email) => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const isValid = email.trim() === '' || emailRegex.test(email);
    
    setFieldValidations(prev => ({
      ...prev,
      correoUsuario: {
        isValid: isValid,
        message: isValid ? '' : 'Formato de correo electrónico inválido'
      }
    }));
    
    return isValid;
  };

  // Validar que coincida con el usuario logueado
  const validateMatchWithLoggedUser = (value, fieldName) => {
    // Si no hay usuario logueado, no realizamos esta validación
    if (!loggedUser[fieldName]) return true;
    
    const isValid = value === loggedUser[fieldName];
    
    if (!isValid) {
      setFieldValidations(prev => ({
        ...prev,
        [fieldName]: {
          isValid: false,
          message: `Este valor debe coincidir con su ${fieldName === 'nombreUsuario' ? 'nombre de usuario' : 'correo'} registrado`
        }
      }));
    }
    
    return isValid;
  };

  // Validar teléfono
  const validatePhone = (phone) => {
    // Permitir un formato flexible para teléfonos, pero debe tener números
    const phoneRegex = /^\d{4}-?\d{4}$/;
    const isValid = phone.trim() === '' || phoneRegex.test(phone);
    
    setFieldValidations(prev => ({
      ...prev,
      telefonoUsuario: {
        isValid: isValid,
        message: isValid ? '' : 'Formato inválido. Use 8 dígitos (ej: 8888-8888)'
      }
    }));
    
    return isValid;
  };

  // Función para validar la cédula con la API de Hacienda
  const validateCedula = async (cedula) => {
    // Primero validamos que sean 9 dígitos numéricos
    const cedulaRegex = /^\d{9}$/;
    if (!cedulaRegex.test(cedula)) {
      setCedulaValidation({
        isValid: false,
        isChecking: false,
        wasChecked: true,
        message: 'La cédula debe contener exactamente 9 dígitos numéricos'
      });
      return;
    }
    
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

  // Función para validar la fecha y hora de retiro (entre 8:00 AM y 9:00 PM)
  const validateFechaHoraRetiro = (fechaHora) => {
    if (!fechaHora) {
      setFechaHoraRetiroValidation({
        isValid: false,
        wasChecked: true,
        message: 'Debe seleccionar una fecha y hora de retiro'
      });
      return false;
    }
    
    // Crear objeto Date a partir del string de fechaHora
    const dateTime = new Date(fechaHora);
    
    // Verificar que la fecha no sea anterior a hoy
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    
    if (dateTime < today) {
      setFechaHoraRetiroValidation({
        isValid: false,
        wasChecked: true,
        message: 'La fecha no puede ser anterior a hoy'
      });
      return false;
    }
    
    // Extraer la hora
    const hours = dateTime.getHours();
    const minutes = dateTime.getMinutes();
    
    // Convertir la hora a minutos para facilitar la comparación
    const totalMinutos = hours * 60 + minutes;
    
    // 8:00 AM = 8 * 60 = 480 minutos
    // 9:00 PM = 21 * 60 = 1260 minutos
    const horaMinima = 8 * 60; // 8:00 AM
    const horaMaxima = 21 * 60; // 9:00 PM
    
    const isValid = totalMinutos >= horaMinima && totalMinutos <= horaMaxima;
    
    setFechaHoraRetiroValidation({
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
    
    // Aplicar las validaciones según el campo
    if (name === 'nombreUsuario' || name === 'primerApellido' || name === 'segundoApellido') {
      validateLettersOnly(value, name);
      
      // Para el nombre de usuario, validar también que coincida con el usuario logueado
      if (name === 'nombreUsuario') {
        validateMatchWithLoggedUser(value, name);
      }
    } else if (name === 'correoUsuario') {
      validateEmail(value);
      validateMatchWithLoggedUser(value, name);
    } else if (name === 'telefonoUsuario') {
      validatePhone(value);
    } else if (name === 'cedulaUsuario') {
      // La validación de cédula se maneja con el efecto
      setCedulaValidation({
        isValid: false,
        isChecking: false,
        wasChecked: false,
        message: ''
      });
    } else if (name === 'fechaHoraRetiro') {
      validateFechaHoraRetiro(value);
    }
    
    setFormData({
      ...formData,
      [name]: value
    });
  };

  // Alert personalizado para Snackbar
  const Alert = React.forwardRef(function Alert(props, ref) {
    return <MuiAlert elevation={6} ref={ref} variant="filled" {...props} />;
  });

  // Función para verificar si hay errores de validación
  const hasValidationErrors = () => {
    // Verificar campos de texto
    for (const field in fieldValidations) {
      if (!fieldValidations[field].isValid) {
        return true;
      }
    }
    
    // Verificar cédula
    if (!cedulaValidation.isValid) {
      return true;
    }
    
    // Verificar fecha y hora
    if (!fechaHoraRetiroValidation.isValid) {
      return true;
    }
    
    return false;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    // Verificar todas las validaciones antes de enviar
    const nombreValid = validateLettersOnly(formData.nombreUsuario, 'nombreUsuario') && 
                         validateMatchWithLoggedUser(formData.nombreUsuario, 'nombreUsuario');
    const primerApellidoValid = validateLettersOnly(formData.primerApellido, 'primerApellido');
    const segundoApellidoValid = validateLettersOnly(formData.segundoApellido, 'segundoApellido');
    const correoValid = validateEmail(formData.correoUsuario) && 
                         validateMatchWithLoggedUser(formData.correoUsuario, 'correoUsuario');
    const telefonoValid = validatePhone(formData.telefonoUsuario);
    
    // Si alguna validación falla, mostrar mensaje y abortar
    if (!nombreValid || !primerApellidoValid || !segundoApellidoValid || !correoValid || !telefonoValid) {
      setSnackbar({
        open: true,
        message: 'Por favor, corrija los campos con errores antes de continuar',
        severity: 'error'
      });
      return;
    }
  
    // Verificar que la cédula sea válida antes de enviar
    if (!cedulaValidation.isValid) {
      setSnackbar({
        open: true,
        message: 'La cédula no es válida. No se puede procesar el pedido.',
        severity: 'error'
      });
      return;
    }
    
    // Verificar que la fecha y hora de retiro sea válida
    if (!validateFechaHoraRetiro(formData.fechaHoraRetiro)) {
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
      
      // Extraer la hora de la fecha y hora seleccionada
      const fechaHoraObj = new Date(formData.fechaHoraRetiro);
      const horaRetiro = `${fechaHoraObj.getHours().toString().padStart(2, '0')}:${fechaHoraObj.getMinutes().toString().padStart(2, '0')}`;
  
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
        horaRetiro: horaRetiro, // Solo la hora extraída de fechaHoraRetiro
        fechaRetiro: formData.fechaHoraRetiro.split('T')[0], // Solo la fecha extraída de fechaHoraRetiro
        
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
                           !fechaHoraRetiroValidation.isValid ||
                           cart.length === 0 ||
                           hasValidationErrors();

  // Función auxiliar para renderizar mensajes de error
  const renderErrorMessage = (fieldName) => {
    const field = fieldValidations[fieldName];
    if (!field.isValid && field.message) {
      return <div className="field-error-message">{field.message}</div>;
    }
    return null;
  };

  // Obtener la fecha mínima (hoy)
  const getMinDate = () => {
    const today = new Date();
    return today.toISOString().split('T')[0];
  };

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
                  className={fieldValidations.nombreUsuario.isValid ? '' : 'invalid'}
                  value={formData.nombreUsuario}
                  onChange={handleChange}
                  placeholder="Ingrese su nombre"
                />
                {renderErrorMessage('nombreUsuario')}
                {loggedUser.nombreUsuario && (
                  <div className="field-info-message">
                    
                  </div>
                )}
              </div>
              <div className="form-group">
                <label htmlFor="primerApellido">Primer apellido</label>
                <input
                  type="text"
                  id="primerApellido"
                  name="primerApellido"
                  className={fieldValidations.primerApellido.isValid ? '' : 'invalid'}
                  value={formData.primerApellido}
                  onChange={handleChange}
                  placeholder="Ingrese su primer apellido"
                />
                {renderErrorMessage('primerApellido')}
              </div>
            </div>
            
            <div className="form-row">
              <div className="form-group">
                <label htmlFor="segundoApellido">Segundo apellido</label>
                <input
                  type="text"
                  id="segundoApellido"
                  name="segundoApellido"
                  className={fieldValidations.segundoApellido.isValid ? '' : 'invalid'}
                  value={formData.segundoApellido}
                  onChange={handleChange}
                  placeholder="Ingrese su segundo apellido"
                />
                {renderErrorMessage('segundoApellido')}
              </div>
              <div className="form-group">
                <label htmlFor="telefonoUsuario">Teléfono</label>
                <input
                  type="text"
                  id="telefonoUsuario"
                  name="telefonoUsuario"
                  className={fieldValidations.telefonoUsuario.isValid ? '' : 'invalid'}
                  value={formData.telefonoUsuario}
                  onChange={handleChange}
                  placeholder="Ej: 8888-8888"
                />
                {renderErrorMessage('telefonoUsuario')}
              </div>
            </div>
            
            <div className="form-row">
              <div className="form-group">
                <label htmlFor="correoUsuario">Correo electrónico</label>
                <input
                  type="email"
                  id="correoUsuario"
                  name="correoUsuario"
                  className={fieldValidations.correoUsuario.isValid ? '' : 'invalid'}
                  value={formData.correoUsuario}
                  onChange={handleChange}
                  placeholder="ejemplo@correo.com"
                />
                {renderErrorMessage('correoUsuario')}
                {loggedUser.correoUsuario && (
                  <div className="field-info-message">
                   
                  </div>
                )}
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
                    maxLength={9}
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
                <label htmlFor="fechaHoraRetiro">
                  Fecha y hora de retiro
                  <span className="horario-info"> (8:00 AM - 9:00 PM)</span>
                </label>
                <div className="fecha-hora-input-group">
                  <input
                    type="datetime-local"
                    id="fechaHoraRetiro"
                    name="fechaHoraRetiro"
                    className={fechaHoraRetiroValidation.wasChecked ? (fechaHoraRetiroValidation.isValid ? 'valid' : 'invalid') : ''}
                    value={formData.fechaHoraRetiro}
                    onChange={handleChange}
                    min={`${getMinDate()}T08:00`}
                  />
                  <div className="fecha-hora-status">
                    {fechaHoraRetiroValidation.wasChecked && !fechaHoraRetiroValidation.isValid && (
                      <FaCalendarAlt className="invalid-icon" />
                    )}
                  </div>
                </div>
                {fechaHoraRetiroValidation.wasChecked && !fechaHoraRetiroValidation.isValid && (
                  <div className="fecha-hora-message invalid-message">
                    {fechaHoraRetiroValidation.message}
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
              {!fechaHoraRetiroValidation.isValid && fechaHoraRetiroValidation.wasChecked && (
                <p className="validation-warning">
                  <FaCalendarAlt className="warning-icon" /> Debe seleccionar una fecha y hora de retiro dentro del horario permitido
                </p>
              )}
              {Object.keys(fieldValidations).some(key => !fieldValidations[key].isValid) && (
                <p className="validation-warning">
                  <FaTimes className="warning-icon" /> Por favor, corrija los campos con errores antes de continuar
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
          
          /* Estilos para los mensajes de error en campos */
          .field-error-message {
            color: #f44336;
            font-size: 0.85em;
            margin-top: 5px;
          }
          
          .field-info-message {
            color: #2196F3;
            font-size: 0.85em;
            margin-top: 5px;
          }
          
          /* Estilos para inputs inválidos */
          input.invalid, select.invalid {
            border-color: #f44336;
            background-color: rgba(244, 67, 54, 0.05);
          }
          
          /* Estilos para la validación de fecha/hora */
          .fecha-hora-input-group {
            position: relative;
            display: flex;
            align-items: center;
          }
          
          .fecha-hora-status {
            position: absolute;
            right: 10px;
            display: flex;
            align-items: center;
          }
          
          .fecha-hora-message {
            margin-top: 5px;
            font-size: 0.85em;
          }
          
          input[type="datetime-local"].valid {
            border-color: #4caf50;
          }
          
          input[type="datetime-local"].invalid {
            border-color: #f44336;
          }
          
          /* Hora de retiro */
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
          
          /* Mensajes de validación */
          .invalid-message {
            color: #f44336;
          }
          
          .valid-message {
            color: #4caf50;
          }
          
          /* Iconos de validación */
          .valid-icon {
            color: #4caf50;
          }
          
          .invalid-icon {
            color: #f44336;
          }
          
          .warning-icon {
            margin-right: 5px;
          }
        `}
      </style>
    </div>
  );
}

export default PedidoCrud;
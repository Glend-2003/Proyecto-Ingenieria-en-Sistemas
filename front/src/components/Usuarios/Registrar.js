import React, { useState, useEffect } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import Snackbar from "@mui/material/Snackbar";
import MuiAlert from "@mui/material/Alert";
import "./Registrar.css";
import FooterApp from '../Footer/FooterApp';

const Registrar = () => {
  const [correoUsuario, setEmail] = useState("");
  const [nombreUsuario, setName] = useState("");
  const [primerApellido, setFirstSurname] = useState("");
  const [segundoApellido, setSecondSurname] = useState("");
  const [contraseniaUsuario, setPassword] = useState("");
  const [verifyPassword, setVerifyPassword] = useState("");
  const [passwordVisible, setPasswordVisible] = useState(false);
  const [verifyPasswordVisible, setVerifyPasswordVisible] = useState(false);

  // Estados para manejo de errores
  const [formErrors, setFormErrors] = useState({});

  // Alert component
  const Alert = React.forwardRef(function Alert(props, ref) {
    return <MuiAlert elevation={6} ref={ref} variant="filled" {...props} />;
  });

  // Snackbar states
  const [openSnackbar, setOpenSnackbar] = useState(false);
  const [snackbarMessage, setSnackbarMessage] = useState("");
  const [snackbarSeverity, setSnackbarSeverity] = useState("success");

  const navigate = useNavigate();

  useEffect(() => {
    // No es necesario añadir clases al body, ya que el fondo
    // se manejará directamente en el CSS global
    
    // Limpieza al desmontar
    return () => {};
  }, []);

  // Validación de email
  const validateEmail = (email) => {
    const regex = /^[^@]+@[^@]+\.[^@]+$/;
    return regex.test(email);
  };

  // Validación de formulario completo
  const validateForm = () => {
    const errors = {};
    
    // Validar correo
    if (!correoUsuario) {
      errors.email = "El correo electrónico es obligatorio";
    } else if (!validateEmail(correoUsuario)) {
      errors.email = "Formato de correo inválido";
    }
    
    // Validar nombre
    if (!nombreUsuario) {
      errors.name = "El nombre es obligatorio";
    }
    
    // Validar primer apellido
    if (!primerApellido) {
      errors.firstSurname = "El primer apellido es obligatorio";
    }
    
    // Validar segundo apellido
    if (!segundoApellido) {
      errors.secondSurname = "El segundo apellido es obligatorio";
    }
    
    // Validar contraseña
    if (!contraseniaUsuario) {
      errors.password = "La contraseña es obligatoria";
    } else if (contraseniaUsuario.length < 8) {
      errors.password = "La contraseña debe tener al menos 8 caracteres";
    } else if (!/(?=.*[A-Za-z]{2,})/.test(contraseniaUsuario)) {
      errors.password = "La contraseña debe contener al menos 2 letras";
    }
    
    // Validar confirmación de contraseña
    if (!verifyPassword) {
      errors.verifyPassword = "Por favor confirme la contraseña";
    } else if (verifyPassword !== contraseniaUsuario) {
      errors.verifyPassword = "Las contraseñas no coinciden";
    }
    
    return errors;
  };

  // Manejadores de cambios en los campos
  const handleInputChange = (e, field) => {
    const value = e.target.value;
    
    // Actualizar el estado según el campo
    switch(field) {
      case 'email':
        setEmail(value);
        break;
      case 'name':
        setName(value);
        break;
      case 'firstSurname':
        setFirstSurname(value);
        break;
      case 'secondSurname':
        setSecondSurname(value);
        break;
      case 'password':
        setPassword(value);
        break;
      case 'verifyPassword':
        setVerifyPassword(value);
        break;
      default:
        break;
    }
    
    // Limpiar error específico si el usuario está corrigiendo
    if (formErrors[field]) {
      setFormErrors({
        ...formErrors,
        [field]: ""
      });
    }
  };

  // Manejadores para mostrar/ocultar contraseña
  const togglePasswordVisibility = () => {
    setPasswordVisible(!passwordVisible);
  };

  const toggleVerifyPasswordVisibility = () => {
    setVerifyPasswordVisible(!verifyPasswordVisible);
  };

  // Manejadores de Snackbar
  const handleOpenSnackbar = (message, severity) => {
    setSnackbarMessage(message);
    setSnackbarSeverity(severity);
    setOpenSnackbar(true);
  };
  
  const handleCloseSnackbar = (event, reason) => {
    if (reason === 'clickaway') {
      return;
    }
    setOpenSnackbar(false);
  };

  // Volver a la página de inicio de sesión
  const handleGoBack = () => {
    navigate("../");
  };

  // Envío del formulario
  const handleSubmit = (e) => {
    e.preventDefault();
    
    // Validar formulario
    const errors = validateForm();
    
    // Si hay errores, mostrarlos y no enviar el formulario
    if (Object.keys(errors).length > 0) {
      setFormErrors(errors);
      handleOpenSnackbar("Por favor, complete correctamente todos los campos", "error");
      return;
    }

    // Datos a enviar
    const registroData = {
      correoUsuario,
      nombreUsuario,
      primerApellido,
      segundoApellido,
      contraseniaUsuario,
    };

    // Enviar datos al backend
    axios
      .post("http://localhost:8080/usuario/registrar", registroData)
      .then((response) => {
        console.log("Usuario registrado con éxito:", response.data);
        handleOpenSnackbar("Usuario registrado con éxito", "success");
        setTimeout(() => {
          navigate("../");
        }, 2000);
      })
      .catch((error) => {
        console.error("Error al registrar usuario:", error);
        
        if (error.response) {
          // El servidor respondió con un código de estado fuera del rango 2xx
          const errorMessage = error.response.data.message || "Error al registrar usuario";
          handleOpenSnackbar(errorMessage, "error");
        } else if (error.request) {
          // La solicitud fue realizada pero no se recibió respuesta
          handleOpenSnackbar("No se pudo contactar con el servidor", "error");
        } else {
          // Algo ocurrió en la configuración de la solicitud
          handleOpenSnackbar("Error en la solicitud", "error");
        }
      });
  };

  return (
    <div className="register-container">
      <div className="register-card">
        <div className="register-header">
          <div className="shield-icon"></div>
          <h2>Crear una cuenta</h2>
        </div>
        
        <form className="register-form" onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="correoUsuario">Correo Electrónico</label>
            <input
              type="email"
              id="correoUsuario"
              className={formErrors.email ? "input-error" : ""}
              value={correoUsuario}
              onChange={(e) => handleInputChange(e, 'email')}
            />
            {formErrors.email && <span className="error-message">{formErrors.email}</span>}
          </div>
          
          <div className="form-row">
            <div className="form-group">
              <label htmlFor="nombreUsuario">Nombre</label>
              <input
                type="text"
                id="nombreUsuario"
                className={formErrors.name ? "input-error" : ""}
                value={nombreUsuario}
                onChange={(e) => handleInputChange(e, 'name')}
              />
              {formErrors.name && <span className="error-message">{formErrors.name}</span>}
            </div>
            
            <div className="form-group">
              <label htmlFor="primerApellido">Primer Apellido</label>
              <input
                type="text"
                id="primerApellido"
                className={formErrors.firstSurname ? "input-error" : ""}
                value={primerApellido}
                onChange={(e) => handleInputChange(e, 'firstSurname')}
              />
              {formErrors.firstSurname && <span className="error-message">{formErrors.firstSurname}</span>}
            </div>
            
            <div className="form-group">
              <label htmlFor="segundoApellido">Segundo Apellido</label>
              <input
                type="text"
                id="segundoApellido"
                className={formErrors.secondSurname ? "input-error" : ""}
                value={segundoApellido}
                onChange={(e) => handleInputChange(e, 'secondSurname')}
              />
              {formErrors.secondSurname && <span className="error-message">{formErrors.secondSurname}</span>}
            </div>
          </div>
          
          <div className="form-row">
            <div className="form-group">
              <label htmlFor="contraseniaUsuario">Contraseña</label>
              <div className="password-container">
                <input
                  type={passwordVisible ? "text" : "password"}
                  id="contraseniaUsuario"
                  className={formErrors.password ? "input-error" : ""}
                  value={contraseniaUsuario}
                  onChange={(e) => handleInputChange(e, 'password')}
                />
                <span className="password-toggle" onClick={togglePasswordVisibility}>
                  <img 
                    src={passwordVisible ? "/eye-slash.svg" : "/eye.svg"} 
                    alt={passwordVisible ? "Ocultar contraseña" : "Mostrar contraseña"}
                    className="eye-icon"
                  />
                </span>
              </div>
              {formErrors.password && <span className="error-message">{formErrors.password}</span>}
              <div className="password-requirements">
                <span>• Mínimo 8 caracteres</span>
                <span>• Al menos 2 letras (mayúsculas o minúsculas)</span>
              </div>
            </div>
            
            <div className="form-group">
              <label htmlFor="verifyPassword">Confirmar Contraseña</label>
              <div className="password-container">
                <input
                  type={verifyPasswordVisible ? "text" : "password"}
                  id="verifyPassword"
                  className={formErrors.verifyPassword ? "input-error" : ""}
                  value={verifyPassword}
                  onChange={(e) => handleInputChange(e, 'verifyPassword')}
                />
                <span className="password-toggle" onClick={toggleVerifyPasswordVisibility}>
                  <img 
                    src={verifyPasswordVisible ? "/eye-slash.svg" : "/eye.svg"} 
                    alt={verifyPasswordVisible ? "Ocultar contraseña" : "Mostrar contraseña"}
                    className="eye-icon"
                  />
                </span>
              </div>
              {formErrors.verifyPassword && <span className="error-message">{formErrors.verifyPassword}</span>}
            </div>
          </div>
          
          <button type="submit" className="register-button">
            Registrar cuenta
          </button>
          
          <div className="back-link">
            <span onClick={handleGoBack}>
              <span className="back-arrow">←</span> Volver al inicio de sesión
            </span>
          </div>
        </form>
      </div>
      
      <Snackbar
        open={openSnackbar}
        autoHideDuration={3000}
        onClose={handleCloseSnackbar}
        anchorOrigin={{ vertical: 'top', horizontal: 'center' }}
      >
        <Alert onClose={handleCloseSnackbar} severity={snackbarSeverity}>
          {snackbarMessage}
        </Alert>
      </Snackbar>
      
      {/* Footer */}
      <div className="footer">
        <p>Contactos</p>
      </div>
    </div>
  );
};

export default Registrar;
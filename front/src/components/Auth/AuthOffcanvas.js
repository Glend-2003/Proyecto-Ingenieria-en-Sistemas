// src/components/Auth/AuthOffcanvas.js
import React, { useState, useEffect } from 'react';
import { Offcanvas } from 'react-bootstrap';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import { useAppContext } from "../Navbar/AppContext"; // Asegúrate que la ruta sea correcta
import { FaEye, FaEyeSlash, FaSpinner, FaArrowLeft } from 'react-icons/fa';
import { toast } from 'react-toastify'; // Si usas react-toastify para notificaciones
// Importa tus estilos si son específicos para este Offcanvas, por ejemplo:
// import './AuthOffcanvas.css'; // O usa los de Login.css si aplican
// Importa también los estilos de Login.css si los necesitas aquí
import '../Login/Login.css'; // Ajusta la ruta si es necesario

const AuthOffcanvas = () => {
  const { showSidebar, handleShowSidebar, updateUserStatus } = useAppContext();
  const navigate = useNavigate();

  const [loginData, setLoginData] = useState({
    correoUsuario: "",
    contraseniaUsuario: "",
  });
  const [showForgotPassword, setShowForgotPassword] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [rememberMe, setRememberMe] = useState(false);
  const [emailValidationTimer, setEmailValidationTimer] = useState(null);

  useEffect(() => {
    const rememberedEmail = localStorage.getItem("rememberedEmail");
    if (rememberedEmail && showSidebar) { // Solo carga si el sidebar se va a mostrar
      setLoginData(prev => ({ ...prev, correoUsuario: rememberedEmail }));
      setRememberMe(true);
    }
    return () => {
      if (emailValidationTimer) clearTimeout(emailValidationTimer);
    };
  }, [showSidebar]); // Depende de showSidebar para actuar solo cuando se abre

  const validateEmail = (email) => email && email.includes("@");

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setLoginData({
      ...loginData,
      [name]: value,
    });

    if (name === "correoUsuario" && value && !validateEmail(value)) {
      if (value.length > 3) {
        clearTimeout(emailValidationTimer);
        const timer = setTimeout(() => {
          toast.warn(`Incluye un signo '@' en la dirección de correo electrónico. La dirección "${value}" no incluye el signo '@'.`);
        }, 1000);
        setEmailValidationTimer(timer);
      }
    }
  };

  const login = async (e) => {
    e.preventDefault(); // Prevenir el envío del formulario si se llama desde el evento onSubmit
    if (!loginData.correoUsuario || !loginData.contraseniaUsuario) {
      toast.warn("Por favor completa todos los campos requeridos");
      return;
    }
    if (!validateEmail(loginData.correoUsuario)) {
        toast.warn(`Incluye un signo '@' en la dirección de correo electrónico. La dirección "${loginData.correoUsuario}" no incluye el signo '@'.`);
        return;
    }

    setIsLoading(true);
    try {
      const response = await axios.post("http://localhost:8080/usuario/login", loginData);
      setIsLoading(false);

      if (response.data.token) {
        localStorage.setItem("token", response.data.token);
        localStorage.setItem("correoUsuario", response.data.correoUsuario);
        localStorage.setItem("nombreUsuario", response.data.nombreUsuario);
        localStorage.setItem("nombreRol", response.data.rol.nombreRol);
        localStorage.setItem("idUsuario", response.data.idUsuario);

        if (rememberMe) {
          localStorage.setItem("rememberedEmail", loginData.correoUsuario);
          // Considera no guardar la contraseña o hacerlo de forma más segura si es estrictamente necesario
        } else {
          localStorage.removeItem("rememberedEmail");
        }
        updateUserStatus(); // Actualiza el estado global del usuario
        //toast.success(`Bienvenido ${response.data.nombreUsuario}`);
        handleShowSidebar(); // Cierra el sidebar al iniciar sesión

        // Redirección basada en rol
        if (response.data.rol.nombreRol === "Administrador" || response.data.rol.nombreRol === "Gerente") {
          navigate("/principal");
        } else { // Usuario u otros roles
          navigate("/"); // O a /Dashboard si es para clientes
        }
      } else {
        toast.error("Credenciales no válidas.");
      }
    } catch (error) {
      setIsLoading(false);
      const errorMsg = error.response?.data?.message || error.response?.data || "Error en el ingreso";
      toast.error(errorMsg);
    }
  };

  const handleForgotPassword = async (e) => {
    e.preventDefault();
    if (!loginData.correoUsuario) {
      toast.warn("Por favor, ingresa tu correo electrónico");
      return;
    }
    if (!validateEmail(loginData.correoUsuario)) {
      toast.warn(`Formato de correo inválido: "${loginData.correoUsuario}".`);
      return;
    }

    setIsLoading(true);
    try {
      const response = await axios.post("http://localhost:8080/usuario/verificarCambioContrasena", {
        correoUsuario: loginData.correoUsuario,
      });
      if (response.status === 200) {
        toast.success("Código enviado con éxito a tu correo.");
        navigate("/ResetPassword", { state: { correoUsuario: loginData.correoUsuario } });
        handleShowSidebar(); // Cierra el sidebar
      }
    } catch (error) {
      const errorMsg = error.response?.data || "Error al enviar el código.";
      toast.error(errorMsg);
    } finally {
      setIsLoading(false);
    }
  };

  // Limpiar formulario cuando el sidebar se cierra o cambia el modo
  useEffect(() => {
    if (!showSidebar) {
      setLoginData({ correoUsuario: localStorage.getItem("rememberedEmail") || "", contraseniaUsuario: "" });
      setShowForgotPassword(false);
      setIsLoading(false);
    } else if (showForgotPassword){
       setLoginData(prev => ({ ...prev, contraseniaUsuario: "" })); // Limpiar contraseña al cambiar a forgot password
    }
  }, [showSidebar, showForgotPassword]);


  return (
    <Offcanvas show={showSidebar} onHide={handleShowSidebar} placement="end" className="login-sidebar">
      <Offcanvas.Header closeButton className="login-header">
        <Offcanvas.Title className="login-title">
          {showForgotPassword ? "Recuperar contraseña" : "Iniciar sesión"}
        </Offcanvas.Title>
      </Offcanvas.Header>
      <Offcanvas.Body>
        {!showForgotPassword ? (
          <div className="auth-form-container">
            <form onSubmit={login}>
              <div className="form-group">
                <label htmlFor="authOffcanvasCorreoUsuario">Correo electrónico</label>
                <input
                  id="authOffcanvasCorreoUsuario"
                  type="email"
                  name="correoUsuario"
                  value={loginData.correoUsuario}
                  onChange={handleInputChange}
                  placeholder="ejemplo@correo.com"
                  className="form-control"
                  required
                />
              </div>
              <div className="form-group">
                <label htmlFor="authOffcanvasContraseniaUsuario">Contraseña</label>
                <div className="password-input-container">
                  <input
                    id="authOffcanvasContraseniaUsuario"
                    type={showPassword ? "text" : "password"}
                    name="contraseniaUsuario"
                    value={loginData.contraseniaUsuario}
                    onChange={handleInputChange}
                    placeholder="Ingresa tu contraseña"
                    className="form-control"
                    required
                  />
                  <span
                    className="password-toggle-icon"
                    onClick={() => setShowPassword(!showPassword)}
                  >
                    {showPassword ? <FaEyeSlash /> : <FaEye />}
                  </span>
                </div>
              </div>
              <div className="options-container">

                <button
                  className="forgot-password-link"
                  onClick={() => setShowForgotPassword(true)}
                  type="button"
                >
                  ¿Perdiste tu contraseña?
                </button>
              </div>
              <button className="btn-acceso" disabled={isLoading} type="submit">
                {isLoading ? (<><FaSpinner className="spinner" /><span>Accediendo...</span></>) : "Acceso"}
              </button>
              <div className="create-account-section">
                <div className="divider"><span>O</span></div>
                <div className="user-icon-container">
                  <svg xmlns="http://www.w3.org/2000/svg" width="2.5em" height="2.5em" fill="currentColor" className="bi bi-person" viewBox="0 0 16 16">
                    <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664z" />
                  </svg>
                </div>
                <p className="no-account-text">¿Aún no tienes cuenta?</p>
                <button type="button" className="btn-crear-cuenta" onClick={() => { navigate('/register'); handleShowSidebar(); }}>
                  Crear una cuenta
                </button>
              </div>
            </form>
          </div>
        ) : (
          <div className="auth-form-container">
            <div className="reset-message">
              <p>Ingresa tu correo para verificar que eres tú. Te enviaremos un código para restablecer tu contraseña.</p>
            </div>
            <form onSubmit={handleForgotPassword}>
              <div className="form-group">
                <label htmlFor="authOffcanvasForgotCorreo">Correo electrónico</label>
                <input
                  id="authOffcanvasForgotCorreo"
                  type="email"
                  name="correoUsuario" // Asegúrate que el nombre coincida para que handleInputChange funcione
                  value={loginData.correoUsuario}
                  onChange={handleInputChange}
                  placeholder="correo@ejemplo.com"
                  className="form-control"
                  required
                />
              </div>
              <button type="submit" className="btn-acceso" disabled={isLoading}>
                {isLoading ? (<><FaSpinner className="spinner" /><span>Enviando...</span></>) : "Enviar código"}
              </button>
            </form>
            <button type="button" className="btn-volver" onClick={() => setShowForgotPassword(false)}>
              <FaArrowLeft /> Volver al inicio de sesión
            </button>
          </div>
        )}
      </Offcanvas.Body>
    </Offcanvas>
  );
};

export default AuthOffcanvas;
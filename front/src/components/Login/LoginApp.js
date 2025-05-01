import React, { useState, useEffect } from "react"
import axios from "axios"
import { useNavigate, useLocation } from "react-router-dom"
import "bootstrap/dist/css/bootstrap.min.css"
import "../styles.min.css"
import { Offcanvas } from "react-bootstrap"
import ListaProductosApp from "../Catalogo/ListaProductosApp.js"
import PedidoCrud from "../Pedido/PedidoCrud.js"
import { toast } from "react-toastify"
import "../Login/Login.css"
import FooterApp from "../Footer/FooterApp"
import Snackbar from "@mui/material/Snackbar"
import MuiAlert from "@mui/material/Alert"
import { FaEye, FaEyeSlash, FaSpinner, FaArrowLeft, FaExclamationTriangle, FaCheckCircle, FaInfoCircle } from "react-icons/fa"
import { FaWhatsapp, FaFacebook } from "react-icons/fa";
import NavbarApp from "../Navbar/NavbarApp.js"
import Carrito from "../Carrito/CarritoApp"
import { useAppContext } from "../Navbar/AppContext"
import Historia from "../Home/Historia.js"
import MostrarOrdenApp from "../Orden/MostrarOdenApp.js"
import ResPagina from "../../paginas/ResPagina.js"
import CerdoPagina from "../../paginas/CerdoPagina.js"
import PolloPagina from "../../paginas/PolloPagina.js"
import ProductosVariosPagina from "../../paginas/ProductosVariosPagina.js"
import ProductosDestacadosPagina from "../../paginas/ProductosDestacadosPagina.js"

// Componente de alerta personalizado y centralizado
const CentralizedAlert = React.forwardRef(function Alert(props, ref) {
  // Personalización del icono según el tipo de alerta
  const renderIcon = () => {
    switch (props.severity) {
      case 'error':
        return <FaExclamationTriangle className="alert-icon" />;
      case 'success':
        return <FaCheckCircle className="alert-icon" />;
      case 'warning':
        return <FaExclamationTriangle className="alert-icon" />;
      case 'info':
      default:
        return <FaInfoCircle className="alert-icon" />;
    }
  };

  // Colores personalizados para las alertas
  const getAlertStyle = () => {
    const baseStyle = {
      borderRadius: '8px',
      display: 'flex',
      alignItems: 'center',
      padding: '10px 16px',
      boxShadow: '0 4px 12px rgba(0,0,0,0.12)',
      width: '100%',
      animation: 'slideDown 0.3s ease-out forwards'
    };

    // Personalización por tipo de alerta
    switch (props.severity) {
      case 'error':
        return { ...baseStyle, backgroundColor: '#FEE9E7', color: '#C53030', border: '1px solid #FBD5D2' };
      case 'warning':
        return { ...baseStyle, backgroundColor: '#FEFCEE', color: '#704D02', border: '1px solid #FAECC2' };
      case 'success':
        return { ...baseStyle, backgroundColor: '#E9F6EC', color: '#276749', border: '1px solid #C6F6D5' };
      case 'info':
      default:
        return { ...baseStyle, backgroundColor: '#EBF8FF', color: '#2A4365', border: '1px solid #BEE3F8' };
    }
  };

  return (
    <div ref={ref} className="centralized-alert" style={getAlertStyle()}>
      <div className="alert-icon-container" style={{ marginRight: '12px' }}>
        {renderIcon()}
      </div>
      <div className="alert-content" style={{ flex: 1 }}>
        <div className="alert-message" style={{ fontWeight: '500', fontSize: '14px' }}>
          {props.children}
        </div>
      </div>
      {props.onClose && (
        <button
          className="alert-close"
          onClick={props.onClose}
          style={{ background: 'none', border: 'none', cursor: 'pointer', marginLeft: '12px', opacity: 0.7 }}
        >
          ×
        </button>
      )}
    </div>
  );
});

function LoginApp({ initialPage = "home" }) {
  const [currentPage, setCurrentPage] = useState(initialPage)
  const location = useLocation()

  const [loginData, setLoginData] = useState({
    correoUsuario: "",
    contraseniaUsuario: "",
  })
  const [fieldErrors, setFieldErrors] = useState({
    correoUsuario: "",
    contraseniaUsuario: ""
  })
  const [loginStatus, setLoginStatus] = useState("")
  const navigate = useNavigate()
  const [isOpen, setIsOpen] = useState(false)
  const [productos, setProductos] = useState([])
  const [rememberMe, setRememberMe] = useState(false)
  const [emailValidationTimer, setEmailValidationTimer] = useState(null)

  // Usar el contexto para obtener estados y funciones
  const { showSidebar, handleShowSidebar, addToCart } = useAppContext()

  // Estados para alertas mejoradas y centralizadas
  const [alert, setAlert] = useState({
    open: false,
    message: "",
    severity: "info",
    vertical: "top",
    horizontal: "center",
    duration: 6000
  })

  // Función para mostrar alertas mejoradas
  const showAlert = (message, severity = "info", vertical = "top", horizontal = "center", duration = 6000) => {
    setAlert({
      open: true,
      message,
      severity,
      vertical,
      horizontal,
      duration
    })
  }

  // Cerrar alerta
  const handleCloseAlert = () => {
    setAlert({ ...alert, open: false })
  }

  // Detectar cambios en la URL para actualizar currentPage
  useEffect(() => {
    console.log("Ruta actual:", location.pathname);

    // Mapeo directo entre rutas y páginas
    const pathToPage = {
      "/pedido": "pedido",
      "/Historia": "historia",
      "/verOrden": "verOrden",
      "/cortes-de-res": "res",
      "/cortes-de-cerdo": "cerdo",
      "/cortes-de-pollo": "pollo",
      "/productos-varios": "varios",
      "/productos-destacados": "destacados",
      "/": "home"
    };

    if (pathToPage[location.pathname]) {
      setCurrentPage(pathToPage[location.pathname]);
      console.log("Página establecida a:", pathToPage[location.pathname]);
    }
  }, [location.pathname]);

  // Validar formato de correo electrónico
  const validateEmail = (email) => {
    return email && email.includes('@')
  }

  // Validar contraseña (que no esté vacía)
  const validatePassword = (password) => {
    return password && password.length > 0
  }

  // Validar todos los campos con alertas centralizadas
  const validateFields = () => {
    let isValid = true

    // Validar correo
    if (!loginData.correoUsuario) {
      isValid = false
      showAlert("Por favor, ingresa tu correo electrónico", "warning")
    } else if (!validateEmail(loginData.correoUsuario)) {
      isValid = false
      showAlert(`Incluye un signo '@' en la dirección de correo electrónico. La dirección "${loginData.correoUsuario}" no incluye el signo '@'.`, "warning")
    }

    // Validar contraseña
    if (!loginData.contraseniaUsuario) {
      isValid = false
      showAlert("Por favor, ingresa tu contraseña", "warning")
    }

    return isValid
  }

  // Función para cambiar la página actual
  const renderMainContent = () => {
    switch (currentPage) {
      case "pedido":
        return <PedidoCrud />
      case "historia":
        return <Historia />
      case "verOrden":
        return <MostrarOrdenApp />
      case "res":
        return <ResPagina />
      case "cerdo":
        return <CerdoPagina />
      case "pollo":
        return <PolloPagina />
      case "varios":
        return <ProductosVariosPagina />
      case "destacados":
        return <ProductosDestacadosPagina />
      case "home":
      default:
        return <ListaProductosApp addToCart={addToCart} />
    }
  }

  useEffect(() => {
    const rememberedEmail = localStorage.getItem("rememberedEmail")
    const rememberedPassword = localStorage.getItem("rememberedPassword")

    if (rememberedEmail && rememberedPassword) {
      setLoginData({
        correoUsuario: rememberedEmail,
        contraseniaUsuario: rememberedPassword,
      })
      setRememberMe(true) // Marcar el checkbox si hay credenciales guardadas
    }

    // Limpiar el timer cuando el componente se desmonte
    return () => {
      if (emailValidationTimer) clearTimeout(emailValidationTimer);
    };
  }, [])

  const handleLogout = () => {
    localStorage.removeItem("token")
    localStorage.removeItem("correoUsuario")
    localStorage.removeItem("nombreUsuario")
    localStorage.removeItem("nombreRol")
    localStorage.removeItem("idUsuario")
    localStorage.removeItem("rememberedEmail")
    localStorage.removeItem("rememberedPassword")
    navigate("/")
  }

  const [showForgotPassword, setShowForgotPassword] = useState(false) // Estado para mostrar el formulario de "Olvidé mi contraseña"
  const [showPassword, setShowPassword] = useState(false)
  const [isLoading, setIsLoading] = useState(false) // Estado para el spinner

  // Función para manejar el cambio en los inputs del formulario con validación centralizada
  const handleInputChange = (e) => {
    const { name, value } = e.target
    setLoginData({
      ...loginData,
      [name]: value,
    })

    // Si es el campo de correo y no está vacío, validar formato
    if (name === "correoUsuario" && value && !validateEmail(value)) {
      // Mostrar alerta solo cuando el usuario deje de escribir por un momento
      if (value.length > 3) {
        clearTimeout(emailValidationTimer);
        const timer = setTimeout(() => {
          showAlert(`Incluye un signo '@' en la dirección de correo electrónico. La dirección "${value}" no incluye el signo '@'.`, "warning")
        }, 1000)
        setEmailValidationTimer(timer);
      }
    }
  }

  const login = () => {
    // Validar campos antes de intentar login
    if (!validateFields()) {
      // Mostrar alerta si hay campos vacíos
      if (!loginData.correoUsuario || !loginData.contraseniaUsuario) {
        showAlert("Por favor completa todos los campos requeridos", "warning");
      }
      return;
    }

    setIsLoading(true);

    axios
      .post("http://localhost:8080/usuario/login", loginData)
      .then((response) => {
        setIsLoading(false);

        if (response.data.token) {
          localStorage.setItem("token", response.data.token);
          localStorage.setItem("correoUsuario", response.data.correoUsuario);
          localStorage.setItem("nombreUsuario", response.data.nombreUsuario);
          localStorage.setItem("nombreRol", response.data.rol.nombreRol);
          localStorage.setItem("idUsuario", response.data.idUsuario);

          if (rememberMe) {
            localStorage.setItem("rememberedEmail", loginData.correoUsuario);
            localStorage.setItem("rememberedPassword", loginData.contraseniaUsuario);
          } else {
            localStorage.removeItem("rememberedEmail");
            localStorage.removeItem("rememberedPassword");
          }

          // Mostrar alerta de éxito
          showAlert(`Bienvenido ${response.data.nombreUsuario} a Carnicería La Bendición`, "success");

          setTimeout(() => {
            if (
              response.data.rol.nombreRol === "Administrador" ||
              response.data.rol.nombreRol === "Usuario" ||
              response.data.rol.nombreRol === "Gerente"
            ) {
              navigate("/principal");
            }

            if (response.data.rol.nombreRol === "Usuario") {
              navigate("/");
              handleShowSidebar(); // Usar la función del contexto
            }
          }, 2000); // (2 segundos) para que la alerta se muestre

          setLoginStatus("Login exitoso. Bienvenido " + response.data.nombreUsuario);
        } else {
          showAlert("Credenciales no válidas. Por favor verifica tu correo y contraseña", "error");
          setLoginStatus("Credenciales incorrectas");
        }
      })
      .catch((error) => {
        setIsLoading(false);
        console.error("Error en el login:", error.response ? error.response.data : error.message);

        // Manejar diferentes tipos de errores
        if (!error.response) {
          showAlert("Error de conexión. Verifica tu conexión a internet o inténtalo más tarde", "error");
        } else if (error.response.status === 401) {
          showAlert("Correo o contraseña incorrectos", "error");
        } else if (error.response.status === 404) {
          showAlert("El usuario no existe en nuestro sistema", "error");
        } else if (error.response.status === 500) {
          showAlert("Error en el servidor. Por favor inténtalo más tarde", "error");
        } else {
          showAlert("Error en el ingreso: " + (error.response.data?.message || error.response.data || "Error desconocido"), "error");
        }

        setLoginStatus("Error en el servidor o en las credenciales");
      });
  }

  const handleSubmit = (e) => {
    e.preventDefault()
    login()
  }

  const handleForgotPassword = async (e) => {
    e.preventDefault(); // Evita que el formulario se envíe automáticamente

    if (!loginData.correoUsuario) {
      showAlert("Por favor, ingresa tu correo electrónico", "warning");
      return;
    }

    // Validar formato de correo
    if (!validateEmail(loginData.correoUsuario)) {
      showAlert(`Incluye un signo '@' en la dirección de correo electrónico. La dirección "${loginData.correoUsuario}" no incluye el signo '@'.`, "warning");
      return;
    }

    setIsLoading(true); // Activar el spinner

    try {
      const response = await axios.post("http://localhost:8080/usuario/verificarCambioContrasena", {
        correoUsuario: loginData.correoUsuario,
      });

      if (response.status === 200) {
        showAlert("Código enviado con éxito a tu correo electrónico", "success");

        // Esperar 2 segundos antes de redirigir
        setTimeout(() => {
          navigate("/ResetPassword", { state: { correoUsuario: loginData.correoUsuario } });
        }, 2000);
      }
    } catch (error) {
      if (!error.response) {
        showAlert("Error de conexión. Verifica tu conexión a internet", "error");
      } else if (error.response.status === 404) {
        showAlert("El correo electrónico no existe en nuestro sistema", "error");
      } else {
        showAlert("Error al enviar el código: " + (error.response?.data?.message || "Correo inexistente"), "error");
      }
    } finally {
      setIsLoading(false); // Desactivar el spinner
    }
  }

  return (
    <div className="page-container">
      {/* Navbar Component */}
      <NavbarApp />

      {/* Alerta Centralizada */}
      <div className="alert-container" style={{
        display: alert.open ? 'flex' : 'none',
        position: 'fixed',
        top: '20px',
        left: '50%',
        transform: 'translateX(-50%)',
        zIndex: 9999,
        width: '100%',
        maxWidth: '500px',
        justifyContent: 'center'
      }}>
        <CentralizedAlert
          severity={alert.severity}
          onClose={handleCloseAlert}
        >
          {alert.message}
        </CentralizedAlert>
      </div>

      {/* Offcanvas Sidebar */}

      {/* Reemplaza el contenido de Offcanvas con este código */}
{/* Reemplaza el Offcanvas actual con este código */}
<Offcanvas show={showSidebar} onHide={handleShowSidebar} placement="end" className="login-sidebar">
  <Offcanvas.Header closeButton className="login-header">
    <Offcanvas.Title className="login-title">
      {showForgotPassword ? "Recuperar contraseña" : "Iniciar sesión"}
    </Offcanvas.Title>
  </Offcanvas.Header>
  <Offcanvas.Body>
    {!showForgotPassword ? (
      // Formulario de inicio de sesión mejorado
      <div className="auth-form-container">
        <form onSubmit={handleSubmit}>
          {/* Campo de correo */}
          <div className="form-group">
            <label htmlFor="correoUsuario">Correo electrónico</label>
            <input
              id="correoUsuario"
              type="email"
              name="correoUsuario"
              value={loginData.correoUsuario}
              onChange={handleInputChange}
              placeholder="ejemplo@correo.com"
              className="form-control"
              required
            />
          </div>

          {/* Campo de contraseña */}
          <div className="form-group">
            <label htmlFor="contraseniaUsuario">Contraseña</label>
            <div className="password-input-container">
              <input
                id="contraseniaUsuario"
                type={showPassword ? "text" : "password"}
                name="contraseniaUsuario"
                value={loginData.contraseniaUsuario}
                onChange={handleInputChange}
                placeholder="Ingresa tu contraseña"
                className="form-control"
                required
              />
              {/* Ícono para mostrar/ocultar contraseña */}
              <span
                className="password-toggle-icon"
                onClick={() => setShowPassword(!showPassword)}
              >
                {showPassword ? <FaEyeSlash /> : <FaEye />}
              </span>
            </div>
          </div>

          {/* Opciones adicionales */}
          <div className="options-container">
            <div className="remember-me">
              <input
                className="form-check-input"
                type="checkbox"
                id="rememberMe"
                checked={rememberMe}
                onChange={(e) => setRememberMe(e.target.checked)}
              />
              <label className="form-check-label" htmlFor="rememberMe">
                Acuérdate de mí
              </label>
            </div>
            <button
              className="forgot-password-link"
              onClick={() => setShowForgotPassword(true)}
              type="button"
            >
              ¿Perdiste tu contraseña?
            </button>
          </div>

          {/* Botón de acceso con spinner */}
          <button
            className="btn-acceso"
            disabled={isLoading}
            type="submit"
          >
            {isLoading ? (
              <>
                <FaSpinner className="spinner" />
                <span>Accediendo...</span>
              </>
            ) : "Acceso"}
          </button>

          {/* Sección "Crear una cuenta" */}
          <div className="create-account-section">
            <div className="divider">
              <span>O</span>
            </div>
            <div className="user-icon-container">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="2.5em"
                height="2.5em"
                fill="currentColor"
                className="bi bi-person"
                viewBox="0 0 16 16"
              >
                <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664z" />
              </svg>
            </div>
            <p className="no-account-text">¿Aún no tienes cuenta?</p>
            <a href="/register" className="btn-crear-cuenta">
              Crear una cuenta
            </a>
          </div>
        </form>
      </div>
    ) : (
      // Formulario de "Olvidé mi contraseña" mejorado
      <div className="auth-form-container">
        <div className="reset-message">
          <p>Ingresa tu correo para verificar que eres tú.</p>
          <p>Te enviaremos un código para restablecer tu contraseña.</p>
        </div>

        <form onSubmit={handleForgotPassword}>
          <div className="form-group">
            <label htmlFor="correoUsuario">Correo electrónico</label>
            <input
              id="correoUsuario"
              type="email"
              name="correoUsuario"
              value={loginData.correoUsuario}
              onChange={handleInputChange}
              placeholder="correo@ejemplo.com"
              className="form-control"
              required
            />
          </div>

          <button
            type="submit"
            className="btn-acceso"
            disabled={isLoading}
          >
            {isLoading ? (
              <>
                <FaSpinner className="spinner" />
                <span>Enviando...</span>
              </>
            ) : "Enviar código"}
          </button>
        </form>

        <button
          type="button"
          className="btn-volver"
          onClick={() => setShowForgotPassword(false)}
        >
          <FaArrowLeft /> Volver al inicio de sesión
        </button>
      </div>
    )}
  </Offcanvas.Body>
</Offcanvas>
      {/* Contenido principal */}
      <main className="flex-grow-2" style={{ marginTop: "80px" }}>
        {renderMainContent()}
        <Carrito />
      </main>

      {/* Footer */}
      <FooterApp />
    </div>
  )
}

export default LoginApp
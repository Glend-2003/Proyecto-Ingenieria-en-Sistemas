import React, { useState, useEffect } from "react"
import axios from "axios"
import { useNavigate, useLocation } from "react-router-dom"
import "bootstrap/dist/css/bootstrap.min.css"
import "../styles.min.css"
import { Offcanvas } from "react-bootstrap"
import ListaProductosApp from "../Catalogo/ListaProductosApp.js"
import PedidoCrud from "../Pedido/PedidoCrud.js"
import { toast } from "react-toastify"
import "../Login/Login.css" // Importación de estilos que ahora incluye los iconos sociales
import FooterApp from "../Footer/FooterApp"
import Snackbar from "@mui/material/Snackbar"
import MuiAlert from "@mui/material/Alert"
import { FaEye, FaEyeSlash, FaSpinner, FaArrowLeft } from "react-icons/fa";
import NavbarApp from "../Navbar/NavbarApp.js"
import Carrito from "../Carrito/CarritoApp"
import { useAppContext } from "../Navbar/AppContext"
import { useCart } from '../../contexto/ContextoCarrito'  // Importar useCart
import Historia from "../Home/Historia.js"
import MostrarOrdenApp from "../Orden/MostrarOdenApp.js"
import ResPagina from "../../paginas/ResPagina.js"
import CerdoPagina from "../../paginas/CerdoPagina.js"
import PolloPagina from "../../paginas/PolloPagina.js"
import ProductosVariosPagina from "../../paginas/ProductosVariosPagina.js"
import ProductosDestacadosPagina from "../../paginas/ProductosDestacadosPagina.js"

function LoginApp({ initialPage = "home" }) {
  const [currentPage, setCurrentPage] = useState(initialPage)
  const location = useLocation()

  const [loginData, setLoginData] = useState({
    correoUsuario: "",
    contraseniaUsuario: "",
  })
  const [loginStatus, setLoginStatus] = useState("")
  const navigate = useNavigate()
  const [isOpen, setIsOpen] = useState(false)
  const [productos, setProductos] = useState([])
  const [rememberMe, setRememberMe] = useState(false)

  // Usar el contexto para obtener estados y funciones
  const { showSidebar, handleShowSidebar, addToCart, updateUserStatus  } = useAppContext()
  const { showCartMenu } = useCart(); // Obtener el estado del carrito


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

  // Definir el componente Alert para Snackbar
  const Alert = React.forwardRef(function Alert(props, ref) {
    return <MuiAlert elevation={6} ref={ref} variant="filled" {...props} />
  })

  // Estados para manejar el Snackbar
  const [openSnackbar, setOpenSnackbar] = useState(false)
  const [snackbarMessage, setSnackbarMessage] = useState("")
  const [snackbarSeverity, setSnackbarSeverity] = useState("success") // 'success', 'error', 'warning', 'info'

  // Función para abrir el Snackbar
  const handleOpenSnackbar = (message, severity) => {
    setSnackbarMessage(message)
    setSnackbarSeverity(severity)
    setOpenSnackbar(true)
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
  }, [])

  
  const [showForgotPassword, setShowForgotPassword] = useState(false) // Estado para mostrar el formulario de "Olvidé mi contraseña"
  const [showPassword, setShowPassword] = useState(false)
  const [isLoading, setIsLoading] = useState(false) // Estado para el spinner

  // Función para cerrar el Snackbar
  const handleCloseSnackbar = (event, reason) => {
    if (reason === "clickaway") {
      return
    }
    setOpenSnackbar(false)
  }

  // Función para manejar el cambio en los inputs del formulario
  const handleInputChange = (e) => {
    const { name, value } = e.target
    setLoginData({
      ...loginData,
      [name]: value,
    })
  }

  const login = () => {
    axios
      .post("http://localhost:8080/usuario/login", loginData)
      .then((response) => {
        if (response.data.token) {
          localStorage.setItem("token", response.data.token)
          localStorage.setItem("correoUsuario", response.data.correoUsuario)
          localStorage.setItem("nombreUsuario", response.data.nombreUsuario)
          localStorage.setItem("nombreRol", response.data.rol.nombreRol)
          localStorage.setItem("idUsuario", response.data.idUsuario)
          updateUserStatus(); 
          if (rememberMe) {
            localStorage.setItem("rememberedEmail", loginData.correoUsuario)
            localStorage.setItem("rememberedPassword", loginData.contraseniaUsuario)
          } else {
            localStorage.removeItem("rememberedEmail")
            localStorage.removeItem("rememberedPassword")
          }

          // Mostrar Snackbar de éxito
          handleOpenSnackbar("Bienvenido a Carnoiceria La Bendición.", "success")

          setTimeout(() => {
            if (
              response.data.rol.nombreRol === "Administrador" ||
              response.data.rol.nombreRol === "Usuario" ||
              response.data.rol.nombreRol === "Gerente"
            ) {
              navigate("/principal")
            }

            if (response.data.rol.nombreRol === "Usuario") {
              navigate("/")
              handleShowSidebar() // Usar la función del contexto
            }
          }, 2000) // (2 segundos) para que el Snackbar se muestre

          setLoginStatus("Login exitoso. Bienvenido " + response.data.nombreUsuario)
        } else {
          handleOpenSnackbar("Error en el ingreso, verificar datos!", "error")
          setLoginStatus("Credenciales incorrectas")
        }
      })
      .catch((error) => {
        console.error("Error en el login:", error.response ? error.response.data : error.message)

        handleOpenSnackbar("Error en el ingreso, " + error.response.data, "error")
        setLoginStatus("Error en el servidor o en las credenciales")
      })
  }

  const handleSubmit = (e) => {
    e.preventDefault()
    login()
  }

  const handleForgotPassword = async (e) => {
    e.preventDefault() // Evita que el formulario se envíe automáticamente

    if (!loginData.correoUsuario) {
      toast.error("Por favor, ingresa tu correo electrónico")
      return
    }

    try {
      const response = await axios.post("http://localhost:8080/usuario/verificarCambioContrasena", {
        correoUsuario: loginData.correoUsuario,
      })

      if (response.status === 200) {
        toast.success("Código enviado con éxito", {
          autoClose: 2000, // Duración de la alerta (2 segundos)
          onClose: () => {
            // Redirigir después de que la alerta se cierre
            navigate("/ResetPassword", { state: { correoUsuario: loginData.correoUsuario } })
          },
        })
      }
    } catch (error) {
      toast.error("Correo inexistente", {
        autoClose: 3000, // Duración de la alerta (3 segundos)
      })
    } finally {
      // setIsLoading(false); // Desactivar el spinner
    }
  }

  return (
    <div className="page-container">
      {/* Navbar Component */}
      <NavbarApp />
      
      {/* Se eliminaron los iconos de redes sociales ya que ahora están en el footer */}

      {/* Offcanvas Sidebar */}
      <Offcanvas
        show={showSidebar}
        onHide={handleShowSidebar}
        placement="end"
        style={{
          position: 'fixed',
          top: '0',
          zIndex: 1200, // Mayor que el zIndex del navbar (1100)
          height: '100vh'
        }}
      >
        <Offcanvas.Header closeButton>
          <Offcanvas.Title style={{ fontSize: "24px", fontWeight: "bold", color: "#333" }}>
            {showForgotPassword ? "Recuperar contraseña" : "Iniciar sesión"}
          </Offcanvas.Title>
        </Offcanvas.Header>
        <Offcanvas.Body>
          {/* Contenido del Offcanvas.Body */}
          {!showForgotPassword ? (
            // Formulario de inicio de sesión
            <form onSubmit={handleSubmit}>
              {/* Campo de correo */}
              <div className="mb-3">
                <label htmlFor="correoUsuario" className="form-label">
                  Correo electrónico
                </label>
                <input
                  className="form-control"
                  type="email"
                  name="correoUsuario"
                  id="correoUsuario"
                  value={loginData.correoUsuario}
                  onChange={handleInputChange}
                  required
                />
              </div>

              {/* Campo de contraseña */}
              <div className="mb-3 position-relative">
                <label htmlFor="contraseniaUsuario" className="form-label">
                  Contraseña
                </label>
                <input
                  className="form-control"
                  type={showPassword ? "text" : "password"}
                  name="contraseniaUsuario"
                  id="contraseniaUsuario"
                  value={loginData.contraseniaUsuario}
                  onChange={handleInputChange}
                  required
                />
                {/* Ícono para mostrar/ocultar contraseña */}
                <span
                  className="position-absolute end-0 me-3"
                  style={{
                    cursor: "pointer",
                    top: "60%",
                    transform: "translateY(-22%)",
                  }}
                  onClick={() => setShowPassword(!showPassword)}
                >
                  {showPassword ? <FaEyeSlash /> : <FaEye />}
                </span>
              </div>

              {/* Botón de acceso */}
              <div className="mb-3">
                <button className="btn btn-primary d-block w-100" type="submit">
                  Acceso
                </button>
              </div>

              {/* Opciones adicionales */}
              <div className="form-check text-start mb-3">
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
                <button className="btn btn-link float-end text-muted" onClick={() => setShowForgotPassword(true)}>
                  ¿Perdiste tu contraseña?
                </button>
              </div>

              {/* Botón "Crear una cuenta" */}
              <div className="text-center mt-4">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="3em"
                  height="3em"
                  fill="currentColor"
                  className="bi bi-person"
                  viewBox="0 0 16 16"
                >
                  <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664z" />
                </svg>
                <p className="mt-3">¿Aún no tienes cuenta?</p>
                <a href="/register" className="btn btn-secondary d-block w-50 mx-auto">
                  Crear una cuenta
                </a>
              </div>
            </form>
          ) : (
            // Formulario de "Olvidé mi contraseña"
            <form onSubmit={handleForgotPassword}>
              {/* Contenido del formulario de recuperación (código existente) */}
              <p className="mb-4" style={{ fontSize: "16px", color: "#555", lineHeight: "1.9" }}>
                Ingresa tu correo para verificar que eres tú.<br />
                Te enviaremos un código para restablecer tu contraseña.
              </p>

              <div className="mb-3">
                <label
                  htmlFor="correoUsuario"
                  className="form-label"
                  style={{ fontSize: "16px", color: "#333", fontWeight: "500" }}
                >
                  Correo electrónico
                </label>
                <input
                  className="form-control"
                  type="email"
                  name="correoUsuario"
                  id="correoUsuario"
                  value={loginData.correoUsuario}
                  onChange={handleInputChange}
                  required
                  style={{ fontSize: "16px", padding: "10px", width: "100%", maxWidth: "400px", margin: "0 auto" }}
                />
              </div>

              <div className="mb-3">
                <button
                  className="btn btn-primary d-block w-100"
                  type="submit"
                  disabled={isLoading}
                  style={{
                    fontSize: "16px",
                    padding: "6px",
                    maxWidth: "400px",
                    margin: "0 auto",
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                    gap: "8px",
                  }}
                >
                  {isLoading ? (
                    <>
                      <FaSpinner className="spinner" />
                      Enviando...
                    </>
                  ) : (
                    "Enviar"
                  )}
                </button>
              </div>

              <hr />
              <div className="text-center mt-4">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="3em"
                  height="3em"
                  fill="currentColor"
                  className="bi bi-person"
                  viewBox="0 0 16 16"
                >
                  <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664z" />
                </svg>
                <p className="mt-3">¿Aún no tienes cuenta?</p>
                <a href="/register" className="btn btn-secondary d-block w-50 mx-auto">
                  Crear una cuenta
                </a>
              </div>
              <div className="text-center">
                <button
                  type="button"
                  className="btn btn-link"
                  onClick={() => setShowForgotPassword(false)}
                  style={{
                    color: "#333",
                    textDecoration: "none",
                    fontSize: "16px",
                    fontWeight: "500",
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                    gap: "8px",
                  }}
                >
                  <FaArrowLeft /> Volver
                </button>
              </div>
            </form>
          )}
        </Offcanvas.Body>
      </Offcanvas>

      {/* Contenido principal modificado para usar renderMainContent */}
      <main className="flex-grow-2" style={{ marginTop: "80px" }}>
        {renderMainContent()}
        <Carrito />
      </main>
      {/* Footer */}
      <FooterApp />
      {/* Snackbar para mostrar alertas */}
      <Snackbar
        open={openSnackbar}
        autoHideDuration={6000}
        onClose={handleCloseSnackbar}
        anchorOrigin={{ vertical: "top", horizontal: "right" }}
      >
        <Alert onClose={handleCloseSnackbar} severity={snackbarSeverity} sx={{ width: "100%" }}>
          {snackbarMessage}
        </Alert>
      </Snackbar>
    </div>
  )
}

export default LoginApp
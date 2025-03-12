import React, { useState, useEffect } from "react";
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import '../styles.min.css';
import { Offcanvas, Navbar, Container, Nav, Button, ListGroup, Badge } from 'react-bootstrap';
import Carrito from '../Carrito/CarritoApp.js';
import ListaProductosApp from '../Catalogo/ListaProductosApp.js';
import DropDown from "../DropDown/DropDown";
import { toast } from 'react-toastify';
import './Login.css';
import { FaArrowLeft, FaEye, FaEyeSlash, FaSpinner } from 'react-icons/fa';

function LoginApp() {
  const [loginData, setLoginData] = useState({
    correoUsuario: '',
    contraseniaUsuario: '',
  });
  const [showSidebar, setShowSidebar] = useState(false);
  const [showCart, setShowCart] = useState(false);
  const savedCart = JSON.parse(localStorage.getItem("carrito")) || [];
  const [loginStatus, setLoginStatus] = useState('');
  const navigate = useNavigate();
  const idUsuario = localStorage.getItem('idUsuario');
  const [isOpen, setIsOpen] = useState(false);
  const [cart, setCart] = useState([]);
  const [productos, setProductos] = useState([]);
  const [showForgotPassword, setShowForgotPassword] = useState(false); // Estado para mostrar el formulario de "Olvidé mi contraseña"
  const [showPassword, setShowPassword] = useState(false);
  const [isLoading, setIsLoading] = useState(false); // Estado para el spinner

  const addToCart = (producto) => {
    setCart((prevCart) => {
      const existingItem = prevCart.find(item => item.idProducto === producto.idProducto);
      if (existingItem) {
        return prevCart.map(item =>
          item.idProducto === producto.idProducto
            ? { ...item, cantidad: item.cantidad + 1 }
            : item
        );
      } else {
        return [...prevCart, { ...producto, cantidad: 1 }];
      }
    });
  };

  const addToCart2 = (producto) => {
    const userCart = {
      ...producto,
      usuarioId: idUsuario,
    };
    setCart((prevCart) => [...prevCart, userCart]);
  };

  useEffect(() => {
    if (cart.length > 0 && cart[0].usuarioId !== idUsuario) {
      setCart([]);
      localStorage.setItem("carrito", JSON.stringify([]));
    } else {
      localStorage.setItem("carrito", JSON.stringify(cart));
    }
    cargarProductos();
  }, [cart, idUsuario]);

  const cargarProductos = async () => {
    try {
      const response = await axios.get("http://localhost:8080/producto/");
      setProductos(response.data);
    } catch (error) {
      console.error("Error al cargar productos:", error);
      toast.error("Ocurrió un error al cargar los productos");
    }
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setLoginData({
      ...loginData,
      [name]: value,
    });
  };

  const handleShowSidebar = () => setShowSidebar(!showSidebar && !idUsuario);
  const handleShowCart = () => setShowCart(!showCart);

  const removeFromCart = (indexToRemove) => {
    const updatedCart = cart.filter((_, idx) => idx !== indexToRemove);
    setCart(updatedCart);
    localStorage.setItem("carrito", JSON.stringify(updatedCart));
    toast.info("Producto eliminado del carrito");
  };

  const removeFromCart2 = (indexToRemove) => {
    setCart((prevCart) => prevCart.filter((_, idx) => idx !== indexToRemove));
  };

  const login = () => {
    axios
      .post('http://localhost:8080/usuario/login', loginData)
      .then((response) => {
        if (response.data.token) {
          localStorage.setItem('token', response.data.token);
          localStorage.setItem('correoUsuario', response.data.correoUsuario);
          localStorage.setItem('nombreUsuario', response.data.nombreUsuario);
          localStorage.setItem('nombreRol', response.data.rol.nombreRol);
          localStorage.setItem('idUsuario', response.data.idUsuario);

          setLoginStatus('Login exitoso. Bienvenido ' + response.data.nombreUsuario);

          if (
            response.data.rol.nombreRol === 'Administrador' ||
            response.data.rol.nombreRol === 'Usuario' ||
            response.data.rol.nombreRol === 'Gerente'
          ) {
            navigate('/principal');
          } else if (response.data.rol.nombreRol === 'Usuario') {
            navigate('/');
            setShowSidebar(false);
          } else {
            setLoginStatus('Rol no reconocido');
          }
        } else {
          setLoginStatus('Credenciales incorrectas');
        }
      })
      .catch((error) => {
        console.error('Error en el login:', error.response ? error.response.data : error.message);
        setLoginStatus('Error en el servidor o en las credenciales');
      });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    login();
  };

  const handleForgotPassword = async (e) => {
    e.preventDefault(); // Evita que el formulario se envíe automáticamente
  
    if (!loginData.correoUsuario) {
      toast.error("Por favor, ingresa tu correo electrónico");
      return;
    }
  
   // setIsLoading(true); // Activar el spinner
  
    try {
      const response = await axios.post("http://localhost:8080/usuario/verificarCambioContrasena", {
        correoUsuario: loginData.correoUsuario,
      });
  
      if (response.status === 200) {
        toast.success("Código enviado con éxito", {
          autoClose: 2000, // Duración de la alerta (2 segundos)
          onClose: () => {
            // Redirigir después de que la alerta se cierre
            navigate('/reset-password', { state: { correoUsuario: loginData.correoUsuario } });
          },
        });
      }
    } catch (error) {
      toast.error("Correo inexistente", {
        autoClose: 3000, // Duración de la alerta (3 segundos)
      });
    } finally {
     // setIsLoading(false); // Desactivar el spinner
    }
  };

  return (
    <>
      {/* Navbar */}
      <Navbar expand="lg" variant="dark" style={{ backgroundColor: '#001f3f' }}>
        <Container>
          <Navbar.Toggle aria-controls="basic-navbar-nav" />
          <Navbar.Collapse id="basic-navbar-nav">
            <Nav className="ms-auto">
              <div>
                <Nav.Link onClick={handleShowSidebar}>
                  <DropDown icon={<svg xmlns="http://www.w3.org/2000/svg" width="1.5em" height="1.5em" fill="currentColor" className="bi bi-person" viewBox="0 0 16 16">
                    <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664z" />
                  </svg>} idUsuario={idUsuario} />
                </Nav.Link>
              </div>
              <Nav.Link onClick={handleShowCart}>
                <svg xmlns="http://www.w3.org/2000/svg" width="1.5em" height="1.5em" fill="currentColor" className="bi bi-cart" viewBox="0 0 16 16">
                  <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5M3.102 4l1.313 7h8.17l1.313-7zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4m7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4m-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2m7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2" />
                </svg>
                {cart.length > 0 && <Badge bg="danger">{cart.length}</Badge>}
              </Nav.Link>
            </Nav>
          </Navbar.Collapse>
        </Container>
      </Navbar>

      {/* Offcanvas Sidebar */}
      <Offcanvas show={showSidebar} onHide={handleShowSidebar} placement="end">
        <Offcanvas.Header closeButton>
          <Offcanvas.Title style={{ fontSize: '24px', fontWeight: 'bold', color: '#333' }}>
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
                <label htmlFor="correoUsuario" className="form-label">Correo electrónico</label>
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
                <label htmlFor="contraseniaUsuario" className="form-label">Contraseña</label>
                <input
                  className="form-control"
                  type={showPassword ? "text" : "password"} // Alternar entre texto y contraseña
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
                    cursor: 'pointer',
                    top: '60%', // Ajusta este valor para bajar el ícono
                    transform: 'translateY(-22%)' // Mantén esto para centrar verticalmente
                  }}
                  onClick={() => setShowPassword(!showPassword)}
                >
                  {showPassword ? <FaEyeSlash /> : <FaEye />} {/* Íconos de ojo */}
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
                <input className="form-check-input" type="checkbox" id="rememberMe" />
                <label className="form-check-label" htmlFor="rememberMe">
                  Acuérdate de mí
                </label>
                <button
                  className="btn btn-link float-end text-muted"
                  onClick={() => setShowForgotPassword(true)}
                >
                  ¿Perdiste tu contraseña?
                </button>
              </div>

              {/* Botón "Crear una cuenta" */}
              <div className="text-center mt-4">
                <svg xmlns="http://www.w3.org/2000/svg" width="3em" height="3em" fill="currentColor" className="bi bi-person" viewBox="0 0 16 16">
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
            {/* Mensaje descriptivo */}
            <p className="mb-4" style={{ fontSize: '16px', color: '#555', lineHeight: '1.9' }}>
              Ingresa tu correo electrónico para verificar que eres tú. Te enviaremos un código para restablecer tu contraseña.
            </p>

            {/* Campo de correo */}
            <div className="mb-3">
              <label htmlFor="correoUsuario" className="form-label" style={{ fontSize: '16px', color: '#333', fontWeight: '500' }}>
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
                style={{ fontSize: '16px', padding: '10px', width: '100%', maxWidth: '400px', margin: '0 auto' }}
              />
            </div>

            {/* Botón de enviar código */}
            <div className="mb-3">
              <button
                className="btn btn-primary d-block w-100"
                type="submit"
                disabled={isLoading} // Deshabilitar el botón mientras se carga
                style={{
                  fontSize: '16px',
                  padding: '6px',
                  maxWidth: '400px',
                  margin: '0 auto',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  gap: '8px',
                }}
              >
                {isLoading ? (
                  <>
                    <FaSpinner className="spinner" /> {/* Spinner girando */}
                    Enviando...
                  </>
                ) : (
                  "Enviar"
                )}
              </button>
            </div>

            {/* Botón para volver al inicio de sesión */}
            <div className="text-center">
              <button
                type="button"
                className="btn btn-link"
                onClick={() => setShowForgotPassword(false)}
                style={{
                  color: '#333',
                  textDecoration: 'none',
                  fontSize: '16px',
                  fontWeight: '500',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  gap: '8px'
                }}
              >
                <FaArrowLeft /> Volver
              </button>
            </div>
          </form>
          )}
        </Offcanvas.Body>
      </Offcanvas>

      {/* Lista de productos */}
      <ListaProductosApp addToCart={addToCart} />

      {/* Carrito */}
      <Carrito showCart={showCart} handleShowCart={handleShowCart} cart={cart} removeFromCart={removeFromCart} />
    </>
  );
}

export default LoginApp;
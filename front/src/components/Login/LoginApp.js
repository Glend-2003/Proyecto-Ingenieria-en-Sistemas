import React, { useState, useEffect } from "react";
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import '../styles.min.css';
import { Offcanvas, Navbar, Container, Nav, Button, ListGroup, Badge, Card } from 'react-bootstrap';
import Carrito from '../Carrito/CarritoApp.js';
import ListaProductosApp from '../Catalogo/ListaProductosApp.js';
import DropDown from "../DropDown/DropDown";
import { toast } from 'react-toastify';
import './Login.css';
import FooterApp from '../Footer/FooterApp';
import Snackbar from '@mui/material/Snackbar';
import MuiAlert from '@mui/material/Alert';

function App() {
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

  // Definir el componente Alert para Snackbar
  const Alert = React.forwardRef(function Alert(props, ref) {
    return <MuiAlert elevation={6} ref={ref} variant="filled" {...props} />;
  });

  // Estados para manejar el Snackbar
  const [openSnackbar, setOpenSnackbar] = useState(false);
  const [snackbarMessage, setSnackbarMessage] = useState('');
  const [snackbarSeverity, setSnackbarSeverity] = useState('success'); // 'success', 'error', 'warning', 'info'

  // Función para abrir el Snackbar
  const handleOpenSnackbar = (message, severity) => {
    
    setSnackbarMessage(message);
    setSnackbarSeverity(severity);
    setOpenSnackbar(true);
  };

  // Función para cerrar el Snackbar
  const handleCloseSnackbar = (event, reason) => {
    if (reason === 'clickaway') {
      return;
    }
    setOpenSnackbar(false);
  };

  // Función para manejar el cambio en los inputs del formulario
  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setLoginData({
      ...loginData,
      [name]: value,
    });
  };

  // Función para mostrar/ocultar el sidebar
  const handleShowSidebar = () => {
    setShowSidebar(!showSidebar && !idUsuario);
  };

  // Función para mostrar/ocultar el carrito
  const handleShowCart = () => {
    setShowCart(!showCart);
  };

  // Función para agregar productos al carrito
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

  // Función para eliminar productos del carrito
  const removeFromCart = (indexToRemove) => {
    const updatedCart = cart.filter((_, idx) => idx !== indexToRemove);
    setCart(updatedCart);
    localStorage.setItem("carrito", JSON.stringify(updatedCart));
    toast.info("Producto eliminado del carrito");
  };

  // Resto del código...

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

          
          // Mostrar Snackbar de éxito
          handleOpenSnackbar("Bienvenido a Carnoiceria La Bendición.", "success");

          setLoginStatus('Login exitoso. Bienvenido ' + response.data.nombreUsuario);

          if (
            response.data.rol.nombreRol === 'Administrador' ||
            response.data.rol.nombreRol === 'Usuario' ||
            response.data.rol.nombreRol === 'Gerente'
          ) {
            navigate('/principal');
          }

          if (response.data.rol.nombreRol === 'Usuario') {
            navigate('/');
            setShowSidebar(false);
          }
        } else {
          // Mostrar Snackbar de error
          handleOpenSnackbar("Error en el ingreso, verificar datos!", "error");
          setLoginStatus('Credenciales incorrectas');
        }
      })
      .catch((error) => {
        console.error(
          'Error en el login:',
          error.response ? error.response.data : error.message
        );
        // Mostrar Snackbar de error
        handleOpenSnackbar("Error en el ingreso, "+ error.response.data, "error");
        setLoginStatus('Error en el servidor o en las credenciales');
      });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    login();
  };


  return (
    <div className="page-container">
      {/* Navbar */}
      <Navbar expand="lg" variant="dark" style={{ backgroundColor: '#001f3f' }}>
        <Container>
          <Navbar.Toggle aria-controls="basic-navbar-nav" />
          <Navbar.Collapse id="basic-navbar-nav">
            <Nav className="ms-auto">
              <div>
                <Nav.Link onClick={handleShowSidebar}>
                  <DropDown
                    icon={
                      <svg xmlns="http://www.w3.org/2000/svg" width="1.5em" height="1.5em" fill="currentColor" className="bi bi-person" viewBox="0 0 16 16">
                        <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664z" />
                      </svg>
                    }
                    idUsuario={idUsuario}
                  />
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
          <Offcanvas.Title>Iniciar sesión</Offcanvas.Title>
        </Offcanvas.Header>
        <Offcanvas.Body>
          <form className="text-center" onSubmit={handleSubmit}>
            <div className="mb-3">
              <input
                className="form-control"
                type="email"
                name="correoUsuario"
                value={loginData.correoUsuario}
                onChange={handleInputChange}
                placeholder="Correo electrónico"
                required
              />
            </div>
            <div className="mb-3">
              <input
                className="form-control"
                type="password"
                name="contraseniaUsuario"
                value={loginData.contraseniaUsuario}
                onChange={handleInputChange}
                placeholder="Contraseña"
                required
              />
            </div>
            <div className="mb-3">
              <button className="btn btn-primary d-block w-100" type="submit">
                Acceso
              </button>
            </div>
            <div className="form-check text-start mb-3">
              <input className="form-check-input" type="checkbox" id="rememberMe" />
              <label className="form-check-label" htmlFor="rememberMe">
                Acuérdate de mí
              </label>
              <a href="/forgot-password" className="float-end text-muted">
                ¿Perdiste tu contraseña?
              </a>
            </div>
            <hr />
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
        </Offcanvas.Body>
      </Offcanvas>

      {/* Contenido principal */}
      <main className="flex-grow-1">
        <ListaProductosApp addToCart={addToCart} />
        <Carrito showCart={showCart} handleShowCart={handleShowCart} cart={cart} removeFromCart={removeFromCart} />
      </main>

 

      {/* Carrito */}
      <Carrito showCart={showCart} handleShowCart={handleShowCart} cart={cart}
        removeFromCart={removeFromCart}
      />

      {/* Snackbar para mostrar alertas */}
      <Snackbar
        open={openSnackbar}
        autoHideDuration={6000} // Duración en milisegundos
        onClose={handleCloseSnackbar}
        anchorOrigin={{ vertical: 'top', horizontal: 'right' }} // Posición del Snackbar
      >
        <Alert onClose={handleCloseSnackbar} severity={snackbarSeverity} sx={{ width: '100%' }}>
          {snackbarMessage}
        </Alert>
      </Snackbar>
       {/* Footer */}
       <FooterApp />
    </div>
  );
}

export default App;

// App.js
import React, { useState, useEffect } from "react";
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import '../styles.min.css';
import { Offcanvas, Navbar, Container, Nav, Button, ListGroup, Badge, Card} from 'react-bootstrap';
import { toast, ToastContainer } from "react-toastify";
import Carrito from '../Carrito/CarritoApp.js'; 
import DetalleProducto from '../ContenidoProducto/DetalleProducto.js'; // Asegúrate de que la ruta sea correcta

// Importamos el componente Carrito
import "./Login.css";

function App() {
  const [loginData, setLoginData] = useState({
    correoUsuario: '',
    contraseniaUsuario: '',
  });
  const [showSidebar, setShowSidebar] = useState(false);
  const [showCart, setShowCart] = useState(false);
  const [loginStatus, setLoginStatus] = useState('');
  const savedCart = JSON.parse(localStorage.getItem("carrito")) || [];
  const [cart, setCart] = useState(savedCart); // Productos en el carrito
  const [productos, setProductos] = useState([]); // Lista de productos disponibles
  const navigate = useNavigate();

  useEffect(() => {
    //localStorage.setItem("carrito", JSON.stringify(cart));
    cargarProductos();
  }, [cart]);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setLoginData({
      ...loginData,
      [name]: value,
    });
  };

  const handleShowSidebar = () => setShowSidebar(!showSidebar);
  const handleShowCart = () => setShowCart(!showCart);

  const addToCart = (producto) => {
    setCart((prevCart) => [...prevCart, producto]);
  };

  const removeFromCart = (indexToRemove) => {
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

          setLoginStatus(
            'Login exitoso. Bienvenido ' + response.data.nombreUsuario
          );

          if (
            response.data.rol.nombreRol === 'Administrador' ||
            response.data.rol.nombreRol === 'Usuario' ||
            response.data.rol.nombreRol === 'Gerente'
          ) {
            navigate('/principal');
          } else {
            setLoginStatus('Rol no reconocido');
          }
        } else {
          setLoginStatus('Credenciales incorrectas');
        }
      })
      .catch((error) => {
        console.error(
          'Error en el login:',
          error.response ? error.response.data : error.message
        );
        setLoginStatus('Error en el servidor o en las credenciales');
      });
  };

  const verDetalles = (idProducto) => {
    navigate(`/producto/${idProducto}`); // Redirige a la página de detalles con el ID del producto
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    login();
  };

  /*const slideLeft = () => {
    const slider = document.getElementById("product-slider");
    slider.scrollLeft = slider.scrollLeft - 300; // Mueve el scroll 300px a la izquierda
  };

  // Función para desplazar el slider hacia la derecha
  const slideRight = () => {
    const slider = document.getElementById("product-slider");
    slider.scrollLeft = slider.scrollLeft + 300; // Mueve el scroll 300px a la derecha
  };*/

  const cargarProductos = async () => {
    try {
      const response = await axios.get("http://localhost:8080/producto/");
      setProductos(response.data);
    } catch (error) {
      console.error("Error al cargar productos:", error);
      toast.error("Ocurrió un error al cargar los productos");
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
              <Nav.Link onClick={handleShowSidebar}>
                <svg xmlns="http://www.w3.org/2000/svg" width="1.5em" height="1.5em" fill="currentColor" className="bi bi-person" viewBox="0 0 16 16">
                  <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664z" />
                </svg>
              </Nav.Link>
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

      {/* Productos Disponibles 
      <Container className="text-center mt-5">
        <h5>Productos Disponibles</h5>
        <ListGroup className="mb-4">
          {productos.map((product) => (
            <ListGroup.Item key={product.id}>
              {product.imgProducto ? (
                <img
                  src={`http://localhost:8080/producto/images/${product.imgProducto}`}
                  alt={product.imgProducto}
                  width="50"
                />
              ) : (
                "No disponible"
              )}
              {product.nombreProducto} - ₡{product.montoPrecioProducto} 1 Kg
              <Button
                variant="success"
                size="sm"
                className="float-end"
                onClick={() => addToCart(product)}
              >
                Agregar
              </Button>
            </ListGroup.Item>
          ))}
        </ListGroup>
      </Container>
      */}
      {/* Contenedor del slider */}
      <div id="product-slider" className="product-slider">
        {/* Muestra un mensaje de carga si no hay productos */}
        {productos.length === 0 ? (
          <p>Cargando productos...</p>
        ) : (
          // Mapea los productos y crea una tarjeta para cada uno
          productos.map((product) => (
            <div className="product-card" key={product.id}>
              <Card style={{ width: "18rem" }}>
                {/* Imagen del producto, asegurando la ruta correcta */}
                <Card.Img
                  variant="top"
                  src={`http://localhost:8080/producto/images/${product.imgProducto}`}
                />

              <Card.Body>
                <Card.Title>{product.nombreProducto}</Card.Title>
                  {/* Nombre del producto */}
                  <Card.Text>
                    <strong>Precio:</strong>{" "}
                    {new Intl.NumberFormat("es-CR", {
                      style: "currency",
                      currency: "CRC",
                      minimumFractionDigits: 0,
                    }).format(product.montoPrecioProducto)}
                  </Card.Text>
                  {/* Precio del producto */}
                  {/*  Redirige al detalle del producto */}
                  <div>  
                   {/* <Button variant="primary" onClick={()=> navigate(`/producto/${product.idProducto}`)}>Ver Producto</Button>{" "}*/}
                    <Button onClick={() => verDetalles(product.idProducto)}>Ver detalles</Button>
                    <Button
                        variant="success"
                        size="sm"
                        className="float-end"
                        onClick={() => addToCart(product)}
                      >
                      Agregar
                    </Button>
                  </div>
                  {/* Botón para ver más detalles */}
                   
                    
                  
                </Card.Body>
              </Card>
            </div>
          ))
        )}
      </div>
      {/* Carrito */}
      <Carrito showCart={showCart} handleShowCart={handleShowCart} cart={cart} removeFromCart={removeFromCart} />
    </>
  );
}

export default App;

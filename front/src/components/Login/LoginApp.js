
import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import '../styles.min.css';
import { Offcanvas, Navbar, Container, Nav } from 'react-bootstrap';

function App() {
  const [loginData, setLoginData] = useState({
    correoUsuario: '',
    contraseniaUsuario: '',
  });
  const [showSidebar, setShowSidebar] = useState(false);
  const [loginStatus, setLoginStatus] = useState('');
  const navigate = useNavigate();

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setLoginData({
      ...loginData,
      [name]: value,
    });
  };

  const handleShowSidebar = () => setShowSidebar(!showSidebar);

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

  const handleSubmit = (e) => {
    e.preventDefault();
    login();
  };

  return (
    <>
      <Navbar expand="lg" variant="dark" style={{ backgroundColor: '#001f3f' }}>
  <Container>
    <Navbar.Toggle aria-controls="basic-navbar-nav" />
    <Navbar.Collapse id="basic-navbar-nav">
      <Nav className="ms-auto">
        <Nav.Link onClick={handleShowSidebar}>
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="1.5em"
            height="1.5em"
            fill="currentColor"
            className="bi bi-person"
            viewBox="0 0 16 16"
          >
            <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664z" />
          </svg>
        </Nav.Link>
        <Nav.Link href="#">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="1.5em"
            height="1.5em"
            fill="currentColor"
            className="bi bi-search"
            viewBox="0 0 16 16"
          >
            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.415l-3.85-3.85a1.007.007 0 0 0-.115-.098zm-5.442 1.4a5.5 5.5 0 1 1 0-11 5.5 5.5 0 0 1 0 11z" />
          </svg>
        </Nav.Link>
      </Nav>
    </Navbar.Collapse>
  </Container>
</Navbar>


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
  </Offcanvas.Body>
</Offcanvas>


      <Container className="text-center mt-5">
        <h3>Aqui se van a mostrar los productos en el centro</h3>
      </Container>
    </>
  );
}

export default App;
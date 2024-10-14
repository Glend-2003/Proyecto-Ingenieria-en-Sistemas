import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import '../styles.min.css';

function LoginApp() {
  const [loginData, setLoginData] = useState({
    correoUsuario: '',
    contraseniaUsuario: ''
  });
  const [loginStatus, setLoginStatus] = useState('');
  const navigate = useNavigate();

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setLoginData({
      ...loginData,
      [name]: value
    });
  };

  const login = () => {
    axios.post('http://localhost:8080/usuario/login', loginData)
      .then(response => {
        if (response.data.token) {
          // Guardar el token, correo y rol en localStorage
          localStorage.setItem('token', response.data.token);
          localStorage.setItem('correoUsuario', response.data.correoUsuario);
          localStorage.setItem('nombreRol', response.data.rol.nombreRol);  // Acceder correctamente al nombre del rol

          setLoginStatus("Login exitoso. Bienvenido " + response.data.nombreUsuario);

          // Verificar el rol del usuario para redirigir a la página correspondiente
          if (response.data.rol.nombreRol === 'Administrador') {
            navigate('/CategoriaApp');
          } else if (response.data.rol.nombreRol === 'Usuario') {
            navigate('/principal');
          } else {
            setLoginStatus("Rol no reconocido");
          }
        } else {
          setLoginStatus("Credenciales incorrectas");
        }
      })
      .catch(error => {
        console.error('Error en el login:', error.response ? error.response.data : error.message);
        setLoginStatus("Error en el servidor o en las credenciales");
      });
};

  const handleSubmit = (e) => {
    e.preventDefault();
    login();
  };

  const handleNoAccountClick = () => {
    navigate('/register');
  };

  return (
    <section className="position-relative py-4 py-xl-5">
      <div className="container">
        <div className="row mb-5">
          <div className="col-md-8 col-xl-6 text-center mx-auto">
            <h2>Iniciar sesión</h2>
            <p className="w-lg-50">
              <strong>Ingrese con su cuenta de Carnicería la Bendición</strong>
            </p>
          </div>
        </div>
        <div className="row d-flex justify-content-center">
          <div className="col-md-6 col-xl-4">
            <div className="card mb-5">
              <div className="card-body d-flex flex-column align-items-center">
                <div className="bs-icon-xl bs-icon-circle bs-icon-primary bs-icon my-4">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="1em"
                    height="1em"
                    fill="currentColor"
                    viewBox="0 0 16 16"
                    className="bi bi-person"
                  >
                    <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664z" />
                  </svg>
                </div>
                <form className="text-center" onSubmit={handleSubmit}>
                  <div className="mb-3">
                    <input
                      className="form-control"
                      type="email"
                      name="correoUsuario"
                      value={loginData.correoUsuario}
                      onChange={handleInputChange}
                      placeholder="Correo"
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
                      Iniciar sesión
                    </button>
                  </div>
                  <p className="text-muted">
                    <a href="/forgot-password" className="text-muted">Olvidó su contraseña?</a>
                  </p>
                  <p>
                    <span
                      onClick={handleNoAccountClick}
                      style={{ color: 'rgba(33, 37, 41, 0.75)', cursor: 'pointer' }}
                    >
                      No tiene cuenta?
                    </span>
                  </p>
                </form>
                <p>{loginStatus}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}

export default LoginApp;

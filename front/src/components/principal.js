import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import { FaWpforms, FaStar, FaUserCircle } from 'react-icons/fa'; // Actualizamos las importaciones

const Principal = () => {
    const [usuario, setUsuario] = useState(null);
    const navigate = useNavigate();

    useEffect(() => {
        const token = localStorage.getItem('token');

        if (token) {
            axios.get('http://localhost:8080/usuario/datos', {
                headers: {
                    'Authorization': `Bearer ${token}` 
                }
            })
            .then(response => {
                setUsuario(response.data);
            })
            .catch(error => {
                console.error('Error al obtener los datos del usuario:', error);
                localStorage.removeItem('token');
                localStorage.removeItem('correoUsuario');
                localStorage.removeItem('nombreUsuario');
                navigate('/');
            });
        } else {
            navigate('/');
        }
    }, [navigate]);

    const handleLogout = () => {
        localStorage.removeItem('token');
        localStorage.removeItem('correoUsuario');
        localStorage.removeItem('nombreUsuario');
        navigate('/');
    };

    return (
        <div data-bs-theme="light">
            <head>
                <meta charset="utf-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no" />
                <title>Página Principal - Carnicería La Bendición</title>
                <link rel="stylesheet" href="/assets/bootstrap/css/bootstrap.min.css?h=97f29be617557a0886946172d7688ddf" />
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css" />
                <link rel="stylesheet" href="/assets/css/styles.min.css?h=07cb10937863c52e016a927d9aa3434a" />
            </head>

            <div>
                <nav className="navbar navbar-expand-md sticky-top navigation-clean-button navbar-light"
                    style={{ height: '80px', background: '#042440' }}>
                    <div className="container-fluid">
                        <a className="navbar-brand" href="#">&nbsp;Carnicería La Bendición</a>
                        <button data-bs-toggle="collapse" className="navbar-toggler" data-bs-target="#navcol-1">
                            <span className="visually-hidden">Toggle navigation</span>
                            <span className="navbar-toggler-icon"></span>
                        </button>
                        <div className="collapse navbar-collapse" id="navcol-1">
                            <ul className="navbar-nav ms-auto">
                                <li className="nav-item">
                                    {usuario && (usuario.rol.nombreRol === 'Administrador' || usuario.rol.nombreRol === 'Gerente') && (
                                        <a className="nav-link" style={{ color: "#ffffff" }} onClick={() => navigate('/GestionarUsuario')} href="#">
                                            <FaWpforms />&nbsp;Gestionar usuarios
                                        </a>
                                    )}
                                </li>
                                <li className="nav-item">
                                    {usuario && (usuario.rol.nombreRol === 'Administrador' || usuario.rol.nombreRol === 'Gerente') && (
                                        <a className="nav-link" style={{ color: "#ffffff" }} onClick={() => navigate('/CategoriaApp')} href="#">
                                            <FaStar />&nbsp;Gestionar categorías
                                        </a>
                                    )}
                                </li>
                                <li className="nav-item">
                                    <a className="nav-link" style={{ color: "#ffffff" }} onClick={handleLogout} href="#">
                                        <FaUserCircle />&nbsp;Cerrar sesión
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
            </div>

            <main className="page">
                <section className="portfolio-block hire-me">
                    <div className="container">
                        <div className="heading">
                            <h2>Bienvenido a la página principal</h2>
                        </div>
                        <div className="border rounded border-0 shadow-lg p-3 p-md-5" data-bs-theme="light">
                            {usuario ? (
                                <div>
                                    <h2>Nombre: {usuario.nombreUsuario}</h2>
                                    <p>Correo: {usuario.correoUsuario}</p>
                                    <p>Rol: {usuario.rol.nombreRol}</p>
                                    <p>Teléfono: {usuario.telefonoUsuario}</p>

                                </div>
                            ) : (
                                <p>Cargando información del usuario...</p>
                            )}
                        </div>
                    </div>
                </section>
            </main>

            <footer className="page-footer py-3 border-top" style={{ background: '#042440' }}>
                <div className="container my-4">
                    <div className="links">
                        <a href="#" style={{ background: 'var(--bs-body-bg)', color: 'var(--bs-secondary-bg)' }}>Contactos</a>
                    </div>
                    <div className="social-icons">
                        <a className="me-3" href="https://www.facebook.com/profile.php?id=100063502301155&amp;locale=fy_NL&amp;_rdr">
                            <i className="icon ion-social-facebook"></i>
                        </a>
                        <a className="me-3" href="https://www.youtube.com/watch?v=MCcu2Ncovdg&amp;ab_channel=VybzKartel-Topic">
                            <svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor" viewBox="0 0 16 16" className="bi bi-telephone">
                                <path d="M3.654 1.328a.678.678 0 0 0-1.015-.063L1.605 2.3c-.483.484-.661 1.169-.45 1.77a17.568 17.568 0 0 0 4.168 6.608 17.569 17.569 0 0 0 6.608 4.168c.601.211 1.286.033 1.77-.45l1.034-1.034a.678.678 0 0 0-.063-1.015l-2.307-1.794a.678.678 0 0 0-.58-.122l-2.19.547a1.745 1.745 0 0 1-1.657-.459L5.482 8.062a1.745 1.745 0 0 1-.46-1.657l.548-2.19a.678.678 0 0 0-.122-.58L3.654 1.328zM1.884.511a1.745 1.745 0 0 1 2.612.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511z"></path>
                            </svg>
                        </a>
                    </div>
                </div>
            </footer>
        </div>
    );
};

export default Principal;

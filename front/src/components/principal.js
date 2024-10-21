import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import { FaWpforms, FaStar, FaUserCircle } from 'react-icons/fa'; // Actualizamos las importaciones
import Navbar from './Navbar';
import useAuth from '../hooks/useAuth';

const Principal = () => {
    const { usuario, handleLogout } = useAuth();
    /*const [usuario, setUsuario] = useState(null);
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
    };*/

    return (
        <div data-bs-theme="light">
            <Navbar usuario={usuario} onLogout={handleLogout} />

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

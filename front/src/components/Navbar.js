import React from 'react';
import { useNavigate } from 'react-router-dom';
import { FaWpforms, FaStar, FaUserCircle } from 'react-icons/fa';

const Navbar = ({ usuario, onLogout }) => {
    const navigate = useNavigate();

    return (
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
                        {usuario && (usuario.rol.nombreRol === 'Administrador' || usuario.rol.nombreRol === 'Gerente') && (
                            <>
                                <li className="nav-item">
                                    <a className="nav-link" style={{ color: "#ffffff" }} onClick={() => navigate('/GestionarUsuario')} href="#">
                                        <FaWpforms />&nbsp;Gestionar usuarios
                                    </a>
                                </li>
                                <li className="nav-item">
                                    <a className="nav-link" style={{ color: "#ffffff" }} onClick={() => navigate('/CategoriaApp')} href="#">
                                        <FaStar />&nbsp;Gestionar categorías
                                    </a>
                                </li>
                            </>
                        )}
                        <li className="nav-item">
                            <a className="nav-link" style={{ color: "#ffffff" }} onClick={onLogout} href="#">
                                <FaUserCircle />&nbsp;Cerrar sesión
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    );
};

export default Navbar;
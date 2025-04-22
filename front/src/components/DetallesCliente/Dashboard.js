import React from 'react';
import { NavLink, useNavigate } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import "./Dashboard.css";
import useAuth from "../../hooks/useAuth";
import { FaFileAlt, FaDownload, FaMapMarkerAlt, FaUser, FaSignOutAlt, FaHome } from "react-icons/fa";
import FooterApp from '../Footer/FooterApp';
import NavbarApp from '../Navbar/NavbarApp';
import { AppProvider } from "../Navbar/AppContext"
import Carrito from '../Carrito/CarritoApp';
import SideBarUsuario from '../DetallesCliente/SideBarUsuario';

const Dashboard = () => {
    const { usuario } = useAuth();
    const navigate = useNavigate();

    const handleLogout = () => {
        localStorage.removeItem('token');
        localStorage.removeItem('correoUsuario');
        localStorage.removeItem('nombreUsuario');
        localStorage.removeItem('nombreUsuario');
        localStorage.removeItem('nombreRol');
        localStorage.removeItem('idUsuario');
        navigate('/');
    };
    return (
        <AppProvider>
            <div>
                <NavbarApp />
                <div className="dashboard-container">
                    {/* Sidebar Component */}
                    <SideBarUsuario usuario={usuario} handleLogout={handleLogout} />

                    {/* Contenido */}
                    <div className="content">
                        <h2 className="text-center">Bienvenido a tu perfil</h2>
                        <div className="cards-container">
                            <NavLink to="/orders" className="card">
                                <FaFileAlt className="icon" />
                                <span>Pedidos</span>
                            </NavLink>
                            <NavLink to="/downloads" className="card">
                                <FaDownload className="icon" />
                                <span>Comprobantes</span>
                            </NavLink>
                            <NavLink to="/DireccionUsuario" className="card">
                                <FaMapMarkerAlt className="icon" />
                                <span>Dirección</span>
                            </NavLink>
                            <NavLink to="/PerfilUsuario" className="card">
                                <FaUser className="icon" />
                                <span>Detalles de la cuenta</span>
                            </NavLink>
                            <NavLink to="/" className="card logout" onClick={handleLogout}>
                                <FaSignOutAlt className="icon" />
                                <span>Cerrar sesión</span>
                            </NavLink>
                        </div>
                    </div>
                    <Carrito />
                </div>
                <FooterApp />
            </div>
        </AppProvider>
    );
};

export default Dashboard;

import React from 'react';
import { NavLink } from 'react-router-dom';
import { FaHome, FaFileAlt, FaDownload, FaMapMarkerAlt, FaUser, FaSignOutAlt } from 'react-icons/fa';
import NavbarApp from '../Navbar/NavbarApp';
import FooterApp from '../Footer/FooterApp';
import './SideBarUsuario.css'; // Agregaremos estilos aquí

const SideBarUsuario = ({ usuario, handleLogout }) => {
    return (
        <div className="sidebar-container">
            <h3 className="sidebar-title">Bienvenido {usuario?.nombreUsuario || "Usuario"}</h3>
            <nav className="sidebar-nav">
                <NavLink to="/dashboard" className="sidebar-link">
                    <FaHome className="icon" /> Inicio
                </NavLink>
                <NavLink to="/orders" className="sidebar-link">
                    <FaFileAlt className="icon" /> Pedidos
                </NavLink>
                <NavLink to="/DireccionUsuario" className="sidebar-link">
                    <FaMapMarkerAlt className="icon" /> Dirección
                </NavLink>
                <NavLink to="/PerfilUsuario" className="sidebar-link">
                    <FaUser className="icon" /> Detalles de la cuenta
                </NavLink>
                <NavLink to="/" className="sidebar-link logout" onClick={handleLogout}>
                    <FaSignOutAlt className="icon" /> Cerrar sesión
                </NavLink>
            </nav>
        </div>
    );
};

export default SideBarUsuario;

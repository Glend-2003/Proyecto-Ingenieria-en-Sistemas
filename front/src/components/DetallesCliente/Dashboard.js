import React from 'react';
import { NavLink } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import "./Dashboard.css";
import useAuth from "../../hooks/useAuth";
import { FaFileAlt, FaDownload, FaMapMarkerAlt, FaUser, FaSignOutAlt, FaHome } from "react-icons/fa";
import FooterApp from '../Footer/FooterApp';

const Dashboard = () => {
    const { usuario } = useAuth();

    return (
        <div>  
        <div className="dashboard-container"> 
            {/* Sidebar */}
            <div className="sidebar-container">
                <h3 className="sidebar-title">Bienvenido, {usuario?.nombre || "Usuario"}</h3>
                <nav className="sidebar-nav">
                    <NavLink to="/dashboard" className="sidebar-link">
                        <FaHome className="icon" /> Inicio
                    </NavLink>
                    <NavLink to="/orders" className="sidebar-link">
                        <FaFileAlt className="icon" /> Pedidos
                    </NavLink>
                    <NavLink to="/downloads" className="sidebar-link">
                        <FaDownload className="icon" /> Comprobantes
                    </NavLink>
                    <NavLink to="/addresses" className="sidebar-link">
                        <FaMapMarkerAlt className="icon" /> Dirección
                    </NavLink>
                    <NavLink to="/PerfilUsuario" className="sidebar-link">
                        <FaUser className="icon" /> Detalles de la cuenta
                    </NavLink>
                    <NavLink to="/logout" className="sidebar-link logout">
                        <FaSignOutAlt className="icon" /> Cerrar sesión
                    </NavLink>
                </nav>
            </div>
            
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
                    <NavLink to="/addresses" className="card">
                        <FaMapMarkerAlt className="icon" />
                        <span>Dirección</span>
                    </NavLink>
                    <NavLink to="/account-details" className="card">
                        <FaUser className="icon" />
                        <span>Detalles de la cuenta</span>
                    </NavLink>
                    <NavLink to="/logout" className="card logout">
                        <FaSignOutAlt className="icon" />
                        <span>Cerrar sesión</span>
                    </NavLink>
                </div>
            </div>
          
        </div>
        <FooterApp/></div>
    );
};

export default Dashboard;

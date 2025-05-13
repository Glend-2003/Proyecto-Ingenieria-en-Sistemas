import React, { useEffect } from 'react';
import { NavLink } from 'react-router-dom';
import { FaUsers, FaListAlt, FaComments, FaBoxOpen, FaPercentage, FaCreditCard, FaShoppingCart, FaChartLine, FaUserCircle } from 'react-icons/fa';
import 'bootstrap/dist/css/bootstrap.min.css';
import './SideBar.css';

const SideBar = ({ usuario }) => {
    // Añadir clase 'admin-page' al body cuando el componente se monta
    useEffect(() => {
        document.body.classList.add('admin-page');
        
        // Limpiar cuando el componente se desmonte
        return () => {
            document.body.classList.remove('admin-page');
        };
    }, []);

    return (
        <div className="sidebar-container">
            <div className="sidebar-inner">
                <div className="sidebar-header">
                    <h3 className="sidebar-title">Administrar datos</h3>
                </div>
                
                <div className="sidebar-content">
                    <nav className="sidebar-nav">
                        <NavLink to="/GestionarUsuario" className={({ isActive }) => isActive ? "sidebar-link active" : "sidebar-link"}>
                            <FaUsers className="sidebar-icon" /> Usuarios
                        </NavLink>
                        
                        <NavLink to="/CategoriaApp" className={({ isActive }) => isActive ? "sidebar-link active" : "sidebar-link"}>
                            <FaListAlt className="sidebar-icon" /> Categorías
                        </NavLink>
                        
                        <NavLink to="/ComentarioApp" className={({ isActive }) => isActive ? "sidebar-link active" : "sidebar-link"}>
                            <FaComments className="sidebar-icon" /> Comentarios
                        </NavLink>
                        
                        <NavLink to="/ProductoApp" className={({ isActive }) => isActive ? "sidebar-link active" : "sidebar-link"}>
                            <FaBoxOpen className="sidebar-icon" /> Productos
                        </NavLink>
                        
                        <NavLink to="/PromocionApp" className={({ isActive }) => isActive ? "sidebar-link active" : "sidebar-link"}>
                            <FaPercentage className="sidebar-icon" /> Promociones
                        </NavLink>
                        
                        <NavLink to="/TipoPagoApp" className={({ isActive }) => isActive ? "sidebar-link active" : "sidebar-link"}>
                            <FaCreditCard className="sidebar-icon" /> Tipo Pago
                        </NavLink>
                        
                        <NavLink to="/PedidosApp" className={({ isActive }) => isActive ? "sidebar-link active" : "sidebar-link"}>
                            <FaShoppingCart className="sidebar-icon" /> Pedidos
                        </NavLink>
                        
                        <NavLink to="/VentaPedido" className={({ isActive }) => isActive ? "sidebar-link active" : "sidebar-link"}>
                            <FaChartLine className="sidebar-icon" /> Ventas
                        </NavLink>
                    </nav>
                </div>
                
                <div className="sidebar-footer">
                    <NavLink to="/principal" className={({ isActive }) => isActive ? "profile-button active" : "profile-button"}>
                        <div className="user-avatar">
                            <FaUserCircle className="avatar-icon" />
                        </div>
                        <div className="user-info">
                            <span className="user-name">{usuario ? usuario.nombreUsuario : "Usuario"}</span>
                            <span className="user-role">Ver perfil</span>
                        </div>
                    </NavLink>
                </div>
            </div>
        </div>
    );
};

export default SideBar;
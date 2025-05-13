import React from 'react';
import { NavLink } from 'react-router-dom';
import { 
    FaUserCircle, 
    FaEnvelope, 
    FaIdBadge, 
    FaCogs,
    FaUsers,
    FaListAlt,
    FaComments,
    FaBoxOpen,
    FaPercentage,
    FaCreditCard,
    FaShoppingCart,
    FaChartLine
} from 'react-icons/fa';
import useAuth from '../../hooks/useAuth';
import SideBar from '../SideBar/SideBar';
import FooterApp from '../Footer/FooterApp';
import { useAppContext } from "../Navbar/AppContext";
import "./Principal.css";

const Principal = () => {
    const { usuario } = useAuth();
    const { handleLogout } = useAppContext();

    // Array de accesos rápidos basado en las opciones del sidebar
    const quickAccess = [
        { 
            path: '/GestionarUsuario', 
            name: 'Usuarios', 
            icon: <FaUsers size={32} />, 
            description: 'Gestión de usuarios del sistema', 
            color: 'var(--primary-medium)' 
        },
        { 
            path: '/CategoriaApp', 
            name: 'Categorías', 
            icon: <FaListAlt size={32} />, 
            description: 'Administrar categorías de productos', 
            color: 'var(--primary-light)' 
        },
        { 
            path: '/ComentarioApp', 
            name: 'Comentarios', 
            icon: <FaComments size={32} />, 
            description: 'Ver y gestionar comentarios', 
            color: 'var(--accent-gold)' 
        },
        { 
            path: '/ProductoApp', 
            name: 'Productos', 
            icon: <FaBoxOpen size={32} />, 
            description: 'Administrar inventario de productos', 
            color: 'var(--primary-dark)' 
        },
        { 
            path: '/PromocionApp', 
            name: 'Promociones', 
            icon: <FaPercentage size={32} />, 
            description: 'Gestionar promociones y descuentos', 
            color: 'var(--accent-brown)' 
        },
        { 
            path: '/TipoPagoApp', 
            name: 'Tipo Pago', 
            icon: <FaCreditCard size={32} />, 
            description: 'Configurar métodos de pago', 
            color: 'var(--primary-medium)' 
        },
        { 
            path: '/PedidosApp', 
            name: 'Pedidos', 
            icon: <FaShoppingCart size={32} />, 
            description: 'Ver y gestionar pedidos actuales', 
            color: 'var(--primary-light)' 
        },
        { 
            path: '/VentaPedido', 
            name: 'Ventas', 
            icon: <FaChartLine size={32} />, 
            description: 'Consultar historial de ventas', 
            color: 'var(--accent-gold)' 
        }
    ];

    return (
        <div className="principal-container">
            <SideBar usuario={usuario} />

            <main className="page">
                <div className="welcome-banner">
                  
                </div>

                <div className="dashboard-container">
                    <div className="user-profile-card">
                        <div className="profile-header">
                            <div className="profile-avatar">
                                <FaUserCircle size={80} />
                            </div>
                            <div className="profile-role-badge">
                                {usuario?.rol?.nombreRol || "Usuario"}
                            </div>
                        </div>
                        
                        <div className="profile-body">
                            <h2>{usuario ? `${usuario.nombreUsuario} ${usuario.primerApellido}` : "Cargando..."}</h2>
                            
                            <div className="profile-info">
                                <div className="info-item">
                                    <div className="info-icon">
                                        <FaUserCircle />
                                    </div>
                                    <div className="info-content">
                                        <span className="info-label">Nombre completo</span>
                                        <span className="info-value">{usuario ? `${usuario.nombreUsuario} ${usuario.primerApellido}` : "..."}</span>
                                    </div>
                                </div>
                                
                                <div className="info-item">
                                    <div className="info-icon">
                                        <FaEnvelope />
                                    </div>
                                    <div className="info-content">
                                        <span className="info-label">Correo electrónico</span>
                                        <span className="info-value">{usuario?.correoUsuario || "..."}</span>
                                    </div>
                                </div>
                                
                                <div className="info-item">
                                    <div className="info-icon">
                                        <FaIdBadge />
                                    </div>
                                    <div className="info-content">
                                        <span className="info-label">Rol en el sistema</span>
                                        <span className="info-value">{usuario?.rol?.nombreRol || "..."}</span>
                                    </div>
                                </div>
                                
                                <div className="info-item">
                                    <div className="info-icon">
                                        <FaCogs />
                                    </div>
                                    <div className="info-content">
                                        <span className="info-label">Acciones</span>
                                        <div className="action-buttons">
                                          
                                            <button className="logout-btn" onClick={handleLogout}>
                                                Cerrar sesión
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div className="quick-access-container">
                        <h3 className="section-title">Accesos Rápidos</h3>
                        <div className="quick-access-grid">
                            {quickAccess.map((item, index) => (
                                <NavLink to={item.path} key={index} className="quick-access-card">
                                    <div className="card-icon" style={{ backgroundColor: item.color }}>
                                        {item.icon}
                                    </div>
                                    <div className="card-content">
                                        <h4>{item.name}</h4>
                                        <p>{item.description}</p>
                                    </div>
                                </NavLink>
                            ))}
                        </div>
                    </div>
                </div>
            </main>
            <FooterApp />
        </div>
    );
};

export default Principal;
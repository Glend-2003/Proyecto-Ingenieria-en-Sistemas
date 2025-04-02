import React from 'react';
import { NavLink } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import './SideBar.css';
import FooterApp from '../Footer/FooterApp';

const SideBar = ({ usuario }) => {
    return (
        <div>
        <div className="sidebar-container">{
            <div id="offcanvas-menu" className="offcanvas offcanvas-start bg-body show" style={{ width: '200px'  }} tabIndex="-1" data-bs-backdrop="false">
            <div className="offcanvas-header">
                <NavLink className="link-body-emphasis d-flex align-items-center me-md-auto mb-3 mb-md-0 text-decoration-none" to="">
                    <span className="fs-4">Administrar datos</span>
                </NavLink>
            </div>
            <div className="offcanvas-body d-flex flex-column justify-content-between pt-0">
                <div>
                    <hr className="mt-0" />
                    <ul className="nav nav-pills flex-column mb-auto">
                        <li className="nav-item">
                            <NavLink 
                                className={({ isActive }) => isActive ? "nav-link active link-light" : "nav-link link-body-emphasis"} 
                                to="/GestionarUsuario" 
                                style={({ isActive }) => ({
                                    backgroundColor: isActive ? 'rgb(4, 36, 64)' : 'transparent',
                                })}
                            >
                                Usuarios
                            </NavLink>
                        </li>
                        <li className="nav-item">
                            <NavLink 
                                className={({ isActive }) => isActive ? "nav-link active link-light" : "nav-link link-body-emphasis"} 
                                to="/CategoriaApp" 
                                style={({ isActive }) => ({
                                    backgroundColor: isActive ? 'rgb(4, 36, 64)' : 'transparent',
                                })}
                            >
                                Categorias
                            </NavLink>
                        </li>
                        <li className="nav-item">
                            <NavLink 
                                className={({ isActive }) => isActive ? "nav-link active link-light" : "nav-link link-body-emphasis"} 
                                to="/ComentarioApp" 
                                style={({ isActive }) => ({
                                    backgroundColor: isActive ? 'rgb(4, 36, 64)' : 'transparent',
                                })}
                            >
                                Comentarios
                            </NavLink>
                        </li>
                        <li className="nav-item">
                            <NavLink 
                                className={({ isActive }) => isActive ? "nav-link active link-light" : "nav-link link-body-emphasis"} 
                                to="/ProductoApp" 
                                style={({ isActive }) => ({
                                    backgroundColor: isActive ? 'rgb(4, 36, 64)' : 'transparent',
                                })}
                            >
                                Productos
                            </NavLink>
                        </li>
                        <li className="nav-item">
                            <NavLink 
                                className={({ isActive }) => isActive ? "nav-link active link-light" : "nav-link link-body-emphasis"} 
                                to="/PromocionApp" 
                                style={({ isActive }) => ({
                                    backgroundColor: isActive ? 'rgb(4, 36, 64)' : 'transparent',
                                })}
                            >
                                Promociones
                            </NavLink>
                        </li>

                        <li className="nav-item">
                            <NavLink 
                                className={({ isActive }) => isActive ? "nav-link active link-light" : "nav-link link-body-emphasis"} 
                                to="/TipoPagoApp" 
                                style={({ isActive }) => ({
                                    backgroundColor: isActive ? 'rgb(4, 36, 64)' : 'transparent',
                                })}
                            >
                                Tipo Pago
                            </NavLink>
                        </li>

                        <li className="nav-item">
                            <NavLink 
                                className={({ isActive }) => isActive ? "nav-link active link-light" : "nav-link link-body-emphasis"} 
                                to="/PedidosApp"
                                style={({ isActive }) => ({
                                    backgroundColor: isActive ? 'rgb(4, 36, 64)' : 'transparent',
                                })} 
                            >
                                Pedidos
                            </NavLink>
                        </li>
                    </ul>
                </div>
                <div>
                    <hr />
                    <div className="dropdown">
                        <a className="dropdown-toggle link-body-emphasis d-flex align-items-center text-decoration-none" data-bs-toggle="dropdown" href="/principal" role="button" aria-expanded="false">
                            <img className="rounded-circle me-2" alt="User" width="32" height="32" src="https://cdn.bootstrapstudio.io/placeholders/1400x800.png" style={{ objectFit: 'cover' }} />
                            <strong>{usuario ? usuario.nombreUsuario : "User"}</strong>
                        </a>
                        <div className="dropdown-menu shadow text-small">
                            <NavLink className="dropdown-item" to="/">New project...</NavLink>
                            <NavLink className="dropdown-item" to="/settings">Settings</NavLink>
                            <NavLink className="dropdown-item" to="/profile">Profile</NavLink>
                            <div className="dropdown-divider"></div>
                            <NavLink className="dropdown-item" to="/signout">Sign out</NavLink>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    }
    </div>  
    
    </div>
    );
};

export default SideBar;

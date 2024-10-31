// SideBar.js
import React from 'react';
import { NavLink } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';

const SideBar = ({ usuario }) => {
    return (
        <div id="offcanvas-menu" className="offcanvas offcanvas-start bg-body show" style={{ width: '250px' }} tabIndex="-1" data-bs-backdrop="false">
            <div className="offcanvas-header">
                <NavLink className="link-body-emphasis d-flex align-items-center me-md-auto mb-3 mb-md-0 text-decoration-none" to="/">
                    <svg className="bi bi-clipboard-minus me-3" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor" viewBox="0 0 16 16" style={{ fontSize: '25px' }}>
                        <path fillRule="evenodd" d="M5.5 9.5A.5.5 0 0 1 6 9h4a.5.5 0 0 1 0 1H6a.5.5 0 0 1-.5-.5"></path>
                        <path d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1h1a1 1 0 0 1 1 1V14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V3.5a1 1 0 0 1 1-1h1z"></path>
                        <path d="M9.5 1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5zm-3-1A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0z"></path>
                    </svg>
                    <span className="fs-4">Administrar Datos</span>
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
                                to="/comentarios" 
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
                    </ul>
                </div>
                <div>
                    <hr />
                    <div className="dropdown">
                        <a className="dropdown-toggle link-body-emphasis d-flex align-items-center text-decoration-none" data-bs-toggle="dropdown" href="/" role="button" aria-expanded="false">
                            <img className="rounded-circle me-2" alt="User" width="32" height="32" src="https://cdn.bootstrapstudio.io/placeholders/1400x800.png" style={{ objectFit: 'cover' }} />
                            <strong>{usuario ? usuario.nombreUsuario : "User"}</strong>
                        </a>
                        <div className="dropdown-menu shadow text-small">
                            <NavLink className="dropdown-item" to="/new-project">New project...</NavLink>
                            <NavLink className="dropdown-item" to="/settings">Settings</NavLink>
                            <NavLink className="dropdown-item" to="/profile">Profile</NavLink>
                            <div className="dropdown-divider"></div>
                            <NavLink className="dropdown-item" to="/signout">Sign out</NavLink>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default SideBar;

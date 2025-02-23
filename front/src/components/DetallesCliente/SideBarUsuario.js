import React from 'react';
import { NavLink } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import './SideBarUsuario.css';
import FooterApp from '../Footer/FooterApp';

const SideBarUsuario = ({ usuario }) => {
    return (
        <div className="sidebar-container">{
            <div id="offcanvas-menu"
                className="offcanvas offcanvas-start bg-body show"
                style={{ width: '200px', height: 'auto', maxHeight: '70vh' }}
                tabIndex="-1"
                data-bs-backdrop="false"
            >

                <div className="offcanvas-header">
                    <NavLink className="link-body-emphasis d-flex align-items-center me-md-auto mb-3 mb-md-0 text-decoration-none" to="">
                        <span className="fs-4">Mi Cuenta</span>
                    </NavLink>
                </div>
                <div className="offcanvas-body d-flex flex-column justify-content-between pt-0">
                    <div>
                        <hr className="mt-0" />
                        <ul className="nav nav-pills flex-column mb-auto">
                            <li className="nav-item">
                                <NavLink
                                    className={({ isActive }) => isActive ? "nav-link active link-light" : "nav-link link-body-emphasis"}
                                    to="/Dashboard"
                                    style={({ isActive }) => ({
                                        backgroundColor: isActive ? 'rgb(4, 36, 64)' : 'transparent',
                                    })}
                                >
                                    Panel
                                </NavLink>
                            </li>
                            <li className="nav-item">
                                <NavLink
                                    className={({ isActive }) => isActive ? "nav-link active link-light" : "nav-link link-body-emphasis"}
                                    to="/"
                                    style={({ isActive }) => ({
                                        backgroundColor: isActive ? 'rgb(4, 36, 64)' : 'transparent',
                                    })}
                                >
                                    Pedidos
                                </NavLink>
                            </li>
                            <li className="nav-item">
                                <NavLink
                                    className={({ isActive }) => isActive ? "nav-link active link-light" : "nav-link link-body-emphasis"}
                                    to="/"
                                    style={({ isActive }) => ({
                                        backgroundColor: isActive ? 'rgb(4, 36, 64)' : 'transparent',
                                    })}
                                >
                                    Comprobantes
                                </NavLink>
                            </li>
                            <li className="nav-item">
                                <NavLink
                                    className={({ isActive }) => isActive ? "nav-link active link-light" : "nav-link link-body-emphasis"}
                                    to="/"
                                    style={({ isActive }) => ({
                                        backgroundColor: isActive ? 'rgb(4, 36, 64)' : 'transparent',
                                    })}
                                >
                                    Direccion
                                </NavLink>
                            </li>
                            <li className="nav-item">
                                <NavLink
                                    className={({ isActive }) => isActive ? "nav-link active link-light" : "nav-link link-body-emphasis"}
                                    to="/PerfilUsuario"
                                    style={({ isActive }) => ({
                                        backgroundColor: isActive ? 'rgb(4, 36, 64)' : 'transparent',
                                    })}
                                >
                                    Detalles de la cuenta
                                </NavLink>
                            </li>

                            <li className="nav-item">
                                <NavLink
                                    className={({ isActive }) => isActive ? "nav-link active link-light" : "nav-link link-body-emphasis"}
                                    to="/"
                                    style={({ isActive }) => ({
                                        backgroundColor: isActive ? 'rgb(4, 36, 64)' : 'transparent',
                                    })}
                                >
                                    Cerrar sesion
                                </NavLink>
                            </li>
                        </ul>
                    </div>
                    <div>
                        <hr />

                    </div>
                </div>

            </div>

        }</div>
    );
};

export default SideBarUsuario;

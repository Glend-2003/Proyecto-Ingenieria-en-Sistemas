import React, { useEffect, useState } from 'react';
import axios from 'axios';
//import { useNavigate } from 'react-router-dom';
import { NavLink, useNavigate } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import { FaWpforms, FaStar, FaUserCircle } from 'react-icons/fa'; // Actualizamos las importaciones
//import Navbar from './Navbar';
import useAuth from '../../hooks/useAuth';
import SideBar from '../SideBar/SideBar';
import { Button } from 'react-bootstrap';
import FooterApp from '../Footer/FooterApp';
import "./Principal.css";
import { useAppContext } from "../Navbar/AppContext";

const Principal = () => {
    const { usuario} = useAuth();
    const {handleLogout} = useAppContext();

    const navigate = useNavigate();
    
   

    return (
        <div className="principal-container">
            <SideBar usuario={usuario} /> 

            <main className="page">
                <section className="portfolio-block hire-me">
                    <div className="container">
                        <div className="heading">
                            <h2>Bienvenido a la página principal</h2>
                        </div>
                        <div className="border rounded border-0 shadow-lg p-3 p-md-5" data-bs-theme="light">
                            {usuario ? (
                                <div>
                                    <h2>Información personal</h2>
                                    <p>Nombre: {usuario.nombreUsuario + " " +usuario.primerApellido}</p>
                                    <p>Correo: {usuario.correoUsuario}</p>
                                    <p>Rol: {usuario.rol.nombreRol}</p>
                                    <Button className="custom-button" onClick={handleLogout} style={{ cursor: 'pointer' }}>
                                        Cerrar sesión
                                    </Button>
                                </div>
                            ) : (
                                <p>Cargando información del usuario...</p>
                            )}
                        </div>
                        
                    </div>
                </section>
            </main>
            <FooterApp />
        </div>
    );
};

export default Principal;

import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const Principal = () => {
    const [usuario, setUsuario] = useState(null);
    const navigate = useNavigate();

    useEffect(() => {
        const token = localStorage.getItem('token');

        if (token) {
            axios.get('http://localhost:8080/usuario/datos', {
                headers: {
                    'Authorization': `Bearer ${token}`
                }
            })
            .then(response => {
                setUsuario(response.data);
            })
            .catch(error => {
                console.error('Error al obtener los datos del usuario:', error);
                // Si hay un error, limpiar el almacenamiento y redirigir al login
                localStorage.removeItem('token');
                localStorage.removeItem('correoUsuario');
                navigate('/');
            });
        } else {
            // Si no hay token, redirigir al login
            navigate('/');
        }
    }, [navigate]);

    const handleLogout = () => {
        localStorage.removeItem('token');
        localStorage.removeItem('correoUsuario');
        navigate('/'); // Redirigir al login
    };

    return (
        <div>
            <h1>Bienvenido a la página principal</h1>
            {usuario ? (
                <div>
                    <h2>Nombre: {usuario.nombreUsuario}</h2>
                    <p>Correo: {usuario.correoUsuario}</p>
                    <p>Rol: {usuario.rol.nombreRol}</p>
                    <p>Teléfono: {usuario.telefonoUsuario}</p>
                    <button onClick={handleLogout}>Cerrar sesión</button>
                </div>
            ) : (
                <p>Cargando información del usuario...</p>
            )}
        </div>
    );
};

export default Principal;

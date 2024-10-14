// principal.js

import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const Principal = () => {
    const [usuario, setUsuario] = useState(null);
    const navigate = useNavigate();

    useEffect(() => {
        const token = localStorage.getItem('token');
        const nombreUsuario = localStorage.getItem('nombreUsuario'); // Obtenemos el nombre de usuario almacenado
    
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
                localStorage.removeItem('token');
                localStorage.removeItem('correoUsuario');
                localStorage.removeItem('nombreUsuario'); // Limpiar también el nombreUsuario
                navigate('/');
            });
        } else {
            navigate('/');
        }
    }, [navigate]);

    const handleLogout = () => {
        localStorage.removeItem('token');
        localStorage.removeItem('correoUsuario');
        navigate('/');
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

                    {/* Mostrar el botón de gestionar categoría solo si el rol es Administrador o Gerente */}
                    {(usuario.rol.nombreRol === 'Administrador' || usuario.rol.nombreRol === 'Gerente') && (
                        <button onClick={() => navigate('/CategoriaApp')}>
                            Gestionar Categoría
                        </button>
                        
                        
                    )}

                    {/* Mostrar el botón de gestionar categoría solo si el rol es Administrador o Gerente */}
                    {(usuario.rol.nombreRol === 'Administrador' || usuario.rol.nombreRol === 'Gerente') && (
                        <button onClick={() => navigate('/GestionarUsuario')}>
                            Gestionar Usuarios
                        </button>
                        
                        
                    )}
                            
                    <button onClick={handleLogout}>Cerrar sesión</button>
                </div>
            ) : (
                <p>Cargando información del usuario...</p>
            )}
        </div>
    );
};

export default Principal;

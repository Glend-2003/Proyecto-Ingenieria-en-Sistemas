// src/components/PrivateRoute.js
import React from 'react';
import { Navigate } from 'react-router-dom';
import { useAppContext } from './Navbar/AppContext'; // O la ruta correcta a tu AppContext

const PrivateRoute = ({ children, allowedRoles }) => {
  const token = localStorage.getItem('token');
  const userRole = localStorage.getItem('nombreRol'); // Esto será "Usuario"

  if (!token) {
    return <Navigate to="/" replace />;
  }

  if (allowedRoles) {
    if (!userRole) {
      return <Navigate to="/" replace />;
    }
    // AQUÍ ESTÁ EL PUNTO CLAVE:
    // allowedRoles es ['Administrador']
    // userRole es "Usuario"
    // ['Administrador'].includes("Usuario") es false
    if (!allowedRoles.includes(userRole)) {
      // Debería entrar aquí y redirigir
      return <Navigate to="/" replace />;
    }
  }
  return children; // Si llega aquí, permite el acceso
};

export default PrivateRoute;
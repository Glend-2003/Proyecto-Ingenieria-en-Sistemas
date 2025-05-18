// src/hooks/useAuth.js
import { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import { useAppContext } from '../components/Navbar/AppContext'; // Ajusta la ruta

const useAuth = (redirectIfNoToken = false) => { // Parámetro para controlar redirección
  const [usuario, setUsuario] = useState(null);
  const [loadingAuth, setLoadingAuth] = useState(true);
  const navigate = useNavigate();
  const appContext = useAppContext();

  const clearUserSession = useCallback(() => {
    localStorage.removeItem('token');
    localStorage.removeItem('idUsuario');
    localStorage.removeItem('nombreUsuario');
    localStorage.removeItem('correoUsuario');
    localStorage.removeItem('nombreRol');
    setUsuario(null);
    if (appContext && typeof appContext.updateUserStatus === 'function') {
      appContext.updateUserStatus();
    }
  }, [appContext]);

  const handleLogout = useCallback(() => {
    clearUserSession();
    navigate('/');
  }, [clearUserSession, navigate]);

  useEffect(() => {
    const token = localStorage.getItem('token');
    setLoadingAuth(true);
    if (token) {
      axios.get('http://localhost:8080/usuario/datos', {
        headers: { 'Authorization': `Bearer ${token}` }
      })
      .then(response => {
        setUsuario(response.data);
        if (appContext && typeof appContext.updateUserStatus === 'function') {
          appContext.updateUserStatus();
        }
      })
      .catch(() => {
        clearUserSession();
        if (redirectIfNoToken) { navigate('/'); } // Redirige solo si se especifica
      })
      .finally(() => setLoadingAuth(false));
    } else {
      clearUserSession(); // Limpia cualquier dato de sesión residual
      if (redirectIfNoToken) { navigate('/'); } // Redirige solo si se especifica
      setLoadingAuth(false);
    }
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [redirectIfNoToken, clearUserSession]); // `Maps` se puede quitar si solo se usa en handleLogout o si su cambio no debe disparar esto.

  return { usuario, loadingAuth, handleLogout };
};

export default useAuth;
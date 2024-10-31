// useAuth.js
import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';

const useAuth = () => {
  const [usuario, setUsuario] = useState(null);
  const navigate = useNavigate();

  useEffect(() => {
    const token = localStorage.getItem('token');

    if (token) {
      axios.get('http://localhost:8080/usuario/datos', {
        headers: { 'Authorization': `Bearer ${token}` }
      })
      .then(response => {
        setUsuario(response.data);
      })
      .catch(() => {
        handleLogout();
      });
    }
  }, []);

  const handleLogout = () => {
    localStorage.removeItem('token');
    setUsuario(null);
    navigate('/');
  };

  return { usuario, handleLogout };
};

export default useAuth;

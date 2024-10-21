import { useEffect, useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const useAuth = () => {
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
                localStorage.removeItem('token');
                localStorage.removeItem('correoUsuario');
                localStorage.removeItem('nombreUsuario');
                navigate('/');
            });
        } else {
            navigate('/');
        }
    }, [navigate]);

    const handleLogout = () => {
        localStorage.removeItem('token');
        localStorage.removeItem('correoUsuario');
        localStorage.removeItem('nombreUsuario');
        navigate('/');
    };

    return { usuario, handleLogout };
};

export default useAuth;

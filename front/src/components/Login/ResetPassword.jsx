import React, { useState } from 'react';
import axios from 'axios';
import { useLocation, useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';
import 'bootstrap/dist/css/bootstrap.min.css';
import '../styles.min.css';
import Snackbar from '@mui/material/Snackbar';
import MuiAlert from '@mui/material/Alert';
import '../Usuarios/Usuarios.css'; // Importa el CSS de Usuarios

// Componente Alert personalizado
const Alert = React.forwardRef(function Alert(props, ref) {
  return <MuiAlert elevation={6} ref={ref} variant="filled" {...props} />;
});

function ResetPassword() {
  const location = useLocation();
  const navigate = useNavigate();
  const { correoUsuario } = location.state || { correoUsuario: '' };

  const [form, setForm] = useState({
    codigoVerificacion: '',
    nuevaContrasenia: '',
    confirmarContrasenia: '',
  });

  const [passwordErrorMsg, setPasswordErrorMsg] = useState('');
  const [openSnackbar, setOpenSnackbar] = useState(false);
  const [snackbarMessage, setSnackbarMessage] = useState('');
  const [snackbarSeverity, setSnackbarSeverity] = useState('success');

  const handleChange = (e) => {
    const { name, value } = e.target;
    setForm({
      ...form,
      [name]: value,
    });

    if (name === 'nuevaContrasenia' || name === 'confirmarContrasenia') {
      if (form.nuevaContrasenia !== form.confirmarContrasenia) {
        setPasswordErrorMsg('Las contraseñas no coinciden');
      } else {
        setPasswordErrorMsg('');
      }
    }
  };

  const handleOpenSnackbar = (message, severity) => {
    setSnackbarMessage(message);
    setSnackbarSeverity(severity);
    setOpenSnackbar(true);
  };

  const handleCloseSnackbar = (event, reason) => {
    if (reason === 'clickaway') {
      return;
    }
    setOpenSnackbar(false);
  };

  const handleResetPassword = async (e) => {
    e.preventDefault();

    if (form.nuevaContrasenia !== form.confirmarContrasenia) {
      handleOpenSnackbar('Las contraseñas no coinciden', 'error');
      return;
    }

    try {
      const response = await axios.post('http://localhost:8080/usuario/cambiarContrasena', {
        numCodigo: form.codigoVerificacion,
        nuevaContrasenia: form.nuevaContrasenia,
      });

      if (response.status === 200) {
        handleOpenSnackbar('Contraseña cambiada con éxito', 'success');
        setTimeout(() => {
          navigate('/login');
        }, 2000);
      }
    } catch (error) {
      handleOpenSnackbar('Error al cambiar la contraseña: ' + error.message, 'error');
    }
  };

 // Falta el resto de la vista ......
}

export default ResetPassword;
import React, { useState } from 'react';
import axios from 'axios';
import { useLocation, useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';
import 'bootstrap/dist/css/bootstrap.min.css';
import '../styles.min.css';
import Snackbar from '@mui/material/Snackbar';
import MuiAlert from '@mui/material/Alert';
import './ResetPassword.css';
import FooterApp from '../Footer/FooterApp';

const Alert = React.forwardRef(function Alert(props, ref) {
  return <MuiAlert elevation={6} ref={ref} variant="filled" {...props} />;
});

function ResetPassword() {
  const location = useLocation();
  const navigate = useNavigate();
  const { correoUsuario } = location.state || { correoUsuario: '' };

  const [form, setForm] = useState({
    codigoVerificacion: Array(6).fill(''), // Array para almacenar los 6 dígitos
    nuevaContrasenia: '',
    confirmarContrasenia: '',
  });

  const [passwordErrorMsg, setPasswordErrorMsg] = useState('');
  const [openSnackbar, setOpenSnackbar] = useState(false);
  const [snackbarMessage, setSnackbarMessage] = useState('');
  const [snackbarSeverity, setSnackbarSeverity] = useState('success');

  const handleCodigoChange = (index, value) => {
    const newCodigo = [...form.codigoVerificacion];

    if (value.length > 1) {
      const digits = value.split('').slice(0, 6);
      digits.forEach((digit, i) => {
        if (index + i < 6) {
          newCodigo[index + i] = digit.replace(/\D/, '');
        }
      });
    } else {
      newCodigo[index] = value.replace(/\D/, '');
    }

    setForm({
      ...form,
      codigoVerificacion: newCodigo,
    });

    if (value && index < 5) {
      document.getElementById(`codigo-${index + 1}`).focus();
    }
  };

  const handleKeyDown = (index, e) => {
    if (e.key === 'Backspace' && !form.codigoVerificacion[index] && index > 0) {
      document.getElementById(`codigo-${index - 1}`).focus();
    }
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setForm((prevForm) => ({
      ...prevForm,
      [name]: value,
    }));
  };

  const validatePassword = (password) => {
    // Verifica que la contraseña tenga al menos 8 caracteres
    const minLength = password.length >= 8;

    // Verifica que la contraseña tenga al menos 2 letras (mayúsculas o minúsculas)
    const hasTwoLetters = (password.match(/[a-zA-Z]/g) || []).length >= 2;

    // Retorna true si se cumplen ambas condiciones
    return minLength && hasTwoLetters;
  };

  const handleResetPassword = async (e) => {
    e.preventDefault();

    const codigoCompleto = form.codigoVerificacion.join('');

    if (codigoCompleto.length !== 6) {
      handleOpenSnackbar('Por favor, ingresa los 6 dígitos del código', 'error');
      return;
    }

    if (form.nuevaContrasenia !== form.confirmarContrasenia) {
      handleOpenSnackbar('Las contraseñas no coinciden', 'error');
      return;
    }

    if (!validatePassword(form.nuevaContrasenia)) {
      handleOpenSnackbar('La contraseña debe tener al menos 8 caracteres y 2 letras', 'error');
      return;
    }

    try {
      const response = await axios.post('http://localhost:8080/usuario/cambiarContrasena', {
        numCodigo: codigoCompleto,
        nuevaContrasenia: form.nuevaContrasenia,
      });

      if (response.status === 200) {
        handleOpenSnackbar('Contraseña cambiada con éxito', 'success');
        setTimeout(() => {
          navigate('/principal');
        }, 2000);
      }
    } catch (error) {
      if (error.response && error.response.status === 400) {
        handleOpenSnackbar('Código incorrecto o inexistente', 'error');
      } else {
        handleOpenSnackbar('Error al cambiar la contraseña: ' + error.message, 'error');
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

  return (
    <div className="body-register">
      <div className="registrar-container">
        <div className="bg-white">
          <div className="text-center">
            <h4 className="text-dark mb-4">Cambiar Contraseña</h4>
          </div>
          <form onSubmit={handleResetPassword}>
            <div className="mb-3">
              <label className="form-label d-block text-center" htmlFor="codigoVerificacion">
                Código de Verificación
              </label>
              <div className="d-flex justify-content-center">
                {form.codigoVerificacion.map((digit, index) => (
                  <input
                    key={index}
                    id={`codigo-${index}`}
                    className="form-control text-center mx-1"
                    type="text"
                    maxLength={1}
                    value={digit}
                    onChange={(e) => handleCodigoChange(index, e.target.value)}
                    onKeyDown={(e) => handleKeyDown(index, e)}
                    style={{ width: '30px', height: '40px', fontSize: '18px' }}
                    required
                  />
                ))}
              </div>
            </div>
            <div className="row mb-3">
              <div className="col-sm-6 mb-3 mb-sm-0">
                <label className="form-label" htmlFor="nuevaContrasenia">
                  Nueva Contraseña
                </label>
                <input
                  className="form-control"
                  type="password"
                  name="nuevaContrasenia"
                  placeholder="Nueva contraseña"
                  value={form.nuevaContrasenia}
                  onChange={handleChange}
                  required
                />
              </div>
              <div className="col-sm-6">
                <label className="form-label" htmlFor="confirmarContrasenia">
                  Confirmar Contraseña
                </label>
                <input
                  className="form-control"
                  type="password"
                  name="confirmarContrasenia"
                  placeholder="Confirmar nueva contraseña"
                  value={form.confirmarContrasenia}
                  onChange={handleChange}
                  required
                />
              </div>
            </div>
            {passwordErrorMsg && <p className="text-danger">{passwordErrorMsg}</p>}
            <button
              className="btn btn-primary"
              type="submit"
            >
              Cambiar Contraseña
            </button>
            <hr />
            <p className="text-center">
              <span
                className="text-primary"
                onClick={() => navigate('/principal')}
              >
                Volver al inicio de sesión
              </span>
            </p>
          </form>
        </div>
      </div>

      <Snackbar
        open={openSnackbar}
        autoHideDuration={2500}
        onClose={handleCloseSnackbar}
        anchorOrigin={{ vertical: 'top', horizontal: 'right' }}
      >
        <Alert onClose={handleCloseSnackbar} severity={snackbarSeverity} sx={{ width: '100%' }}>
          {snackbarMessage}
        </Alert>
      </Snackbar>

      <FooterApp />
    </div>
  );
}

export default ResetPassword;
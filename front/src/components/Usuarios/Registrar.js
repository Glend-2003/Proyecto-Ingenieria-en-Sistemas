import React, { useState, useEffect } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import { toast, ToastContainer } from "react-toastify"; // Importar toast y ToastContainer
import "react-toastify/dist/ReactToastify.css";
import "bootstrap/dist/css/bootstrap.min.css";
import "../styles.min.css";
import Snackbar from '@mui/material/Snackbar';
import MuiAlert from '@mui/material/Alert';
import "../Usuarios/Usuarios.css";
import FooterApp from '../Footer/FooterApp';

const Registrar = () => {
    
  const [correoUsuario, setEmail] = useState("");
  const [nombreUsuario, setName] = useState("");
  const [primerApellido, setFirstSurname] = useState("");
  const [segundoApellido, setSecondSurname] = useState("");
  const [contraseniaUsuario, setPassword] = useState("");
  const [verifyPassword, setVerifyPassword] = useState("");
  const [emailErrorMsg, setEmailErrorMsg] = useState("");
  const [passwordErrorMsg, setPasswordErrorMsg] = useState("");
const [idRol, setIdRol] = useState(null);

  const Alert = React.forwardRef(function Alert(props, ref) {return <MuiAlert elevation={6} ref={ref} variant="filled" {...props} />;});
  const [openSnackbar, setOpenSnackbar] = useState(false);
  const [snackbarMessage, setSnackbarMessage] = useState('');
  const [snackbarSeverity, setSnackbarSeverity] = useState('success'); // 'success', 'error', 'warning', 'info'


  const navigate = useNavigate();

  useEffect(() => {
    document.body.classList.add("body-register");

    // Eliminar la clase cuando el componente se desmonta
    return () => {
      document.body.classList.remove("body-register");
    };
  }, []);

  const validateEmail = (correoUsuario) => {
    const regex = /^[^@]+@[^@]+\.[^@]+$/;
    return regex.test(correoUsuario);
  };

  const handleEmailChange = (e) => {
    setEmail(e.target.value);
    if (validateEmail(e.target.value)) {
      setEmailErrorMsg("");
    } else {
      setEmailErrorMsg("Correo inválido");
    }
  };

  const handleNameChange = (e) => {
    setName(e.target.value);
  };

  const handleFirstSurnameChange = (e) => {
    setFirstSurname(e.target.value);
  };

  const handleSecondSurnameChange = (e) => {
    setSecondSurname(e.target.value);
  };



  //Implementación de Snackbar 
  const handleOpenSnackbar = (message, severity) => {
    setSnackbarMessage(message);
    setSnackbarSeverity(severity);
    setOpenSnackbar(true);
  };
  
  const handleCloseSnackbar = (event, reason) => {
    if (reason === 'clickaway') {
      return; // No cerrar el Snackbar si el usuario hace clic fuera
    }
    setOpenSnackbar(false);
  };




  const handlePasswordChange = (e) => {
    setPassword(e.target.value);
    if (e.target.value === verifyPassword) {
      if (e.target.value.length >= 8) {
        setPasswordErrorMsg("");
      } else {
        setPasswordErrorMsg("La contraseña debe tener al menos 8 caracteres");
      }
    } else {
      setPasswordErrorMsg("Las contraseñas no coinciden");
    }
  };

  const handleVerifyPasswordChange = (e) => {
    setVerifyPassword(e.target.value);
    if (e.target.value === contraseniaUsuario) {
      if (e.target.value.length >= 8) {
        setPasswordErrorMsg("");
      } else {
        setPasswordErrorMsg("La contraseña debe tener al menos 8 caracteres");
      }
    } else {
      setPasswordErrorMsg("Las contraseñas no coinciden");
    }
  };

  const handleSubmit = (e) => {
    e.preventDefault();

    if (
      correoUsuario &&
      nombreUsuario &&
      primerApellido &&
      segundoApellido &&
      contraseniaUsuario
    ) {
      if (emailErrorMsg === "" && passwordErrorMsg === "") {
        // Handle form submission

        const registroData = {
          correoUsuario: correoUsuario,
          nombreUsuario: nombreUsuario,
          primerApellido: primerApellido,
          segundoApellido: segundoApellido,
          contraseniaUsuario: contraseniaUsuario,
        }

        console.log(" Datos enviados al backend:", registroData);
        axios
          .post("http://localhost:8080/usuario/registrar", registroData)
          .then((response) => {
            console.log("Usuario registrado con éxito:", response.data);
            handleOpenSnackbar("Usuario registrado con éxito", "success");
            setTimeout(() => {
              navigate("../");
            }, 2500);
          })
          .catch((error) => {
            if (error.response) {
              console.error(
                "Error de respuesta del servidor:",
                error.response.data
              );
              handleOpenSnackbar("Error de respuesta del servidor", "error");
            } else if (error.request) {
              console.error("No hubo respuesta del servidor:", error.request);
              handleOpenSnackbar("No hubo respuesta del servidor", "error");
            } else {
              console.error("Error en la solicitud:", error.message);
              handleOpenSnackbar("Error en la solicitud", "error");
            }
          });
      }
    } else {
      console.error("Error: Todos los campos son obligatorios");
      handleOpenSnackbar("Todos los campos son obligatorios", "error");
    }
  };

  const handleNoAccountClick = () => {
    navigate("../");
  };
  return (
    <div >
     <div className=".registrar-container d-flex justify-content-center align-items-center" style={{ minHeight: '100vh' }}>
      <div className="row d-flex justify-content-center">
        <div
          className="col-sm-12 col-lg-10 col-xl-9 col-xxl-10 bg-white shadow-lg"
          style={{ borderRadius: "5px" }}
        >
          <div className="p-5">
            <div className="text-center">
              <h4 className="text-dark mb-4">Crear una cuenta</h4>
            </div>
            <form className="user" onSubmit={handleSubmit}>
              <div className="mb-3">
                <label className="form-label" htmlFor="correoUsuario">
                  Correo Electrónico
                </label>
                <input
                  className="form-control form-control-user"
                  type="email"
                  id="email"
                  
                  required
                  value={correoUsuario}
                  onChange={handleEmailChange}
                  style={{ borderColor: "#d7d7d7", color: "#212529" }}
                />
                {emailErrorMsg && (
                  <p className="text-danger">{emailErrorMsg}</p>
                )}
              </div>
              <div className="row mb-3">
                <div className="col-sm-6 col-md-4 mb-3 mb-sm-0">
                  <label classname="form-label" htmlFor="nombreUsuario">
                    Nombre
                  </label>
                  <input
                    className="form-control form-control-user"
                    type="text"
                    
                    required
                    value={nombreUsuario}
                    onChange={handleNameChange}
                  />
                </div>
                <div className="col-sm-6 col-md-4">
                  <label classname="form-label" htmlFor="primerApellido">
                    Primer Apellido
                  </label>
                  <input
                    className="form-control form-control-user"
                    type="text"
                    
                    required
                    value={primerApellido}
                    onChange={handleFirstSurnameChange}
                  />
                </div>
                <div className="col-sm-6 col-md-4">
                  <label classname="form-label" htmlFor="segundoApellido">
                    Segundo Apellido
                  </label>
                  <input
                    className="form-control form-control-user"
                    type="text"
                    
                    required
                    value={segundoApellido}
                    onChange={handleSecondSurnameChange}
                  />
                </div>
              </div>
              <div className="row mb-3">
                <div className="col-sm-6 mb-3 mb-sm-0">
                  <label className="form-label" htmlFor="contraseniaUsuario">
                    Contraseña
                  </label>
                  <input
                    className="form-control form-control-user"
                    type="password"
                    id="password"
                    
                    required
                    value={contraseniaUsuario}
                    onChange={handlePasswordChange}
                  />
                </div>
                <div className="col-sm-6">
                  <label className="form-label" htmlFor="verifyPassword">
                    Confirmar Contraseña
                  </label>
                  <input
                    className="form-control form-control-user"
                    type="password"
                    id="verifyPassword"
                 
                    required
                    value={verifyPassword}
                    onChange={handleVerifyPasswordChange}
                  />
                </div>
              </div>
              {passwordErrorMsg && (
                <p className="text-danger">{passwordErrorMsg}</p>
              )}
              <button
                className="btn btn-primary d-block btn-user w-100"
                id="submitBtn"
                type="submit"
                style={{ background: "#042440" }}
              >
                Registrar cuenta
              </button>
              <hr />
              <p className="text-center">
                <span
                  className="text-primary"
                  style={{ cursor: "pointer" }}
                  onClick={handleNoAccountClick}
                >
                  Regresar
                </span>
              </p>
            </form>
            
          </div>
        </div>
       
      </div>
      <Snackbar
        open={openSnackbar}
        autoHideDuration={2500} // Duración en milisegundos
        onClose={handleCloseSnackbar}
        anchorOrigin={{ vertical: 'top', horizontal: 'right' }} // Posición del Snackbar
      >
        <Alert onClose={handleCloseSnackbar} severity={snackbarSeverity} sx={{ width: '100%' }}>
          {snackbarMessage}
        </Alert>
      </Snackbar>
    </div>
    <FooterApp />
    </div>
  );
};

export default Registrar;

import React, { useState, useEffect } from "react";
import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import {useNavigate } from 'react-router-dom';
import axios from "axios";
import "bootstrap/dist/css/bootstrap.min.css";
import "./PerfilUsuario.css";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faSave, faPhone, faIdCard, faCalendarAlt } from "@fortawesome/free-solid-svg-icons";
import useAuth from "../../hooks/useAuth";
import FooterApp from '../Footer/FooterApp';
import NavbarApp from "../Navbar/NavbarApp";
import Carrito from "../Carrito/CarritoApp";
import SideBarUsuario from '../DetallesCliente/SideBarUsuario';
import { useAppContext } from "../Navbar/AppContext";

const PerfilUsuario = () => {
  const { usuario } = useAuth();
  const navigate = useNavigate();
  const [userEdit, setUserEdit] = useState(null);
  const [cedulaValidation, setCedulaValidation] = useState({
      isValid: false,
      isChecking: false,
      wasChecked: false,
      message: ''
  });

  const [formData, setFormData] = useState({
    cedulaUsuario: "",
    nombreUsuario: "",
    primerApellido: "",
    segundoApellido: "",
    telefonoUsuario: "",
    fechaNacimiento: "",
   
  });

  const { handleLogout} = useAppContext();
  const [isEditing, setIsEditing] = useState(false);

  useEffect(() => {
    if (usuario) {
      setFormData({ ...usuario });
    // Formatear la fecha para el input type="date"
      if (usuario.fechaNacimiento) {
        const fecha = new Date(usuario.fechaNacimiento);
        const formattedDate = fecha.toISOString().split('T')[0];
        setFormData(prev => ({ ...prev, fechaNacimiento: formattedDate }));
      
        if (usuario.cedulaUsuario) {
          validarCedula(usuario.cedulaUsuario);
        }
      }
    }
  }, [usuario]);

  useEffect(() => {
    const delayDebounceFn = setTimeout(() => {
      if (formData.cedulaUsuario && formData.cedulaUsuario.trim() !== '' && isEditing) {
        validarCedula(formData.cedulaUsuario);
      }
    }, 1000);
    return () => clearTimeout(delayDebounceFn);
  }, [formData.cedulaUsuario, isEditing]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    
    if (name === 'cedulaUsuario') {
      setCedulaValidation({
        isValid: false,
        isChecking: false,
        wasChecked: false,
        message: ''
      });
    }
    
    setFormData({ ...formData, [name]: value });
  };

  const validarCedula = async (cedula) => {
    const cedulaRegex = /^\d{9}$/;
    if (!cedulaRegex.test(cedula)) {
      setCedulaValidation({
        isValid: false,
        isChecking: false,
        wasChecked: true,
        message: 'La cédula debe contener exactamente 9 dígitos numéricos'
      });
      return;
    }
    
    if (!cedula || cedula.trim().length === 0) {
      setCedulaValidation({
        isValid: false,
        isChecking: false,
        wasChecked: true,
        message: 'Ingrese un número de cédula válido'
      });
      return;
    }
    
    setCedulaValidation({
      ...cedulaValidation,
      isChecking: true,
      message: 'Verificando cédula...'
    });

    try {
      const response = await axios.get(`https://api.hacienda.go.cr/fe/ae?identificacion=${cedula}`);
      
      if (response.data && response.status === 200) {
        setCedulaValidation({
          isValid: true,
          isChecking: false,
          wasChecked: true,
          message: 'Cédula verificada correctamente'
        });
      } else {
        setCedulaValidation({
          isValid: false,
          isChecking: false,
          wasChecked: true,
          message: 'La cédula no está registrada en Hacienda'
        });
      }
    } catch (error) {
      setCedulaValidation({
        isValid: false,
        isChecking: false,
        wasChecked: true,
        message: 'La cédula no está registrada o hubo un error de verificación'
      });
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (isEditing && !cedulaValidation.isValid) {
      toast.error("La cédula no es válida. Por favor, verifique e intente nuevamente.");
      return;
    }

    const userData = { 
      ...formData, 
      idUsuario: usuario.idUsuario 
    };

    console.log("Datos enviados al backend:", userData);

    try {
      await axios.put("http://localhost:8080/usuario/actualizarCredenciales", userData);
      toast.success("Tus datos se han actualizado correctamente");
      setIsEditing(false);
    } catch (error) {
      toast.error("Error al actualizar tus datos. Por favor intenta nuevamente.");
    }
  };  
  return (
    <div className="page-container">
      <NavbarApp />
   
      <div className="main-container ">
        <SideBarUsuario usuario={usuario} handleLogout={handleLogout} />

        {/* Contenido principal con nuevo diseño */}
        <div className="profile-content">
          <div className="profile-header">
            <h2>Mi Perfil</h2>
            <p>Administra y actualiza tu información personal</p>
          </div>

          <div className="profile-card">
            <div className="card-header">
              <h3>Información Personal</h3>
              {!isEditing ? (
                <button 
                  className="edit-btn"
                  onClick={() => setIsEditing(true)}
                >
                  Editar Perfil
                </button>
              ) : (
                <button 
                  className="cancel-btn"
                  onClick={() => {
                    setIsEditing(false);
                    if (usuario) {
                      setFormData({ ...usuario });
                      if (usuario.fechaNacimiento) {
                        const fecha = new Date(usuario.fechaNacimiento);
                        const formattedDate = fecha.toISOString().split('T')[0];
                        setFormData(prev => ({ ...prev, fechaNacimiento: formattedDate }));
                      }
                      if (usuario.cedulaUsuario) {
                        validarCedula(usuario.cedulaUsuario);
                      }
                    }
                  }}
                >
                  Cancelar
                </button>
              )}
            </div>

            <form onSubmit={handleSubmit} className="profile-form">
              <div className="form-grid">
                {/* Fila 1 */}
                <div className="form-group">
                  <label>
                    <FontAwesomeIcon icon={faIdCard} className="input-icon" /> Cédula
                  </label>
                  <input
                      type="text"
                      className={`form-input ${cedulaValidation.wasChecked ? (cedulaValidation.isValid ? 'valid' : 'invalid') : ''}`}
                      name="cedulaUsuario"
                      value={formData.cedulaUsuario}
                      onChange={handleChange}
                      required
                      disabled={!isEditing}
                      maxLength={9}
                      placeholder="Ej: 101110111"
                    />
                </div>

                <div className="form-group">
                  <label>
                    <FontAwesomeIcon  className="input-icon" /> Nombre
                  </label>
                  <input
                    type="text"
                    className="form-input"
                    name="nombreUsuario"
                    value={formData.nombreUsuario}
                    onChange={handleChange}
                    required
                    disabled={!isEditing}
                  />
                </div>

                {/* Fila 2 */}
                <div className="form-group">
                  <label>Primer Apellido</label>
                  <input
                    type="text"
                    className="form-input"
                    name="primerApellido"
                    value={formData.primerApellido}
                    onChange={handleChange}
                    disabled={!isEditing}
                  />
                </div>

                <div className="form-group">
                  <label>Segundo Apellido</label>
                  <input
                    type="text"
                    className="form-input"
                    name="segundoApellido"
                    value={formData.segundoApellido}
                    onChange={handleChange}
                    disabled={!isEditing}
                  />
                </div>

                {/* Fila 3 */}
                <div className="form-group">
                  <label>
                    <FontAwesomeIcon icon={faPhone} className="input-icon" /> Teléfono
                  </label>
                  <input
                    type="text"
                    className="form-input"
                    name="telefonoUsuario"
                    value={formData.telefonoUsuario}
                    onChange={handleChange}
                    disabled={!isEditing}
                  />
                </div>

          

                {/* Fila 4 */}
                <div className="form-group">
                  <label>
                    <FontAwesomeIcon icon={faCalendarAlt} className="input-icon" /> Fecha de Nacimiento
                  </label>
                  <input
                    type="date"
                    className="form-input"
                    name="fechaNacimiento"
                    value={formData.fechaNacimiento}
                    onChange={handleChange}
                    disabled={!isEditing}
                  />
                </div>
              </div>

              {isEditing && (
                <div className="form-actions">
                  <button type="submit" className="save-btn">
                    <FontAwesomeIcon icon={faSave} /> Guardar Cambios
                  </button>
                </div>
              )}
            </form>
          </div>
        </div>
        <Carrito />
        <ToastContainer position="bottom-right" autoClose={3000} />
      </div>
      <FooterApp />
    </div>
  );
};

export default PerfilUsuario;
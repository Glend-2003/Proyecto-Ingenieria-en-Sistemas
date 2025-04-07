import React, { useState, useEffect } from "react";
import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import { NavLink, useNavigate } from 'react-router-dom';
import axios from "axios";
import "bootstrap/dist/css/bootstrap.min.css";
import "./PerfilUsuario.css";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faSave, faLock, faEnvelope, faPhone, faIdCard, faCalendarAlt } from "@fortawesome/free-solid-svg-icons";
import useAuth from "../../hooks/useAuth";
import FooterApp from '../Footer/FooterApp';
import { FaFileAlt, FaDownload, FaMapMarkerAlt, FaUser, FaSignOutAlt, FaHome } from "react-icons/fa";
import NavbarApp from "../Navbar/NavbarApp";
import Carrito from "../Carrito/CarritoApp";

const PerfilUsuario = () => {
  const { usuario } = useAuth();
  const navigate = useNavigate();
  const [userEdit, setUserEdit] = useState(null);
  

  const [formData, setFormData] = useState({

    cedulaUsuario: "",
    nombreUsuario: "",
    primerApellido: "",
    segundoApellido: "",
    telefonoUsuario: "",
    fechaNacimiento: "",
   
  });

  const [isEditing, setIsEditing] = useState(false);

  useEffect(() => {
    if (usuario) {
      setFormData({ ...usuario });
    // Formatear la fecha para el input type="date"
      if (usuario.fechaNacimiento) {
        const fecha = new Date(usuario.fechaNacimiento);
        const formattedDate = fecha.toISOString().split('T')[0];
        setFormData(prev => ({ ...prev, fechaNacimiento: formattedDate }));
      }
    }
  }, [usuario]);

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

 const handleSubmit = async (e) => {
  e.preventDefault();

  
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


  const handleLogout = () => {
    localStorage.removeItem('token');
    localStorage.removeItem('correoUsuario');
    localStorage.removeItem('nombreUsuario');
    localStorage.removeItem('nombreUsuario');
    localStorage.removeItem('nombreRol');
    localStorage.removeItem('idUsuario');
    navigate('/');
  };

  

  return (
    <div className="profile-page">
      <NavbarApp />
      <Carrito />
      <div className="perfil-usuario-container">
        {/* Sidebar (sin cambios) */}
        <div className="sidebar-container">
          <h3 className="sidebar-title">Bienvenido {usuario?.nombreUsuario || "Usuario"}</h3>
          <nav className="sidebar-nav">
            <NavLink to="/dashboard" className="sidebar-link">
              <FaHome className="icon" /> Inicio
            </NavLink>
            <NavLink to="/orders" className="sidebar-link">
              <FaFileAlt className="icon" /> Pedidos
            </NavLink>
            <NavLink to="/downloads" className="sidebar-link">
              <FaDownload className="icon" /> Comprobantes
            </NavLink>
            <NavLink to="/DireccionUsuario" className="sidebar-link">
              <FaMapMarkerAlt className="icon" /> Dirección
            </NavLink>
            <NavLink to="/PerfilUsuario" className="sidebar-link">
              <FaUser className="icon" /> Detalles de la cuenta
            </NavLink>
            <NavLink to="/" className="sidebar-link logout" onClick={handleLogout}>
              <FaSignOutAlt className="icon" /> Cerrar sesión
            </NavLink>
          </nav>
        </div>

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
                    if (usuario) setFormData({ ...usuario });
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
                    className="form-input"
                    name="cedulaUsuario"
                    value={formData.cedulaUsuario}
                    onChange={handleChange}
                    required
                    disabled={!isEditing}
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

        <ToastContainer position="bottom-right" autoClose={3000} />
      </div>
      <FooterApp />
    </div>
  );
};

export default PerfilUsuario;
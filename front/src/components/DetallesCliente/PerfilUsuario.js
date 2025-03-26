import React, { useState, useEffect } from "react";
import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import { NavLink, useNavigate } from 'react-router-dom';
import axios from "axios";
import "bootstrap/dist/css/bootstrap.min.css";
import "./PerfilUsuario.css";
import Swal from "sweetalert2";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faEdit, faTrash, faExclamationTriangle } from "@fortawesome/free-solid-svg-icons";
import SideBarUsuario from "../DetallesCliente/SideBarUsuario";
import useAuth from "../../hooks/useAuth";
import FooterApp from '../Footer/FooterApp';
import { FaFileAlt, FaDownload, FaMapMarkerAlt, FaUser, FaSignOutAlt, FaHome } from "react-icons/fa";
import NavbarApp from "../Navbar/NavbarApp";
import Carrito from "../Carrito/CarritoApp";

const PerfilUsuario = () => {
  const { usuario } = useAuth();
  const navigate = useNavigate();

  const [formData, setFormData] = useState({
    cedulaUsuario: "",
    nombreUsuario: "",
    primerApellido: "",
    segundoApellido: "",
    telefonoUsuario: "",
    correoUsuario: "",
    contraseniaUsuario: "",
    fechaNacimiento: "",
    descripcionDireccion: "",
    codigoPostalDireccion: "",
    idDistrito: "",
    estadoUsuario: ""
  });

  useEffect(() => {
    if (usuario) {
      setFormData({ ...usuario });
    }
  }, [usuario]);

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await axios.post("/api/actualizarUsuario", formData);
      toast.success("Usuario actualizado con éxito");
    } catch (error) {
      toast.error("Error al actualizar usuario");
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
    <div >
      <NavbarApp/>
      <Carrito/>
      <div className="perfil-usuario-container">

        {/* Sidebar */}
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
            <NavLink to="/addresses" className="sidebar-link">
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
        <div className="container mt-4">
          <h2 className="text-center">Actualizar mi perfil</h2>
          <form>
            <div className="row">
              <div className="col-md-6">
                <label>Cédula</label>
                <input type="text" className="form-control" name="cedulaUsuario" value={formData.cedulaUsuario} onChange={handleChange} />
              </div>
              <div className="col-md-6">
                <label>Nombre</label>
                <input type="text" className="form-control" name="nombreUsuario" value={formData.nombreUsuario} onChange={handleChange} />
              </div>
            </div>

            <div className="row mt-3">
              <div className="col-md-6">
                <label>Primer Apellido</label>
                <input type="text" className="form-control" name="primerApellido" value={formData.primerApellido} onChange={handleChange} />
              </div>
              <div className="col-md-6">
                <label>Segundo Apellido</label>
                <input type="text" className="form-control" name="segundoApellido" value={formData.segundoApellido} onChange={handleChange} />
              </div>
            </div>

            <div className="row mt-3">
              <div className="col-md-6">
                <label>Teléfono</label>
                <input type="text" className="form-control" name="telefono" value={formData.telefono} onChange={handleChange} />
              </div>
              <div className="col-md-6">
                <label>Correo</label>
                <input type="email" className="form-control" name="correo" value={formData.correo} onChange={handleChange} />
              </div>
            </div>

            <div className="row mt-3">
              <div className="col-md-6">
                <label>Fecha de Nacimiento</label>
                <input type="date" className="form-control" name="fechaNacimiento" value={formData.fechaNacimiento} onChange={handleChange} />
              </div>
              <div className="col-md-6">
                <label>Código Postal</label>
                <input type="text" className="form-control" name="codigoPostal" value={formData.codigoPostal} onChange={handleChange} />
              </div>
            </div>

            <div className="row mt-3">
              <div className="col-md-12">
                <label>Descripción Dirección</label>
                <textarea className="form-control" name="descripcionDireccion" value={formData.descripcionDireccion} onChange={handleChange}></textarea>
              </div>
            </div>

            <div className="row mt-3">
              <div className="col-md-12">
                <label>ID Distrito</label>
                <input type="text" className="form-control" name="idDistrito" value={formData.idDistrito} onChange={handleChange} />
              </div>
            </div>

            <div className="update">
              <br></br><button type="submit" className="btn btn-primary">Actualizar</button>

            </div>
          </form>
        </div>


        <ToastContainer />
      </div>
      <FooterApp />
    </div>
  );
};

export default PerfilUsuario;

import React, { useState, useEffect } from "react";
import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import { NavLink, useNavigate } from "react-router-dom";
import axios from "axios";
import "bootstrap/dist/css/bootstrap.min.css";
import "./PerfilUsuario.css"; // Reutilizamos los estilos de PerfilUsuario
import SideBarUsuario from "../DetallesCliente/SideBarUsuario";
import useAuth from "../../hooks/useAuth";
import FooterApp from "../Footer/FooterApp";
import { FaFileAlt, FaDownload, FaMapMarkerAlt, FaUser, FaSignOutAlt, FaHome } from "react-icons/fa";

const DireccionUsuario = () => {
  const { usuario } = useAuth();
  const navigate = useNavigate();

  // Estados para los combos
  const [regiones, setRegiones] = useState([]);
  const [ciudades, setCiudades] = useState([]);
  const [distritos, setDistritos] = useState([]);

  // Estado para el formularios
  const [formData, setFormData] = useState({
    codigoPostal: "",
    descripcionDireccion: "",
    idRegion: "",
    idCiudad: "",
    idDistrito: "",
  });

  // Cargar regiones al montar el componente
  useEffect(() => {
    const fetchRegiones = async () => {
      try {
        const response = await axios.get("/api/regiones");
        setRegiones(response.data);
      } catch (error) {
        toast.error("Error al cargar las regiones");
      }
    };

    fetchRegiones();
  }, []);

  // Cargar ciudades cuando se selecciona una región
  useEffect(() => {
    const fetchCiudades = async () => {
      if (formData.idRegion) {
        try {
          const response = await axios.get(`/api/ciudades?regionId=${formData.idRegion}`);
          setCiudades(response.data);
        } catch (error) {
          toast.error("Error al cargar las ciudades");
        }
      }
    };

    fetchCiudades();
  }, [formData.idRegion]);

  // Cargar distritos cuando se selecciona una ciudad
  useEffect(() => {
    const fetchDistritos = async () => {
      if (formData.idCiudad) {
        try {
          const response = await axios.get(`/api/distritos?ciudadId=${formData.idCiudad}`);
          setDistritos(response.data);
        } catch (error) {
          toast.error("Error al cargar los distritos");
        }
      }
    };

    fetchDistritos();
  }, [formData.idCiudad]);

  // Manejar cambios en los inputs
  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  // Manejar envío del formulario
  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await axios.post("/api/actualizarDireccion", formData);
      toast.success("Dirección actualizada con éxito");
    } catch (error) {
      toast.error("Error al actualizar la dirección");
    }
  };

  // Manejar cierre de sesión
  const handleLogout = () => {
    localStorage.removeItem("token");
    localStorage.removeItem("correoUsuario");
    localStorage.removeItem("nombreUsuario");
    localStorage.removeItem("nombreRol");
    localStorage.removeItem("idUsuario");
    navigate("/");
  };

  return (
    <div>
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

        {/* Formulario de dirección */}
        <div className="container mt-4">
          <h2 className="text-center">Actualizar mi dirección</h2>
          <form onSubmit={handleSubmit}>
            {/* Código Postal */}
            <div className="row mt-3">
              <div className="col-md-6">
                <label>Código Postal (opcional)</label>
                <input
                  type="text"
                  className="form-control"
                  name="codigoPostal"
                  value={formData.codigoPostal}
                  onChange={handleChange}
                />
              </div>
            </div>

            {/* Descripción de la dirección */}
            <div className="row mt-3">
              <div className="col-md-12">
                <label>Descripción de la dirección (obligatoria)</label>
                <textarea
                  className="form-control"
                  name="descripcionDireccion"
                  value={formData.descripcionDireccion}
                  onChange={handleChange}
                  required
                />
              </div>
            </div>

            {/* Región/Provincia */}
            <div className="row mt-3">
              <div className="col-md-6">
                <label>Región/Provincia</label>
                <select
                  className="form-control"
                  name="idRegion"
                  value={formData.idRegion}
                  onChange={handleChange}
                  required
                >
                  <option value="">Seleccione una región</option>
                  {regiones.map((region) => (
                    <option key={region.id} value={region.id}>
                      {region.nombre}
                    </option>
                  ))}
                </select>
              </div>
            </div>

            {/* Ciudad/Cantón */}
            <div className="row mt-3">
              <div className="col-md-6">
                <label>Ciudad/Cantón</label>
                <select
                  className="form-control"
                  name="idCiudad"
                  value={formData.idCiudad}
                  onChange={handleChange}
                  required
                >
                  <option value="">Seleccione una ciudad</option>
                  {ciudades.map((ciudad) => (
                    <option key={ciudad.id} value={ciudad.id}>
                      {ciudad.nombre}
                    </option>
                  ))}
                </select>
              </div>
            </div>

            {/* Localidad/Distrito */}
            <div className="row mt-3">
              <div className="col-md-6">
                <label>Localidad/Distrito</label>
                <select
                  className="form-control"
                  name="idDistrito"
                  value={formData.idDistrito}
                  onChange={handleChange}
                  required
                >
                  <option value="">Seleccione un distrito</option>
                  {distritos.map((distrito) => (
                    <option key={distrito.id} value={distrito.id}>
                      {distrito.nombre}
                    </option>
                  ))}
                </select>
              </div>
            </div>

            {/* Botón de actualizar */}
            <div className="update mt-4">
              <button type="submit" className="btn btn-primary">
                Actualizar
              </button>
            </div>
          </form>
        </div>

        <ToastContainer />
      </div>
      <FooterApp />
    </div>
  );
};

export default DireccionUsuario;
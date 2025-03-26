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
  const [provincias, setProvincia] = useState([]);
  const [cantones, setCantones] = useState([]);
  const [distritos, setDistritos] = useState([]);
  const [idProvincia, setIdProvincia] = useState("");
  const [idCanton, setIdCanton] = useState("");

  // Estado para el formularios
  const [formData, setFormData] = useState({
    codigoPostal: "",
    descripcionDireccion: "",
    idProvincia: "",
    idCiudad: "",
    idDistrito: "",
  });

  useEffect(() => {
    cargarProvincias();
  }, []);

  useEffect(() => {
    if (idProvincia) {
      cargarCantones();
    }
  }, [idProvincia]); // Se ejecuta cuando idProvincia cambia


  const cargarProvincias = async () => {
    try {
      const response = await axios.get("http://localhost:8080/provincia/leer");
      console.log("Provincias recibidas del backend:", response.data);
      setProvincia(response.data); // Guarda directamente la lista de comentarios
    } catch (error) {
      console.error("Error al cargar las provincias:", error);
      toast.error("Ocurrió un error al cargar las provincias");
    }
  };

  const cargarCantones = async () => {
    try {
      const response = await axios.get(`http://localhost:8080/canton/leerPorProvincia/${idProvincia}`);
      console.log("Cantones recibidos del backend:", response.data);
      setCantones(response.data); // Guarda directamente la lista de comentarios
    } catch (error) {
      console.error("Error al cargar los cantones:", error);
      toast.error("Ocurrió un error al cargar los cantones");
    }
  };

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
                <label>Provincia</label>
                <select
                  className="form-control"
                  value={idProvincia}
                  onChange={(e) => setIdProvincia(e.target.value)}
                  required
                >
                  <option value="">Seleccione una provincia</option>
                  {provincias.map((provincia) => (
                    <option key={provincia.idProvincia} value={provincia.idProvincia}>
                      {provincia.nombreProvincia}
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
                  value={idProvincia}
                  onChange={(e) => {
                    setIdProvincia(e.target.value);
                    setCantones([]); // Limpia los cantones anteriores
                  }}
                  required
                >
                  <option value="">Seleccione una provincia</option>
                  {provincias.map((provincia) => (
                    <option key={provincia.idProvincia} value={provincia.idProvincia}>
                      {provincia.nombreProvincia}
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
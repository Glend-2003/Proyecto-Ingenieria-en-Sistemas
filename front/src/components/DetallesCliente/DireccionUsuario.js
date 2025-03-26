import React, { useState, useEffect } from "react";
import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import { NavLink, useNavigate } from "react-router-dom";
import axios from "axios";
import "bootstrap/dist/css/bootstrap.min.css";
import "./PerfilUsuario.css";
import SideBarUsuario from "../DetallesCliente/SideBarUsuario";
import FooterApp from "../Footer/FooterApp";
import { FaFileAlt, FaDownload, FaMapMarkerAlt, FaUser, FaSignOutAlt, FaHome } from "react-icons/fa";

const DireccionUsuario = () => {
  const navigate = useNavigate();
  const [userData, setUserData] = useState({
    idUsuario: null,
    nombreUsuario: '',
    correoUsuario: '',
    nombreRol: ''
  });

  // Estados para los combos
  const [provincias, setProvincia] = useState([]);
  const [cantones, setCantones] = useState([]);
  const [distritos, setDistritos] = useState([]);

  // Estado para el formulario
  const [formData, setFormData] = useState({
    codigoPostal: "",
    descripcionDireccion: "",
    idProvincia: "",
    idCanton: "",
    idDistrito: "",
  });

  // Obtener datos del usuario al cargar
  useEffect(() => {
    const storedUser = {
      idUsuario: localStorage.getItem('idUsuario'),
      nombreUsuario: localStorage.getItem('nombreUsuario'),
      correoUsuario: localStorage.getItem('correoUsuario'),
      nombreRol: localStorage.getItem('nombreRol')
    };
    
    if (!storedUser.idUsuario) {
      toast.error("Debe iniciar sesión primero");
      navigate("/login");
    } else {
      setUserData(storedUser);
      cargarProvincias();
    }
  }, [navigate]);

  // Cargar combos dependientes
  useEffect(() => {
    if (formData.idProvincia) {
      cargarCantones();
    } else {
      setCantones([]);
      setFormData(prev => ({ ...prev, idCanton: "", idDistrito: "" }));
    }
  }, [formData.idProvincia]);

  useEffect(() => {
    if (formData.idCanton) {
      cargarDistritos();
    } else {
      setDistritos([]);
      setFormData(prev => ({ ...prev, idDistrito: "" }));
    }
  }, [formData.idCanton]);

  const cargarProvincias = async () => {
    try {
      const response = await axios.get("http://localhost:8080/provincia/leer");
      setProvincia(response.data);
    } catch (error) {
      console.error("Error al cargar las provincias:", error);
      toast.error("Ocurrió un error al cargar las provincias");
    }
  };

  const cargarCantones = async () => {
    try {
      const response = await axios.get(
        `http://localhost:8080/canton/leerPorProvincia/${formData.idProvincia}`,
        {
          headers: {
            'Authorization': `Bearer ${localStorage.getItem('token')}`
          }
        }
      );
      setCantones(response.data);
    } catch (error) {
      console.error("Error al cargar los cantones:", error);
      toast.error("Ocurrió un error al cargar los cantones");
    }
  };

  const cargarDistritos = async () => {
    try {
      const response = await axios.get(
        `http://localhost:8080/distrito/leerPorCanton/${formData.idCanton}`,
        {
          headers: {
            'Authorization': `Bearer ${localStorage.getItem('token')}`
          }
        }
      );
      setDistritos(response.data);
    } catch (error) {
      console.error("Error al cargar los distritos:", error);
      toast.error("Ocurrió un error al cargar los distritos");
    }
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    if (!formData.descripcionDireccion || !formData.idDistrito) {
      toast.error("Descripción y distrito son obligatorios");
      return;
    }

    try {
      const response = await axios.post(
        "http://localhost:8080/direccion/guardar", 
        null, 
        {
          params: {
            idUsuario: userData.idUsuario,
            descripcion: formData.descripcionDireccion,
            codigoPostal: formData.codigoPostal || "",
            idDistrito: formData.idDistrito
          },
          headers: {
            'Authorization': `Bearer ${localStorage.getItem('token')}`
          }
        }
      );

      toast.success(response.data);
    } catch (error) {
      if (error.response?.status === 401) {
        handleLogout();
        toast.error("Sesión expirada, por favor ingrese nuevamente");
      } else {
        console.error("Error:", error.response?.data);
        toast.error(error.response?.data || "Error al guardar la dirección");
      }
    }
  };

  const handleLogout = () => {
    // Limpiar todos los datos de autenticación
    localStorage.removeItem('token');
    localStorage.removeItem('idUsuario');
    localStorage.removeItem('nombreUsuario');
    localStorage.removeItem('correoUsuario');
    localStorage.removeItem('nombreRol');
    localStorage.removeItem('isAuthenticated');
    
    navigate('/login');
    toast.success("Sesión cerrada correctamente");
  };

  return (
    <div>
      <div className="perfil-usuario-container">
        {/* Sidebar */}
        <div className="sidebar-container">
          <h3 className="sidebar-title">Bienvenido {userData.nombreUsuario || "Usuario"}</h3>
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
            <NavLink to="/addresses" className="sidebar-link active">
              <FaMapMarkerAlt className="icon" /> Dirección
            </NavLink>
            <NavLink to="/perfil" className="sidebar-link">
              <FaUser className="icon" /> Mi perfil
            </NavLink>
            <button onClick={handleLogout} className="sidebar-link logout">
              <FaSignOutAlt className="icon" /> Cerrar sesión
            </button>
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
                  placeholder="Ej: 10101"
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
                  placeholder="Ej: Casa color azul, 100m norte del parque central"
                  rows={3}
                />
              </div>
            </div>

            {/* Región/Provincia */}
            <div className="row mt-3">
              <div className="col-md-6">
                <label>Provincia</label>
                <select
                  className="form-control"
                  name="idProvincia"
                  value={formData.idProvincia}
                  onChange={(e) => {
                    setFormData({
                      ...formData,
                      idProvincia: e.target.value,
                      idCanton: "",
                      idDistrito: ""
                    });
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

            {/* Ciudad/Cantón */}
            <div className="row mt-3">
              <div className="col-md-6">
                <label>Ciudad/Cantón</label>
                <select
                  className="form-control"
                  name="idCanton"
                  value={formData.idCanton}
                  onChange={(e) => {
                    setFormData({
                      ...formData,
                      idCanton: e.target.value,
                      idDistrito: ""
                    });
                  }}
                  required
                  disabled={!formData.idProvincia}
                >
                  <option value="">Seleccione un cantón</option>
                  {cantones.map((canton) => (
                    <option key={canton.idCanton} value={canton.idCanton}>
                      {canton.nombreCanton}
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
                  disabled={!formData.idCanton}
                >
                  <option value="">Seleccione un distrito</option>
                  {distritos.map((distrito) => (
                    <option key={distrito.idDistrito} value={distrito.idDistrito}>
                      {distrito.nombreDistrito}
                    </option>
                  ))}
                </select>
              </div>
            </div>

            {/* Botón de actualizar */}
            <div className="update mt-4">
              <button 
                type="submit" 
                className="btn btn-primary"
                disabled={!formData.descripcionDireccion || !formData.idDistrito}
              >
                Actualizar dirección
              </button>
            </div>
          </form>
        </div>

        <ToastContainer 
          position="bottom-right"
          autoClose={3000}
          hideProgressBar={false}
          newestOnTop={false}
          closeOnClick
          rtl={false}
          pauseOnFocusLoss
          draggable
          pauseOnHover
        />
      </div>
      <FooterApp />
    </div>
  );
};

export default DireccionUsuario;
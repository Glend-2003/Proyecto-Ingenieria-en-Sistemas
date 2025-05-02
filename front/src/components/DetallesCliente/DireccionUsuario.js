import React, { useState, useEffect } from "react";
import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import { NavLink, useNavigate } from "react-router-dom";
import axios from "axios";
import "bootstrap/dist/css/bootstrap.min.css";
import "./DireccionUsuario.css";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faSave, faMapMarkerAlt } from "@fortawesome/free-solid-svg-icons";
import FooterApp from "../Footer/FooterApp";
import { FaFileAlt, FaDownload, FaUser, FaSignOutAlt, FaHome, FaMapMarkerAlt } from "react-icons/fa";
import NavbarApp from "../Navbar/NavbarApp";
import Carrito from "../Carrito/CarritoApp";
import useAuth from "../../hooks/useAuth";
import SideBarUsuario from '../DetallesCliente/SideBarUsuario';
import { useAppContext } from "../Navbar/AppContext";

const DireccionUsuario = () => {
  const { usuario } = useAuth();
  const navigate = useNavigate();

  // Estados para los combos
  const [provincias, setProvincia] = useState([]);
  const [cantones, setCantones] = useState([]);
  const [distritos, setDistritos] = useState([]);
  const [isValidatingPostalCode, setIsValidatingPostalCode] = useState(false);
  

  // Estado para el formulario
  const [formData, setFormData] = useState({
    codigoPostalDireccion: "",
    descripcionDireccion: "",
    idProvincia: "",
    idCanton: "",
    idDistrito: "",
  });
   const {handleLogout
        } = useAppContext();

  const [isEditing, setIsEditing] = useState(false);

  const isValidPostalCodeFormat = (code) => {
    return /^\d{5}$/.test(code);
  };

  const validatePostalCodeWithAPI = async (postalCode, country = "CR") => {
    try {
      setIsValidatingPostalCode(true);
      
      const username = "CarniceriaLaBendi"; 
      const response = await fetch(
        `https://secure.geonames.org/postalCodeLookupJSON?postalcode=${postalCode}&country=${country}&username=${username}`
      );
      
      const data = await response.json();
      return data.postalcodes && data.postalcodes.length > 0;
      
    } catch (error) {
      console.error("Error validando código postal:", error);
      toast.warning("No se pudo verificar el código postal. Se aceptará pero no está validado.");
      return true; 
    } finally {
      setIsValidatingPostalCode(false);
    }
  };

  // Validación específica para Costa Rica
  const validateCostaRicaPostalCode = async (postalCode) => {
    // Primero validamos el formato
    if (!isValidPostalCodeFormat(postalCode)) {
      toast.error("El código postal debe tener exactamente 5 dígitos");
      return false;
    }

    return await validatePostalCodeWithAPI(postalCode);
  };

  useEffect(() => {
    if (usuario) {
      setFormData({
        codigoPostalDireccion: usuario.codigoPostalDireccion || "",
        descripcionDireccion: usuario.descripcionDireccion || "",
        idDistrito: usuario.idDistrito || ""
      });
      cargarProvincias();
    }
  }, [usuario]);

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

  const handleBlurPostalCode = async () => {
    if (formData.codigoPostalDireccion && formData.codigoPostalDireccion.length === 5) {
      const isValid = await validateCostaRicaPostalCode(formData.codigoPostalDireccion);
      if (!isValid) {
        toast.info("Si el código es correcto pero no se valida, puedes continuar igual");
      }
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    if (!formData.descripcionDireccion || !formData.idDistrito) {
      toast.error("Descripción y distrito son obligatorios");
      return;
    }

    // Validación de formato pero no bloqueamos si la API falla
    if (formData.codigoPostalDireccion && !isValidPostalCodeFormat(formData.codigoPostalDireccion)) {
      toast.error("El código postal debe tener 5 dígitos");
      return;
    }

    try {
      const response = await axios.post(
        "http://localhost:8080/direccion/guardar", 
        null, 
        {
          params: {
            idUsuario: usuario.idUsuario,
            descripcion: formData.descripcionDireccion,
            codigoPostal: formData.codigoPostalDireccion || "",
            idDistrito: formData.idDistrito
          },
          headers: {
            'Authorization': `Bearer ${localStorage.getItem('token')}`
          }
        }
      );

      toast.success(response.data);
      setIsEditing(false);
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


  return (
    
    <div className="profile-page">
      <NavbarApp />
      <Carrito />
      <div className="perfil-usuario-container">
        {/* Sidebar Component */}
        <SideBarUsuario usuario={usuario} handleLogout={handleLogout} />

        {/* Contenido principal con nuevo diseño */}
        <div className="profile-content">
          <div className="profile-header">
            <h2>Mi Dirección</h2>
            <p>Administra y actualiza tu información de dirección</p>
          </div>

          <div className="profile-card">
            <div className="card-header">
              <h3>Información de Dirección</h3>
              {!isEditing ? (
                <button 
                  className="edit-btn"
                  onClick={() => setIsEditing(true)}
                >
                  Editar Dirección
                </button>
              ) : (
                <button 
                  className="cancel-btn"
                  onClick={() => {
                    setIsEditing(false);
                    if (usuario) {
                      setFormData({
                        codigoPostalDireccion: usuario.codigoPostalDireccion || "",
                        descripcionDireccion: usuario.descripcionDireccion || "",
                        idDistrito: usuario.idDistrito || ""
                      });
                    }
                  }}
                >
                  Cancelar
                </button>
              )}
            </div>

            <form onSubmit={handleSubmit} className="profile-form">
              <div className="form-grid">
                {/* Código Postal */}
                <div className="form-group">
                  <label>
                    <FontAwesomeIcon icon={faMapMarkerAlt} className="input-icon" /> Código Postal
                  </label>
                  <input
                    type="text"
                    className="form-input"
                    name="codigoPostalDireccion"
                    value={formData.codigoPostalDireccion}
                    onChange={handleChange}
                    onBlur={handleBlurPostalCode}
                    placeholder="Ej: 10101 (opcional)"
                    disabled={!isEditing}
                    maxLength="5"
                  />
                  {isValidatingPostalCode && (
                    <small className="text-muted">Validando código postal...</small>
                  )}
                  <small className="text-muted">Ejemplos válidos: 10101 (San José), 20101 (Alajuela)</small>
                </div>

                {/* Descripción */}
                <div className="form-group full-width">
                  <label>Descripción de la dirección</label>
                  <textarea
                    className="form-input"
                    name="descripcionDireccion"
                    value={formData.descripcionDireccion}
                    onChange={handleChange}
                    required
                    placeholder="Ej: Casa color azul, 100m norte del parque central"
                    rows={3}
                    disabled={!isEditing}
                  />
                </div>

                {/* Provincia */}
                <div className="form-group">
                  <label>Provincia</label>
                  <select
                    className="form-input"
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
                    disabled={!isEditing}
                  >
                    <option value="">Seleccione una provincia</option>
                    {provincias.map((provincia) => (
                      <option key={provincia.idProvincia} value={provincia.idProvincia}>
                        {provincia.nombreProvincia}
                      </option>
                    ))}
                  </select>
                </div>

                {/* Cantón */}
                <div className="form-group">
                  <label>Cantón</label>
                  <select
                    className="form-input"
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
                    disabled={!formData.idProvincia || !isEditing}
                  >
                    <option value="">Seleccione un cantón</option>
                    {cantones.map((canton) => (
                      <option key={canton.idCanton} value={canton.idCanton}>
                        {canton.nombreCanton}
                      </option>
                    ))}
                  </select>
                </div>

                {/* Distrito */}
                <div className="form-group">
                  <label>Distrito</label>
                  <select
                    className="form-input"
                    name="idDistrito"
                    value={formData.idDistrito}
                    onChange={handleChange}
                    required
                    disabled={!formData.idCanton || !isEditing}
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

              {isEditing && (
                <div className="form-actions">
                  <button 
                    type="submit" 
                    className="save-btn"
                    disabled={isValidatingPostalCode}
                  >
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

export default DireccionUsuario;
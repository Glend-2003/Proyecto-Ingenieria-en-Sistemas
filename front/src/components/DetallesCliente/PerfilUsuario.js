import React, { useState, useEffect } from "react";
import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import { useNavigate } from 'react-router-dom';
import axios from "axios";
import "bootstrap/dist/css/bootstrap.min.css";
import "./PerfilUsuario.css";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faSave, faPhone, faIdCard, faCalendarAlt, faExclamationCircle, faCheckCircle } from "@fortawesome/free-solid-svg-icons";
import useAuth from "../../hooks/useAuth";
import FooterApp from '../Footer/FooterApp';
import NavbarApp from "../Navbar/NavbarApp";
import Carrito from "../Carrito/CarritoApp";
import SideBarUsuario from '../DetallesCliente/SideBarUsuario';
import { useAppContext } from "../Navbar/AppContext";

const PerfilUsuario = () => {
  const { usuario } = useAuth();
  const navigate = useNavigate();
  const [validatingCedula, setValidatingCedula] = useState(false);
  const [cedulaValida, setCedulaValida] = useState(true);
  const [nombreApellidosValidos, setNombreApellidosValidos] = useState({
    nombreUsuario: true,
    primerApellido: true,
    segundoApellido: true
  });
// Validar teléfono (8 dígitos)
  const validarTelefono = (telefono) => {
    // Eliminar guiones para la validación
    const telefonoLimpio = telefono.replace(/-/g, "");
    
    if (telefonoLimpio.length !== 8 || !/^\d+$/.test(telefonoLimpio)) {
      setFormErrors(prev => ({ ...prev, telefonoUsuario: "El teléfono debe tener 8 dígitos" }));
      return false;
    } else {
      setFormErrors(prev => ({ ...prev, telefonoUsuario: "" }));
      return true;
    }
  };
  const [formData, setFormData] = useState({
    cedulaUsuario: "",
    nombreUsuario: "",
    primerApellido: "",
    segundoApellido: "",
    telefonoUsuario: "",
    fechaNacimiento: "",
  });

  const [formErrors, setFormErrors] = useState({
    cedulaUsuario: "",
    nombreUsuario: "",
    primerApellido: "",
    segundoApellido: "",
    telefonoUsuario: "",
    fechaNacimiento: "",
  });

  const { handleLogout } = useAppContext();
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

  // Validación de cédula con la API de Hacienda
  const validarCedula = async (cedula) => {
    if (!cedula || cedula.trim() === "") {
      setFormErrors(prev => ({ ...prev, cedulaUsuario: "La cédula es obligatoria" }));
      setCedulaValida(false);
      return false;
    }

    try {
      setValidatingCedula(true);
      const response = await axios.get(`https://api.hacienda.go.cr/fe/ae?identificacion=${cedula}`);
      
      if (response.data && response.data.nombre) {
        setCedulaValida(true);
        setFormErrors(prev => ({ ...prev, cedulaUsuario: "" }));
        return true;
      } else {
        setCedulaValida(false);
        setFormErrors(prev => ({ ...prev, cedulaUsuario: "Cédula no válida según el Ministerio de Hacienda" }));
        return false;
      }
    } catch (error) {
      setCedulaValida(false);
      setFormErrors(prev => ({ ...prev, cedulaUsuario: "No se pudo validar la cédula. Verifique que sea correcta." }));
      return false;
    } finally {
      setValidatingCedula(false);
    }
  };

  // Validación de solo letras para nombre y apellidos
  const validarSoloLetras = (texto, campo) => {
    const regex = /^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]+$/;
    const esValido = regex.test(texto);
    
    setNombreApellidosValidos(prev => ({ ...prev, [campo]: esValido }));
    
    if (!esValido) {
      setFormErrors(prev => ({ ...prev, [campo]: "Solo se permiten letras" }));
      return false;
    } else {
      setFormErrors(prev => ({ ...prev, [campo]: "" }));
      return true;
    }
  };

  // Formatear teléfono con el formato 9999-9999
  const formatearTelefono = (telefono) => {
    // Eliminar cualquier caracter que no sea un dígito
    const telefonoLimpio = telefono.replace(/\D/g, "");
    
    // Limitar a 8 dígitos
    const telefonoLimitado = telefonoLimpio.substring(0, 8);
    
    // Aplicar formato XXXX-XXXX si hay al menos 5 dígitos
    if (telefonoLimitado.length >= 5) {
      return `${telefonoLimitado.substring(0, 4)}-${telefonoLimitado.substring(4)}`;
    } else if (telefonoLimitado.length > 0) {
      return telefonoLimitado;
    }
    
    return "";
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    
    // Aplicar formato especial para el teléfono
    if (name === "telefonoUsuario") {
      setFormData({ ...formData, [name]: formatearTelefono(value) });
    } else {
      setFormData({ ...formData, [name]: value });
    }

    // Validaciones en tiempo real
    if (name === "nombreUsuario" || name === "primerApellido" || name === "segundoApellido") {
      validarSoloLetras(value, name);
    }
    
    if (name === "telefonoUsuario") {
      validarTelefono(formatearTelefono(value));
    }
  };

  const validarFormulario = async () => {
    let formValido = true;
    let nuevoFormErrors = { ...formErrors };

    // Validar cédula
    if (isEditing) {
      const cedulaValida = await validarCedula(formData.cedulaUsuario);
      if (!cedulaValida) formValido = false;
    }

    // Validar nombre y apellidos
    if (!validarSoloLetras(formData.nombreUsuario, "nombreUsuario")) formValido = false;
    if (!validarSoloLetras(formData.primerApellido, "primerApellido")) formValido = false;
    if (formData.segundoApellido && !validarSoloLetras(formData.segundoApellido, "segundoApellido")) formValido = false;

    // Validar teléfono
    if (!validarTelefono(formData.telefonoUsuario)) formValido = false;

    // Validar fecha de nacimiento
    if (!formData.fechaNacimiento) {
      nuevoFormErrors.fechaNacimiento = "La fecha de nacimiento es obligatoria";
      formValido = false;
    } else {
      nuevoFormErrors.fechaNacimiento = "";
    }

    setFormErrors(nuevoFormErrors);
    return formValido;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    const esValido = await validarFormulario();
    if (!esValido) {
      toast.error("Por favor corrige los errores en el formulario");
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
    <div className="profile-page">
      <NavbarApp />

      <div className="perfil-usuario-container">
        <SideBarUsuario usuario={usuario} handleLogout={handleLogout} />

        {/* Contenido principal con nuevo diseño */}
        <div className="profile-content">
          <div className="profile-header">
            <h2>Mi Perfil</h2>
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
                    // Resetear errores
                    setFormErrors({
                      cedulaUsuario: "",
                      nombreUsuario: "",
                      primerApellido: "",
                      segundoApellido: "",
                      telefonoUsuario: "",
                      fechaNacimiento: "",
                    });
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
                  <div className="input-with-validation">
                    <input
                      type="text"
                      className={`form-input ${formErrors.cedulaUsuario ? 'is-invalid' : ''}`}
                      name="cedulaUsuario"
                      value={formData.cedulaUsuario}
                      onChange={handleChange}
                      onBlur={() => isEditing && validarCedula(formData.cedulaUsuario)}
                      required
                      disabled={!isEditing}
                    />
                    {isEditing && validatingCedula && (
                      <div className="validation-icon loading">Validando...</div>
                    )}
                    {isEditing && !validatingCedula && formData.cedulaUsuario && (
                      <div className={`validation-icon ${cedulaValida ? 'valid' : 'invalid'}`}>
                        <FontAwesomeIcon icon={cedulaValida ? faCheckCircle : faExclamationCircle} />
                      </div>
                    )}
                  </div>
                  {formErrors.cedulaUsuario && (
                    <div className="error-message">{formErrors.cedulaUsuario}</div>
                  )}
                </div>

                <div className="form-group">
                  <label>
                    <FontAwesomeIcon className="input-icon" /> Nombre
                  </label>
                  <div className="input-with-validation">
                    <input
                      type="text"
                      className={`form-input ${formErrors.nombreUsuario ? 'is-invalid' : ''}`}
                      name="nombreUsuario"
                      value={formData.nombreUsuario}
                      onChange={handleChange}
                      required
                      disabled={!isEditing}
                    />
                    {isEditing && formData.nombreUsuario && (
                      <div className={`validation-icon ${nombreApellidosValidos.nombreUsuario ? 'valid' : 'invalid'}`}>
                        <FontAwesomeIcon icon={nombreApellidosValidos.nombreUsuario ? faCheckCircle : faExclamationCircle} />
                      </div>
                    )}
                  </div>
                  {formErrors.nombreUsuario && (
                    <div className="error-message">{formErrors.nombreUsuario}</div>
                  )}
                </div>

                {/* Fila 2 */}
                <div className="form-group">
                  <label>Primer Apellido</label>
                  <div className="input-with-validation">
                    <input
                      type="text"
                      className={`form-input ${formErrors.primerApellido ? 'is-invalid' : ''}`}
                      name="primerApellido"
                      value={formData.primerApellido}
                      onChange={handleChange}
                      required
                      disabled={!isEditing}
                    />
                    {isEditing && formData.primerApellido && (
                      <div className={`validation-icon ${nombreApellidosValidos.primerApellido ? 'valid' : 'invalid'}`}>
                        <FontAwesomeIcon icon={nombreApellidosValidos.primerApellido ? faCheckCircle : faExclamationCircle} />
                      </div>
                    )}
                  </div>
                  {formErrors.primerApellido && (
                    <div className="error-message">{formErrors.primerApellido}</div>
                  )}
                </div>

                <div className="form-group">
                  <label>Segundo Apellido</label>
                  <div className="input-with-validation">
                    <input
                      type="text"
                      className={`form-input ${formErrors.segundoApellido ? 'is-invalid' : ''}`}
                      name="segundoApellido"
                      value={formData.segundoApellido}
                      onChange={handleChange}
                      disabled={!isEditing}
                    />
                    {isEditing && formData.segundoApellido && (
                      <div className={`validation-icon ${nombreApellidosValidos.segundoApellido ? 'valid' : 'invalid'}`}>
                        <FontAwesomeIcon icon={nombreApellidosValidos.segundoApellido ? faCheckCircle : faExclamationCircle} />
                      </div>
                    )}
                  </div>
                  {formErrors.segundoApellido && (
                    <div className="error-message">{formErrors.segundoApellido}</div>
                  )}
                </div>

                {/* Fila 3 */}
                <div className="form-group">
                  <label>
                    <FontAwesomeIcon icon={faPhone} className="input-icon" /> Teléfono
                  </label>
                  <input
                    type="text"
                    className={`form-input ${formErrors.telefonoUsuario ? 'is-invalid' : ''}`}
                    name="telefonoUsuario"
                    value={formData.telefonoUsuario}
                    onChange={handleChange}
                    onBlur={() => validarTelefono(formData.telefonoUsuario)}
                    placeholder="9999-9999"
                    maxLength="9"
                    disabled={!isEditing}
                  />
                  {formErrors.telefonoUsuario && (
                    <div className="error-message">{formErrors.telefonoUsuario}</div>
                  )}
                </div>

                {/* Fila 4 */}
                <div className="form-group">
                  <label>
                    <FontAwesomeIcon icon={faCalendarAlt} className="input-icon" /> Fecha de Nacimiento
                  </label>
                  <input
                    type="date"
                    className={`form-input ${formErrors.fechaNacimiento ? 'is-invalid' : ''}`}
                    name="fechaNacimiento"
                    value={formData.fechaNacimiento}
                    onChange={handleChange}
                    disabled={!isEditing}
                  />
                  {formErrors.fechaNacimiento && (
                    <div className="error-message">{formErrors.fechaNacimiento}</div>
                  )}
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
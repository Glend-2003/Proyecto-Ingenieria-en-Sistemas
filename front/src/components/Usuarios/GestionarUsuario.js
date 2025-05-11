import React, { useState, useEffect } from "react";
import axios from "axios";
import "bootstrap/dist/css/bootstrap.min.css";
import { FaKey, FaTrash, FaEdit, FaEye, FaEyeSlash } from "react-icons/fa";
import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import Swal from "sweetalert2";
import useAuth from "../../hooks/useAuth";
import SideBar from "../SideBar/SideBar";
import { Button, Modal } from "react-bootstrap";
import "./Usuarios.css";
import FooterApp from "../Footer/FooterApp";
import PaginacionApp from "../Paginacion/PaginacionApp";

const GestionarUsuario = () => {
  const [users, setUsers] = useState([]);
  const [search, setSearch] = useState("");
  const [userEdit, setUserEdit] = useState(null);
  const [showModal, setShowModal] = useState(false);
  const [showPasswordModal, setShowPasswordModal] = useState(false);
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [passwordStrength, setPasswordStrength] = useState(0);
  const [passwordVisible, setPasswordVisible] = useState(false);
  const [confirmPasswordVisible, setConfirmPasswordVisible] = useState(false);
  const [modalTitle, setModalTitle] = useState("Agregar Usuario");
  const { usuario } = useAuth();
  const [roles, setRoles] = useState([]);
  const [currentPage, setCurrentPage] = useState(1);
  const [selectedRole, setSelectedRole] = useState("Todos");
  const itemsPerPage = 5;

  useEffect(() => {
    cargarUsuarios();
    cargarRoles();
  }, []);

  // Evaluar la fortaleza de la contraseña
  useEffect(() => {
    if (!password) {
      setPasswordStrength(0);
      return;
    }
    
    // Inicializar fortaleza
    let strength = 0;
    
    // Verificar longitud mínima (8 caracteres)
    const hasMinLength = password.length >= 8;
    
    // Verificar si contiene letras
    const hasLetters = /[a-zA-Z]/.test(password);
    
    // Verificar si contiene números
    const hasNumbers = /[0-9]/.test(password);
    
    // Verificar si contiene caracteres especiales
    const hasSpecialChars = /[^A-Za-z0-9]/.test(password);
    
    // Si tiene menos de 8 caracteres o solo letras o solo números, es débil (33%)
    if (!hasMinLength || (!hasLetters && hasNumbers) || (hasLetters && !hasNumbers)) {
      strength = 33;
    } 
    // Si tiene letras Y números con longitud adecuada, es buena (66%)
    else if (hasLetters && hasNumbers && !hasSpecialChars) {
      strength = 66;
    } 
    // Si tiene letras, números Y caracteres especiales, es excelente (100%)
    else if (hasLetters && hasNumbers && hasSpecialChars) {
      strength = 100;
    }
    
    setPasswordStrength(strength);
  }, [password]);

  const cargarUsuarios = async () => {
    try {
      const response = await axios.get("http://localhost:8080/usuario/");
      setUsers(response.data);
    } catch (error) {
      console.error("Error al cargar los usuarios:", error);
      toast.error("Ocurrió un error al cargar los usuarios");
    }
  };

  const cargarRoles = async () => {
    try {
      const response = await axios.get("http://localhost:8080/rol/");
      setRoles(response.data);
    } catch (error) {
      console.error("Error al cargar los roles:", error);
      toast.error("Ocurrió un error al cargar los roles");
    }
  };

  const handleOpenModal = (user = null) => {
    if (user) {
      // Modo edición
      setUserEdit({
        ...user,
        idRol: user.rol.idRol
      });
      setModalTitle("Actualizar Usuario");
    } else {
      // Modo agregar
      setUserEdit({
        correoUsuario: "",
        nombreUsuario: "",
        primerApellido: "",
        segundoApellido: "",
        idRol: "",
      });
      setPassword("");
      setConfirmPassword("");
      setModalTitle("Agregar Usuario");
    }
    setShowModal(true);
  };

  // Funciones para cerrar modales
  const handleCloseModal = () => {
    setShowModal(false);
    setUserEdit(null);
    setPassword("");
    setConfirmPassword("");
    setPasswordVisible(false);
    setConfirmPasswordVisible(false);
  };

  const handleClosePasswordModal = () => {
    setShowPasswordModal(false);
    setPassword("");
    setConfirmPassword("");
    setPasswordVisible(false);
    setConfirmPasswordVisible(false);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    // Validar que se haya seleccionado un rol
    if (!userEdit.idRol) {
      toast.error("Debe seleccionar un rol para el usuario");
      return;
    }

    // Validar contraseñas para usuarios nuevos
    if (!userEdit.idUsuario) {
      if (password !== confirmPassword) {
        toast.error("Las contraseñas no coinciden");
        return;
      }
      
      // No permitir contraseñas débiles
      if (passwordStrength < 60) {
        toast.error(" La contraseña es demasiado débil. Debe tener al menos 8 caracteres e incluir letras y números.");
        return;
      }
    }

    const userData = {
      ...userEdit,
      contraseniaUsuario: userEdit.idUsuario ? undefined : password,
      rol: {
        idRol: userEdit.idRol
      },
    };

    try {
      if (userEdit.idUsuario) {
        await axios.put("http://localhost:8080/usuario/actualizar", userData);
        toast.success("Usuario actualizado con éxito");
      } else {
        await axios.post("http://localhost:8080/usuario/registrar", userData);
        toast.success("Usuario agregado con éxito");
      }
      cargarUsuarios();
      handleCloseModal();
    } catch (error) {
      console.error("Error al procesar el usuario:", error);
      toast.error("Ocurrió un error al procesar el usuario");
    }
  };

  const handleDelete = async (idUsuario) => {
    const { isConfirmed } = await Swal.fire({
      title: "¿Estás seguro?",
      text: "No podrás revertir esto.",
      icon: "warning",
      showCancelButton: true,
      confirmButtonText: "Sí, eliminar",
      cancelButtonText: "No, cancelar",
      reverseButtons: true,
    });

    if (!isConfirmed) return;

    try {
      await axios.delete(`http://localhost:8080/usuario/eliminar/${idUsuario}`);
      toast.success("Usuario eliminado con éxito");
      cargarUsuarios();
    } catch (error) {
      console.error("Error al eliminar usuario:", error);
      toast.error("Ocurrió un error al eliminar el usuario");
    }
  };

  const activarDesactivarUsuario = async (id) => {
    try {
      await axios.put(`http://localhost:8080/usuario/activar/${id}`);
      toast.success("Cambio realizado con éxito.");
      cargarUsuarios();
    } catch (error) {
      console.error("Error al realizar el cambio:", error);
      toast.error("Ocurrió un error al cambiar el estado del usuario.");
    }
  };

  const handlePasswordUpdate = async (e) => {
    e.preventDefault();
    
    if (password !== confirmPassword) {
      toast.error("Las contraseñas no coinciden");
      return;
    }
    
    // No permitir contraseñas débiles
    if (passwordStrength < 60) {
      toast.error("La contraseña es demasiado débil. Debe tener al menos 6 caracteres e incluir letras y números.");
      return;
    }

    try {
      await axios.put("http://localhost:8080/usuario/actualizarContrasena", {
        idUsuario: userEdit.idUsuario,
        contraseniaUsuario: password,
      });
      toast.success("Contraseña actualizada con éxito");
      handleClosePasswordModal();
    } catch (error) {
      console.error("Error al actualizar la contraseña:", error);
      toast.error("Ocurrió un error al actualizar la contraseña");
    }
  };

  const handleOpenPasswordModal = (user) => {
    setUserEdit(user);
    setShowPasswordModal(true);
    setPassword("");
    setConfirmPassword("");
  };

  const handleSearchChange = (e) => setSearch(e.target.value);

  // Filtrar usuarios por nombre o correo
  const filteredUsers = users.filter((user) =>
    user.nombreUsuario.toLowerCase().includes(search.toLowerCase()) ||
    user.correoUsuario.toLowerCase().includes(search.toLowerCase())
  );

  // Obtener roles únicos para el select
  const uniqueRoles = ["Todos", ...new Set(roles.map((rol) => rol.nombreRol))];

  // Filtrar los datos según el rol seleccionado
  const filteredData =
    selectedRole === "Todos"
      ? filteredUsers
      : filteredUsers.filter((user) => user.rol.nombreRol === selectedRole);

  // Calcular el número total de páginas basado en los datos filtrados
  const totalPages = Math.ceil(filteredData.length / itemsPerPage);

  // Obtener los usuarios para la página actual
  const currentUsers = filteredData.slice(
    (currentPage - 1) * itemsPerPage,
    currentPage * itemsPerPage
  );

  const getPasswordStrengthColor = () => {
    if (passwordStrength < 60) return 'bg-danger';
    if (passwordStrength < 100) return 'bg-warning';
    return 'bg-success';
  };

  return (
    <div className="content-container">
      <SideBar usuario={usuario} />
      <div className="container mt-5">
        <h1>Gestión de usuarios</h1>
        <Button className="custom-button" onClick={() => handleOpenModal()}>
          Agregar usuario nuevo
        </Button>
        <div className="mb-2"></div>
        <label>Filtrar usuario por rol</label>
        <select
          value={selectedRole}
          onChange={(e) => setSelectedRole(e.target.value)}
          className="form-control"
        >
          {uniqueRoles.map((rol) => (
            <option key={rol} value={rol}>
              {rol}
            </option>
          ))}
        </select>
        <br></br>
        <label>Buscar usuario</label>
        <input
          type="text"
          className="form-control"
          placeholder="Buscar usuario por nombre o correo"
          value={search}
          onChange={handleSearchChange}
        />

        {/* Modal para agregar/editar usuario */}
        <Modal show={showModal} onHide={handleCloseModal}>
          <Modal.Header closeButton>
            <Modal.Title>{modalTitle}</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <form onSubmit={handleSubmit}>
              <div className="mb-3">
                <label>Correo Electrónico</label>
                <input
                  className="form-control"
                  type="email"
                  placeholder="Correo Electrónico"
                  required
                  value={userEdit?.correoUsuario || ""}
                  onChange={(e) => setUserEdit({ ...userEdit, correoUsuario: e.target.value })}
                />
              </div>
              <div className="row mb-3">
                <div className="col-sm-6">
                  <label>Nombre</label>
                  <input
                    className="form-control"
                    type="text"
                    placeholder="Nombre"
                    required
                    value={userEdit?.nombreUsuario || ""}
                    onChange={(e) => setUserEdit({ ...userEdit, nombreUsuario: e.target.value })}
                  />
                </div>
                <div className="col-sm-6">
                  <label>Primer Apellido</label>
                  <input
                    className="form-control"
                    type="text"
                    placeholder="Primer Apellido"
                    required
                    value={userEdit?.primerApellido || ""}
                    onChange={(e) => setUserEdit({ ...userEdit, primerApellido: e.target.value })}
                  />
                </div>
              </div>
              <div className="row mb-3">
                <div className="col-sm-6">
                  <label>Segundo Apellido</label>
                  <input
                    className="form-control"
                    type="text"
                    placeholder="Segundo Apellido"
                    required
                    value={userEdit?.segundoApellido || ""}
                    onChange={(e) => setUserEdit({ ...userEdit, segundoApellido: e.target.value })}
                  />
                </div>
                <div className="col-sm-6">
                  <label>Rol del usuario</label>
                  <select
                    className="form-control"
                    required
                    value={userEdit?.idRol || ""}
                    onChange={(e) => setUserEdit({ ...userEdit, idRol: parseInt(e.target.value) })}
                  >
                    <option value="">Seleccione un rol</option>
                    {roles.map((rol) => (
                      <option key={rol.idRol} value={rol.idRol}>
                        {rol.nombreRol}
                      </option>
                    ))}
                  </select>
                </div>
              </div>

              {/* Solo mostrar campos de contraseña para nuevos usuarios */}
              {!userEdit?.idUsuario && (
                <>
                  <div className="mb-3">
                    <label>Contraseña</label>
                    <div className="input-group">
                      <input
                        className="form-control"
                        type={passwordVisible ? "text" : "password"}
                        placeholder="Contraseña"
                        required
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        minLength="6"
                      />
                      <button 
                        type="button"
                        className="btn btn-outline-secondary"
                        onClick={() => setPasswordVisible(!passwordVisible)}
                      >
                        {passwordVisible ? <FaEyeSlash /> : <FaEye />}
                      </button>
                    </div>
                    {password && (
                      <>
                        <div className="progress mt-2">
                          <div 
                            className={`progress-bar ${getPasswordStrengthColor()}`} 
                            role="progressbar" 
                            style={{ width: `${passwordStrength}%` }} 
                            aria-valuenow={passwordStrength} 
                            aria-valuemin="0" 
                            aria-valuemax="100"
                          ></div>
                        </div>
                        <small className="text-muted">
                          {passwordStrength < 60 && "Contraseña débil - No permitida. "}
                          {passwordStrength >= 60 && passwordStrength < 100 && "Contraseña aceptable. "}
                          {passwordStrength >= 100 && "Contraseña fuerte. "}
                        </small>
                      </>
                    )}
                    <small className="form-text text-muted">
                      La contraseña debe tener al menos 8 caracteres, incluir letras y números.
                    </small>
                  </div>
                  <div className="mb-3">
                    <label>Confirmar Contraseña</label>
                    <div className="input-group">
                      <input
                        className="form-control"
                        type={confirmPasswordVisible ? "text" : "password"}
                        placeholder="Confirmar Contraseña"
                        required
                        value={confirmPassword}
                        onChange={(e) => setConfirmPassword(e.target.value)}
                      />
                      <button 
                        type="button"
                        className="btn btn-outline-secondary"
                        onClick={() => setConfirmPasswordVisible(!confirmPasswordVisible)}
                      >
                        {confirmPasswordVisible ? <FaEyeSlash /> : <FaEye />}
                      </button>
                    </div>
                    {password && confirmPassword && (
                      <small className={password === confirmPassword ? "text-success" : "text-danger"}>
                        {password === confirmPassword ? "Las contraseñas coinciden" : "Las contraseñas no coinciden"}
                      </small>
                    )}
                  </div>
                </>
              )}
              <Button variant="primary" type="submit">
                Guardar Datos
              </Button>
            </form>
          </Modal.Body>
        </Modal>

        {/* Modal para cambiar contraseña */}
        <Modal show={showPasswordModal} onHide={handleClosePasswordModal}>
          <Modal.Header closeButton>
            <Modal.Title>Cambiar Contraseña</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <form onSubmit={handlePasswordUpdate}>
              <div className="mb-3">
                <label>Nueva Contraseña</label>
                <div className="input-group">
                  <input
                    className="form-control"
                    type={passwordVisible ? "text" : "password"}
                    placeholder="Nueva Contraseña"
                    required
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    minLength="6"
                  />
                  <button 
                    type="button"
                    className="btn btn-outline-secondary"
                    onClick={() => setPasswordVisible(!passwordVisible)}
                  >
                    {passwordVisible ? <FaEyeSlash /> : <FaEye />}
                  </button>
                </div>
                {password && (
                  <>
                    <div className="progress mt-2">
                      <div 
                        className={`progress-bar ${getPasswordStrengthColor()}`} 
                        role="progressbar" 
                        style={{ width: `${passwordStrength}%` }} 
                        aria-valuenow={passwordStrength} 
                        aria-valuemin="0" 
                        aria-valuemax="100"
                      ></div>
                    </div>
                    <small className="text-muted">
                      {passwordStrength < 60 && "Contraseña débil - No permitida"}
                      {passwordStrength >= 60 && passwordStrength < 100 && "Contraseña aceptable"}
                      {passwordStrength >= 100 && "Contraseña fuerte"}
                    </small>
                  </>
                )}
                <small className="form-text text-muted">
                  La contraseña debe tener al menos 6 caracteres, incluir letras y números.
                </small>
              </div>
              <div className="mb-3">
                <label>Confirmar Nueva Contraseña</label>
                <div className="input-group">
                  <input
                    className="form-control"
                    type={confirmPasswordVisible ? "text" : "password"}
                    placeholder="Confirmar Contraseña"
                    required
                    value={confirmPassword}
                    onChange={(e) => setConfirmPassword(e.target.value)}
                  />
                  <button 
                    type="button"
                    className="btn btn-outline-secondary"
                    onClick={() => setConfirmPasswordVisible(!confirmPasswordVisible)}
                  >
                    {confirmPasswordVisible ? <FaEyeSlash /> : <FaEye />}
                  </button>
                </div>
                {password && confirmPassword && (
                  <small className={password === confirmPassword ? "text-success" : "text-danger"}>
                    {password === confirmPassword ? "Las contraseñas coinciden" : "Las contraseñas no coinciden"}
                  </small>
                )}
              </div>
              <Button variant="primary" type="submit">
                Cambiar Contraseña
              </Button>
            </form>
          </Modal.Body>
        </Modal>

        <ToastContainer />

        <div className="table-responsive mt-5">
          <table className="table table-hover table-bordered table-lg">
            <thead>
              <tr>
                <th>Nombre</th>
                <th>Primer Apellido</th>
                <th>Segundo Apellido</th>
                <th>Correo</th>
                <th>Teléfono Usuario</th>
                <th>Rol Usuario</th>
                <th>Estado</th>
                <th>Acciones</th>
              </tr>
            </thead>
            <tbody>
              {currentUsers.length === 0 ? (
                <tr>
                  <td colSpan="8" className="text-center">
                    No hay registros.
                  </td>
                </tr>
              ) : (
                currentUsers.map((user) => (
                  <tr key={user.idUsuario}>
                    <td>{user.nombreUsuario}</td>
                    <td>{user.primerApellido}</td>
                    <td>{user.segundoApellido}</td>
                    <td>{user.correoUsuario}</td>
                    <td>{user.telefonoUsuario || "Sin número registrado..."}</td>
                    <td>{user.rol.nombreRol}</td>
                    <td>
                      <button
                        className={`btn btn-sm ${user.estadoUsuario ? "btn-success" : "btn-danger"}`}
                        onClick={() => activarDesactivarUsuario(user.idUsuario)}
                      >
                        {user.estadoUsuario ? "Activo" : "Inactivo"}
                      </button>
                    </td>
                    <td>
                      <button
                        className="btn btn-warning btn-sm me-2"
                        onClick={() => handleOpenModal(user)}
                        title="Editar usuario"
                      >
                        <FaEdit />
                      </button>
                      <button
                        className="btn btn-danger btn-sm me-2"
                        onClick={() => handleDelete(user.idUsuario)}
                        title="Eliminar usuario"
                      >
                        <FaTrash />
                      </button>
                      <button
                        className="btn btn-info btn-sm"
                        onClick={() => handleOpenPasswordModal(user)}
                        title="Cambiar contraseña"
                      >
                        <FaKey />
                      </button>
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
        <PaginacionApp
          currentPage={currentPage}
          totalPages={totalPages}
          onPageChange={setCurrentPage}
        />
      </div>
      <FooterApp />
    </div>
  );
};

export default GestionarUsuario;
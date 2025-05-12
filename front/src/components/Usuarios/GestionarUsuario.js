import React, { useState, useEffect } from "react";
import axios from "axios";
import "bootstrap/dist/css/bootstrap.min.css";
import { FaKey, FaTrash, FaEdit } from "react-icons/fa";
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
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [telefono, setTelefono] = useState("");
  const { usuario } = useAuth();
  const [roles, setRoles] = useState([]);
  const [currentPage, setCurrentPage] = useState(1);
  const [selectedRole, setSelectedRole] = useState("Todos");
  const itemsPerPage = 5;

  // Estados para datos de usuario
  const [correoUsuario, setCorreoUsuario] = useState("");
  const [nombreUsuario, setNombreUsuario] = useState("");
  const [primerApellido, setPrimerApellido] = useState("");
  const [segundoApellido, setSegundoApellido] = useState("");
  const [idRol, setIdRol] = useState("");

  useEffect(() => {
    cargarUsuarios();
    cargarRoles();
  }, []);

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

  const validarFormulario = () => {
    if (
      !correoUsuario.trim() ||
      !nombreUsuario.trim() ||
      !primerApellido.trim() ||
      !segundoApellido.trim() ||
      !idRol
    ) {
      toast.error("Todos los campos marcados son obligatorios");
      return false;
    }

    // Validar formato de correo
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(correoUsuario)) {
      toast.error("El formato del correo electrónico es incorrecto");
      return false;
    }

    // Validar teléfono (opcional pero si se ingresa debe ser válido)
    if (telefono && !/^\d{8,15}$/.test(telefono)) {
      toast.error("El número de teléfono debe tener entre 8 y 15 dígitos");
      return false;
    }

    // Validar contraseña solo al crear usuario nuevo
    if (!userEdit?.idUsuario) {
      if (!password) {
        toast.error("La contraseña es obligatoria para nuevos usuarios");
        return false;
      }
      
      if (password.length < 6) {
        toast.error("La contraseña debe tener al menos 6 caracteres");
        return false;
      }
      
      if (password !== confirmPassword) {
        toast.error("Las contraseñas no coinciden");
        return false;
      }
    } else if (password) {
      // Si está editando y proporciona una contraseña
      if (password.length < 6) {
        toast.error("La contraseña debe tener al menos 6 caracteres");
        return false;
      }
      
      if (password !== confirmPassword) {
        toast.error("Las contraseñas no coinciden");
        return false;
      }
    }

    return true;
  };

  const handleShowModal = (user = null) => {
    if (user) {
      // Editar usuario existente
      setUserEdit(user);
      setCorreoUsuario(user.correoUsuario);
      setNombreUsuario(user.nombreUsuario);
      setPrimerApellido(user.primerApellido);
      setSegundoApellido(user.segundoApellido);
      setTelefono(user.telefonoUsuario || "");
      setIdRol(user.rol.idRol);
      setPassword("");
      setConfirmPassword("");
    } else {
      // Crear nuevo usuario
      setUserEdit(null);
      setCorreoUsuario("");
      setNombreUsuario("");
      setPrimerApellido("");
      setSegundoApellido("");
      setTelefono("");
      setIdRol("");
      setPassword("");
      setConfirmPassword("");
    }
    setShowModal(true);
  };

  const handleCloseModal = () => {
    setShowModal(false);
    setUserEdit(null);
    setCorreoUsuario("");
    setNombreUsuario("");
    setPrimerApellido("");
    setSegundoApellido("");
    setTelefono("");
    setIdRol("");
    setPassword("");
    setConfirmPassword("");
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    if (!validarFormulario()) return;

    const userData = {
      correoUsuario,
      nombreUsuario,
      primerApellido,
      segundoApellido,
      telefonoUsuario: telefono || null,
      rol: {
        idRol: parseInt(idRol)
      }
    };

    // Añadir contraseña si se proporciona
    if (password) {
      userData.contraseniaUsuario = password;
    }

    // Añadir ID si estamos editando
    if (userEdit?.idUsuario) {
      userData.idUsuario = userEdit.idUsuario;
      userData.estadoUsuario = userEdit.estadoUsuario;
    }

    try {
      if (userEdit?.idUsuario) {
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

  return (
    <div className="content-container">
      <SideBar usuario={usuario} />
      <div className="container mt-5">
        <h1>Gestión de usuarios</h1>
        <Button className="custom-button add-product-btn" onClick={() => handleShowModal()}>
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

        <Modal show={showModal} onHide={handleCloseModal} className="usuario-modal" size="lg" centered>
          <Modal.Header closeButton className="modal-header">
            <Modal.Title>
              {userEdit ? "Actualizar Usuario" : "Agregar Usuario"}
            </Modal.Title>
          </Modal.Header>
          <Modal.Body className="modal-body">
            <form onSubmit={handleSubmit}>
              <div className="row">
                <div className="col-md-6">
                  <div className="form-group mb-3">
                    <label htmlFor="correoUsuario">Correo Electrónico <span className="text-danger">*</span></label>
                    <input
                      id="correoUsuario"
                      className="form-control"
                      type="email"
                      placeholder="Correo electrónico"
                      required
                      value={correoUsuario}
                      onChange={(e) => setCorreoUsuario(e.target.value)}
                    />
                  </div>

                  <div className="form-group mb-3">
                    <label htmlFor="nombreUsuario">Nombre <span className="text-danger">*</span></label>
                    <input
                      id="nombreUsuario"
                      className="form-control"
                      type="text"
                      placeholder="Nombre"
                      required
                      value={nombreUsuario}
                      onChange={(e) => setNombreUsuario(e.target.value)}
                    />
                  </div>

                  <div className="form-group mb-3">
                    <label htmlFor="primerApellido">Primer Apellido <span className="text-danger">*</span></label>
                    <input
                      id="primerApellido"
                      className="form-control"
                      type="text"
                      placeholder="Primer apellido"
                      required
                      value={primerApellido}
                      onChange={(e) => setPrimerApellido(e.target.value)}
                    />
                  </div>

                  <div className="form-group mb-3">
                    <label htmlFor="rolUsuario">Rol del usuario <span className="text-danger">*</span></label>
                    <select
                      id="rolUsuario"
                      className="form-control"
                      required
                      value={idRol}
                      onChange={(e) => setIdRol(e.target.value)}
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

                <div className="col-md-6">
                  <div className="form-group mb-3">
                    <label htmlFor="segundoApellido">Segundo Apellido <span className="text-danger">*</span></label>
                    <input
                      id="segundoApellido"
                      className="form-control"
                      type="text"
                      placeholder="Segundo apellido"
                      required
                      value={segundoApellido}
                      onChange={(e) => setSegundoApellido(e.target.value)}
                    />
                  </div>

                  <div className="form-group mb-3">
                    <label htmlFor="telefonoUsuario">Teléfono</label>
                    <input
                      id="telefonoUsuario"
                      className="form-control"
                      type="tel"
                      placeholder="Número de teléfono"
                      value={telefono}
                      onChange={(e) => setTelefono(e.target.value)}
                    />
                  </div>

                  <div className="form-group mb-3">
                    <label htmlFor="contraseniaUsuario">
                      {userEdit ? "Contraseña (Dejar en blanco para mantener la actual)" : "Contraseña"} 
                      {!userEdit && <span className="text-danger">*</span>}
                    </label>
                    <input
                      id="contraseniaUsuario"
                      className="form-control"
                      type="password"
                      placeholder="Contraseña"
                      required={!userEdit}
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                    />
                  </div>

                  <div className="form-group mb-3">
                    <label htmlFor="confirmarContrasenia">
                      {userEdit ? "Confirmar Contraseña (Si la cambió)" : "Confirmar Contraseña"}
                      {!userEdit && <span className="text-danger">*</span>}
                    </label>
                    <input
                      id="confirmarContrasenia"
                      className="form-control"
                      type="password"
                      placeholder="Confirmar contraseña"
                      required={!userEdit}
                      value={confirmPassword}
                      onChange={(e) => setConfirmPassword(e.target.value)}
                    />
                  </div>
                </div>
              </div>

              <div className="d-flex justify-content-end gap-2 mt-4">
                <Button variant="outline-secondary" onClick={handleCloseModal}>
                  Cancelar
                </Button>
                <Button className="btn-submit" type="submit">
                  {userEdit ? "Actualizar" : "Agregar"}
                </Button>
              </div>
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
                        onClick={() => handleShowModal(user)}
                      >
                        <FaEdit />
                      </button>
                      <button
                        className="btn btn-danger btn-sm"
                        onClick={() => handleDelete(user.idUsuario)}
                      >
                        <FaTrash />
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
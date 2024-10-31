import React, { useState, useEffect } from "react";
import axios from "axios";
import "bootstrap/dist/css/bootstrap.min.css";
import { FaKey, FaTrash } from "react-icons/fa";
import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import Swal from "sweetalert2";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faEdit } from "@fortawesome/free-solid-svg-icons";
import useAuth from "../../hooks/useAuth";
import Navbar from "../Navbar";
import { Button, Modal } from "react-bootstrap";
import "./Usuarios.css";

const GestionarUsuario = () => {
  const [users, setUsers] = useState([]);
  const [search, setSearch] = useState("");
  const [userEdit, setUserEdit] = useState(null);
  const [showModal, setShowModal] = useState(false);
  const [showPasswordModal, setShowPasswordModal] = useState(false);
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const { usuario, handleLogout } = useAuth();
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 5;

  useEffect(() => {
    cargarUsuarios();
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

  const agregarUsuario = async (usuario) => {
    const email = usuario.correoUsuario.trim();
    const nombre = usuario.nombreUsuario.trim();
    const primerApellido = usuario.primerApellido.trim();
    const segundoApellido = usuario.segundoApellido.trim();
    const contrasenia = usuario.contraseniaUsuario.trim();

    if (!email || !nombre || !primerApellido || !segundoApellido) {
      toast.error(
        "Todos los campos son obligatorios y no pueden estar vacíos o contener solo espacios"
      );
      return;
    }

    if (contrasenia.length < 8) {
      toast.error("La contraseña debe tener al menos 8 caracteres");
      return;
    }

    if (contrasenia !== confirmPassword) {
      toast.error("Las contraseñas no coinciden");
      return;
    }

    try {
      await axios.post("http://localhost:8080/usuario/registrar", usuario);
      toast.success("Usuario agregado con éxito");
      cargarUsuarios();
      handleCloseModal();
    } catch (error) {
      console.error("Error al agregar el usuario:", error);
      toast.error("Ocurrió un error al agregar el usuario");
    }
  };

  const actualizarUsuario = async (usuario) => {
    try {
      await axios.put("http://localhost:8080/usuario/actualizar", usuario);
      toast.success("Usuario actualizado con éxito");
      cargarUsuarios();
      handleCloseModal();
    } catch (error) {
      console.error("Error al actualizar usuario:", error);
      toast.error("Ocurrió un error al actualizar el usuario");
    }
  };

  const actualizarContrasena = async (idUsuario) => {
    if (password !== confirmPassword) {
      toast.error("Las contraseñas no coinciden");
      return;
    }
    try {
      await axios.put(`http://localhost:8080/usuario/actualizarContrasena`, {
        idUsuario,
        password,
      });
      toast.success("Contraseña actualizada con éxito");
      cargarUsuarios();
      handleClosePasswordModal();
    } catch (error) {
      console.error("Error al actualizar la contraseña:", error);
      toast.error("Ocurrió un error al actualizar la contraseña");
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

  const handleShowPasswordModal = (user) => {
    setUserEdit(user);
    setShowPasswordModal(true);
  };

  const handleClosePasswordModal = () => {
    setShowPasswordModal(false);
    setPassword("");
    setConfirmPassword("");
  };

  const handleSearchChange = (e) => setSearch(e.target.value);

  const filteredUsers = search
    ? users.filter((user) =>
        user.nombreUsuario.toLowerCase().includes(search.toLowerCase())
      )
    : users;

  const totalPages = Math.ceil(filteredUsers.length / itemsPerPage);
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentUsers = filteredUsers.slice(indexOfFirstItem, indexOfLastItem);

  const handleNextPage = () => {
    if (currentPage < totalPages) setCurrentPage(currentPage + 1);
  };

  const handlePreviousPage = () => {
    if (currentPage > 1) setCurrentPage(currentPage - 1);
  };

  const handleShowModal = (user = null) => {
    setUserEdit(user);
    setShowModal(true);
  };

  const handleCloseModal = () => {
    setShowModal(false);
    setUserEdit(null);
    setPassword("");
    setConfirmPassword("");
  };

  return (
    <div>
      <Navbar usuario={usuario} onLogout={handleLogout} />
      <div className="container mt-5">
        <h1>Gestión de Usuarios</h1>
        <Button className="custom-button" onClick={() => handleShowModal()}>
          Agregar Nuevo Usuario
        </Button>
        <div className="mb-2"></div>
        <label>Buscar usuario</label>
        <input
          type="text"
          className="form-control my-3"
          placeholder="Buscar usuario"
          value={search}
          onChange={handleSearchChange}
        />

        <Modal show={showModal} onHide={handleCloseModal}>
          <Modal.Header closeButton>
            <Modal.Title>
              {userEdit && userEdit.idUsuario
                ? "Actualizar Usuario"
                : "Agregar Usuario"}
            </Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <form
              onSubmit={(e) => {
                e.preventDefault();
                if (userEdit && userEdit.idUsuario) {
                  actualizarUsuario(userEdit);
                } else {
                  agregarUsuario({ ...userEdit, contraseniaUsuario: password });
                }
              }}
            >
              <div className="mb-3">
                <label>Correo Electrónico</label>
                <input
                  className="form-control"
                  type="email"
                  placeholder="Correo Electrónico"
                  required
                  value={userEdit ? userEdit.correoUsuario : ""}
                  onChange={(e) =>
                    setUserEdit({ ...userEdit, correoUsuario: e.target.value })
                  }
                />
              </div>
              <div className="row mb-3">
                <div className="col-sm-6">
                  <label>Nombre:</label>
                  <input
                    className="form-control"
                    type="text"
                    placeholder="Nombre"
                    required
                    value={userEdit ? userEdit.nombreUsuario : ""}
                    onChange={(e) =>
                      setUserEdit({
                        ...userEdit,
                        nombreUsuario: e.target.value,
                      })
                    }
                  />
                </div>
                <div className="col-sm-6">
                  <label>Primer apellido</label>
                  <input
                    className="form-control"
                    type="text"
                    placeholder="Primer apellido"
                    required
                    value={userEdit ? userEdit.primerApellido : ""}
                    onChange={(e) =>
                      setUserEdit({
                        ...userEdit,
                        primerApellido: e.target.value,
                      })
                    }
                  />
                </div>
              </div>
              <div className="row mb-3">
                <div className="col-sm-6">
                  <label>Segundo apellido</label>
                  <input
                    className="form-control"
                    type="text"
                    placeholder="Segundo apellido"
                    required
                    value={userEdit ? userEdit.segundoApellido : ""}
                    onChange={(e) =>
                      setUserEdit({
                        ...userEdit,
                        segundoApellido: e.target.value,
                      })
                    }
                  />
                </div>
              </div>
              {!userEdit?.idUsuario && (
                <>
                  <div className="mb-3">
                    <label>Contraseña</label>
                    <input
                      className="form-control"
                      type="password"
                      placeholder="Contraseña"
                      required
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                    />
                  </div>
                  <div className="mb-4">
                    <label>Confirmar Contraseña</label>
                    <input
                      className="form-control"
                      type="password"
                      placeholder="Confirmar Contraseña"
                      required
                      value={confirmPassword}
                      onChange={(e) => setConfirmPassword(e.target.value)}
                    />
                  </div>
                </>
              )}
              <Button variant="primary" type="submit">
                Guardar Datos
              </Button>
            </form>
          </Modal.Body>
          <Modal.Footer>
            <Button variant="secondary" onClick={handleCloseModal}>
              Cerrar
            </Button>
          </Modal.Footer>
        </Modal>

        <Modal show={showPasswordModal} onHide={handleClosePasswordModal}>
          <Modal.Header closeButton>
            <Modal.Title>Cambiar Contraseña</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <form
              onSubmit={(e) => {
                e.preventDefault();
                actualizarContrasena(userEdit.idUsuario);
              }}
            >
              <div className="mb-3">
                <label>Contraseña</label>
                <input
                  className="form-control"
                  type="password"
                  placeholder="Nueva Contraseña"
                  required
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                />
              </div>
              <div className="mb-3">
                <label>Confirmar Contraseña</label>
                <input
                  className="form-control"
                  type="password"
                  placeholder="Confirmar Contraseña"
                  required
                  value={confirmPassword}
                  onChange={(e) => setConfirmPassword(e.target.value)}
                />
              </div>
              <Button variant="primary" type="submit">
                Cambiar Contraseña
              </Button>
            </form>
          </Modal.Body>
        </Modal>

        <ToastContainer />

        <div className="table-responsive mt-5">
          <table className="table table-hover table-bordered">
            <thead>
              <tr>
                <th>Nombre</th>
                <th>Primer apellido</th>
                <th>Segundo apellido</th>
                <th>Correo</th>
                <th>Estado</th>
                <th>Acción</th>
              </tr>
            </thead>
            <tbody>
              {currentUsers.map((user) => (
                <tr key={user.idUsuario}>
                  <td>{user.nombreUsuario}</td>
                  <td>{user.primerApellido}</td>
                  <td>{user.segundoApellido}</td>
                  <td>{user.correoUsuario}</td>
                  <td>
                    <button
                      className={`btn btn-sm ${
                        user.estadoUsuario ? "btn-success" : "btn-danger"
                      }`}
                    >
                      {user.estadoUsuario ? "Activo" : "Inactivo"}
                    </button>
                  </td>
                  <td>
                    <button
                      className="btn btn-warning btn-sm me-2"
                      onClick={() => handleShowModal(user)}
                    >
                      <FontAwesomeIcon icon={faEdit} />
                    </button>
                    <button
                      className="btn btn-danger btn-sm me-2"
                      onClick={() => handleDelete(user.idUsuario)}
                    >
                      <FaTrash />
                    </button>
                    <button
                      className="btn btn-info btn-sm"
                      onClick={() => handleShowPasswordModal(user)}
                    >
                      <FaKey />
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        <div className="d-flex justify-content-center mt-3">
          <nav>
            <ul className="pagination">
              <li
                className={`page-item ${currentPage === 1 ? "disabled" : ""}`}
              >
                <button className="page-link" onClick={handlePreviousPage}>
                  Anterior
                </button>
              </li>
              {[...Array(totalPages)].map((_, index) => (
                <li
                  key={index}
                  className={`page-item ${
                    currentPage === index + 1 ? "active" : ""
                  }`}
                >
                  <button
                    onClick={() => setCurrentPage(index + 1)}
                    className="page-link"
                  >
                    {index + 1}
                  </button>
                </li>
              ))}
              <li
                className={`page-item ${
                  currentPage === totalPages ? "disabled" : ""
                }`}
              >
                <button className="page-link" onClick={handleNextPage}>
                  Siguiente
                </button>
              </li>
            </ul>
          </nav>
        </div>
      </div>
    </div>
  );
};

export default GestionarUsuario;

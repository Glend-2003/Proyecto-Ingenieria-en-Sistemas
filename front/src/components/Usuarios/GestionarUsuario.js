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
  const [showPasswordModal, setShowPasswordModal] = useState(false);
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const { usuario } = useAuth();
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

  // Funciones para cerrar modales
  const handleCloseModal = () => {
    setShowModal(false);
    setUserEdit(null);
    setPassword("");
    setConfirmPassword("");
  };

  const handleClosePasswordModal = () => {
    setShowPasswordModal(false);
    setPassword("");
    setConfirmPassword("");
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const userData = { ...userEdit, contraseniaUsuario: password };
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

  const handlePasswordUpdate = async (e) => {
    e.preventDefault();
    if (password !== confirmPassword) {
      toast.error("Las contraseñas no coinciden");
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

  const handleSearchChange = (e) => setSearch(e.target.value);

  const filteredUsers = users.filter((user) =>
    user.nombreUsuario.toLowerCase().includes(search.toLowerCase())
  );

  const totalPages = Math.ceil(filteredUsers.length / itemsPerPage);
  const currentUsers = filteredUsers.slice(
    (currentPage - 1) * itemsPerPage,
    currentPage * itemsPerPage
  );

  return (
    <div className="content-container">
      <SideBar usuario={usuario} />
      <div className="container mt-5">
        <h1>Gestión de usuarios</h1>
        <Button className="custom-button" onClick={() => setShowModal(true)}>
          Agregar usuario nuevo
        </Button>
        <div className="mb-2"></div>
        <label>Buscar usuario</label>
        <input
          type="text"
          className="form-control my-3"
          placeholder="Buscar usuario por nombre"
          value={search}
          onChange={handleSearchChange}
        />

        <Modal show={showModal} onHide={() => setShowModal(false)}>
          <Modal.Header closeButton>
            <Modal.Title>{userEdit ? "Actualizar Usuario" : "Agregar Usuario"}</Modal.Title>
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
                </>
              )}
              <Button variant="primary" type="submit">
                Guardar Datos
              </Button>
            </form>
          </Modal.Body>
        </Modal>

        <Modal show={showPasswordModal} onHide={() => setShowPasswordModal(false)}>
          <Modal.Header closeButton>
            <Modal.Title>Cambiar Contraseña</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <form onSubmit={handlePasswordUpdate}>
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
          <table className="table table-hover table-bordered table-lg">
            <thead>
              <tr>
                <th>No.</th>
                <th>Nombre</th>
                <th>Primer Apellido</th>
                <th>Segundo Apellido</th>
                <th>Correo</th>
                <th>Estado</th>
                <th>Acciones</th>
              </tr>
            </thead>
            <tbody>
              {currentUsers.length === 0 ? (
                <tr>
                  <td colSpan="7" className="text-center">
                    No hay registros.
                  </td>
                </tr>
              ) : (
                currentUsers.map((user, index) => (
                  <tr key={user.idUsuario}>
                    <td>{index + 1 + (currentPage - 1) * itemsPerPage}</td>
                    <td>{user.nombreUsuario}</td>
                    <td>{user.primerApellido}</td>
                    <td>{user.segundoApellido}</td>
                    <td>{user.correoUsuario}</td>
                    <td>
                      <button
                        className={`btn btn-sm ${user.estadoUsuario ? "btn-success" : "btn-danger"}`}
                      >
                        {user.estadoUsuario ? "Activo" : "Inactivo"}
                      </button>
                    </td>
                    <td>
                      <button
                        className="btn btn-warning btn-sm me-2"
                        onClick={() => { setUserEdit(user); setShowModal(true); }}
                      >
                        <FaEdit />
                      </button>
                      <button
                        className="btn btn-danger btn-sm me-2"
                        onClick={() => handleDelete(user.idUsuario)}
                      >
                        <FaTrash />
                      </button>
                      <button
                        className="btn btn-info btn-sm"
                        onClick={() => { setUserEdit(user); setShowPasswordModal(true); }}
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
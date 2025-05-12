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
  const { usuario } = useAuth();
  const [roles, setRoles] = useState([]);
  const [currentPage, setCurrentPage] = useState(1);
  const [selectedRole, setSelectedRole] = useState("Todos");
  const itemsPerPage = 5;

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

  const handleOpenModal = () => {
    setUserEdit({
      correoUsuario: "",
      nombreUsuario: "",
      primerApellido: "",
      segundoApellido: "",
      idRol: "", // Valor predeterminado para el rol de cliente
    });
    setShowModal(true);
  };
  // Funciones para cerrar modales
  const handleCloseModal = () => {
    setShowModal(false);
    setUserEdit(null);
  };


  const handleSubmit = async (e) => {
    e.preventDefault();
    const idRol = userEdit.idRol; // 3 es el valor predeterminado para el rol de cliente

    const userData = {
      ...userEdit,
      contraseniaUsuario: password,
      rol: {
        idRol
      }, // Usa el valor predeterminado si no se selecciona un rol
    };

    console.log("Datos enviados al backend:", userData); // Verifica que idRol esté correcto
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
        <Button className="custom-button" onClick={() => setShowModal(true)}>
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
          placeholder="Buscar usuario por nombre o contraseña"
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
                <div className="col-sm-6">
                  <label>Rol del usuario</label>
                  <select
                    className="form-control"
                    required
                    value={userEdit?.idRol || ""} // Usa un valor predeterminado vacío si es null/undefined
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
              <Button variant="primary" type="submit">
                Guardar Datos
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
                <th>Telefono Usuario</th>
                <th>Rol Usuario</th>
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
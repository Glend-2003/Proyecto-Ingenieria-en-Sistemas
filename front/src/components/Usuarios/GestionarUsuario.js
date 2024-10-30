import React, { useState, useEffect } from 'react';
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.min.css';
import { FaKey, FaTrash } from 'react-icons/fa';
import { toast, ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import Swal from 'sweetalert2';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faEdit } from '@fortawesome/free-solid-svg-icons';
import useAuth from '../../hooks/useAuth';
import Navbar from '../Navbar';
import { Button, Modal } from 'react-bootstrap';

const GestionarUsuario = () => {
  const [users, setUsers] = useState([]);
  const [search, setSearch] = useState('');
  const [userEdit, setUserEdit] = useState(null);
  const [showModal, setShowModal] = useState(false);
  const [showPasswordModal, setShowPasswordModal] = useState(false);
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const { usuario, handleLogout } = useAuth();
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 5;

  useEffect(() => {
    cargarUsuarios();
  }, []);

  const cargarUsuarios = async () => {
    try {
      const response = await axios.get('http://localhost:8080/usuario/');
      setUsers(response.data);
    } catch (error) {
      console.error('Error al cargar los usuarios:', error);
      toast.error('Ocurrió un error al cargar los usuarios');
    }
  };

  const agregarUsuario = async (usuario) => {
    try {
      await axios.post('http://localhost:8080/usuario/agregar', usuario);
      toast.success('Usuario agregado con éxito');
      cargarUsuarios();
      handleCloseModal();
    } catch (error) {
      console.error('Error al agregar el usuario:', error);
      toast.error('Ocurrió un error al agregar el usuario');
    }
  };

  const actualizarUsuario = async (usuario) => {
    try {
      await axios.put('http://localhost:8080/usuario/actualizar', usuario);
      toast.success('Usuario actualizado con éxito');
      cargarUsuarios();
      handleCloseModal();
    } catch (error) {
      console.error('Error al actualizar usuario:', error);
      toast.error('Ocurrió un error al actualizar el usuario');
    }
  };

  //FALTA METODO BACKEND
  const actualizarContrasena = async (idUsuario) => {
    if (password !== confirmPassword) {
      toast.error('Las contraseñas no coinciden');
      return;
    }
    try {
      await axios.put(`http://localhost:8080/usuario/actualizarContrasena`, { idUsuario, password });
      toast.success('Contraseña actualizada con éxito');
      cargarUsuarios();
      handleClosePasswordModal();
    } catch (error) {
      console.error('Error al actualizar la contraseña:', error);
      toast.error('Ocurrió un error al actualizar la contraseña');
    }
  };

  const handleDelete = async (idUsuario) => {
    const { isConfirmed } = await Swal.fire({
      title: '¿Estás seguro?',
      text: 'No podrás revertir esto.',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonText: 'Sí, eliminar',
      cancelButtonText: 'No, cancelar',
      reverseButtons: true,
    });

    if (!isConfirmed) return;

    try {
      await axios.delete(`http://localhost:8080/usuario/eliminar/${idUsuario}`);
      toast.success('Usuario eliminado con éxito');
      cargarUsuarios();
    } catch (error) {
      console.error('Error al eliminar usuario:', error);
      toast.error('Ocurrió un error al eliminar el usuario');
    }
  };

  const handleShowPasswordModal = (user) => {
    setUserEdit(user);
    setShowPasswordModal(true);
  };

  const handleClosePasswordModal = () => {
    setShowPasswordModal(false);
    setPassword('');
    setConfirmPassword('');
  };

  const handleSearchChange = (e) => setSearch(e.target.value);

  const handleShowModal = (user = null) => {
    setUserEdit(user);
    setShowModal(true);
  };

  const handleCloseModal = () => {
    setShowModal(false);
    setUserEdit(null);
  };

  const filteredUsers = users.filter(user =>
    user.nombreUsuario.toLowerCase().includes(search.toLowerCase())
  );

  const totalPages = Math.ceil(filteredUsers.length / itemsPerPage);
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentCategorias = filteredUsers.slice(indexOfFirstItem, indexOfLastItem);

  const paginate = (pageNumber) => setCurrentPage(pageNumber);

  return (
    <div>
      <Navbar usuario={usuario} onLogout={handleLogout} />
      <div className="container mt-5">
        <h1>Gestión de Usuarios</h1>
        <Button variant="primary" onClick={() => handleShowModal()}>Agregar Nuevo Usuario</Button>
        
        {/* Modal de Actualización */}
        <Modal show={showModal} onHide={handleCloseModal}>
          <Modal.Header closeButton>
            <Modal.Title>{userEdit && userEdit.idUsuario ? 'Actualizar Usuario' : 'Agregar Usuario'}</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <form onSubmit={(e) => {
              e.preventDefault();
              if (userEdit && userEdit.idUsuario) {
                actualizarUsuario(userEdit);
              } else {
                agregarUsuario(userEdit);
              }
            }}>
              <div className="mb-3">
                <input
                  className="form-control"
                  type="email"
                  placeholder="Correo Electrónico"
                  required
                  value={userEdit ? userEdit.correoUsuario : ''}
                  onChange={(e) => setUserEdit({ ...userEdit, correoUsuario: e.target.value })}
                />
              </div>
              <div className="row mb-3">
                <div className="col-sm-6">
                  <input
                    className="form-control"
                    type="text"
                    placeholder="Nombre"
                    required
                    value={userEdit ? userEdit.nombreUsuario : ''}
                    onChange={(e) => setUserEdit({ ...userEdit, nombreUsuario: e.target.value })}
                  />
                </div>
                <div className="col-sm-6">
                  <input
                    className="form-control"
                    type="text"
                    placeholder="Primer apellido"
                    required
                    value={userEdit ? userEdit.primerApellido : ''}
                    onChange={(e) => setUserEdit({ ...userEdit, primerApellido: e.target.value })}
                  />
                </div>
              </div>
              <div className="row mb-3">
                <div className="col-sm-6">
                  <input
                    className="form-control"
                    type="text"
                    placeholder="Segundo apellido"
                    required
                    value={userEdit ? userEdit.segundoApellido : ''}
                    onChange={(e) => setUserEdit({ ...userEdit, segundoApellido: e.target.value })}
                  />
                </div>
              </div>
              <Button variant="primary" type="submit">
                Guardar Datos
              </Button>
            </form>
          </Modal.Body>
          <Modal.Footer>
            <Button variant="secondary" onClick={handleCloseModal}>Cerrar</Button>
          </Modal.Footer>
        </Modal>

        {/* Modal de Cambio de Contraseña */}
        <Modal show={showPasswordModal} onHide={handleClosePasswordModal}>
          <Modal.Header closeButton>
            <Modal.Title>Cambiar Contraseña</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <form onSubmit={(e) => {
              e.preventDefault();
              actualizarContrasena(userEdit.idUsuario);
            }}>
              <div className="mb-3">
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

        {/* Tabla de Usuarios */}
        <div className="table-responsive mt-5">
          <table className="table table-hover table-bordered">
            <thead>
              <tr>
                <th>Nombre</th>
                <th>Primer apellido</th>
                <th>Segundo apellido</th>
                <th>Correo</th>
                <th>Acción</th>
              </tr>
            </thead>
            <tbody>
              {filteredUsers.map(user => (
                <tr key={user.idUsuario}>
                  <td>{user.nombreUsuario}</td>
                  <td>{user.primerApellido}</td>
                  <td>{user.segundoApellido}</td>
                  <td>{user.correoUsuario}</td>
                  <td>
                    <button className="btn btn-warning btn-sm me-2" onClick={() => handleShowModal(user)}>
                      <FontAwesomeIcon icon={faEdit} />
                    </button>
                    <button className="btn btn-danger btn-sm me-2" onClick={() => handleDelete(user.idUsuario)}>
                      <FaTrash />
                    </button>
                    <button className="btn btn-info btn-sm" onClick={() => handleShowPasswordModal(user)}>
                      <FaKey />
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default GestionarUsuario;

import React, { useState, useEffect } from 'react';
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.min.css';
import { FaCheck, FaTrash, FaExclamationTriangle } from 'react-icons/fa';
import { toast, ToastContainer } from 'react-toastify'; // Importar toast y ToastContainer
import 'react-toastify/dist/ReactToastify.css';
import Swal from 'sweetalert2';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faCheck, faTrash, faExclamationTriangle, faEdit } from '@fortawesome/free-solid-svg-icons';
import useAuth from '../../hooks/useAuth';
import Navbar from '../Navbar';
import { Button, Modal } from 'react-bootstrap';

const GestionarUsuario = () => {
  // Estado para manejar los datos de los usuarios
  const [users, setUsers] = useState([]);
  const [search, setSearch] = useState('');
  const [userEdit, setUserEdit] = useState(null);
  const [showModal, setShowModal] = useState(false);
  const { usuario, handleLogout } = useAuth();
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 5;

  useEffect(() => {
    cargarUsuarios();
  }, []);

  // Función para manejar el cambio de los inputs de la tabla
  const handleInputChange = (e, idUsuario, field) => {
    const newValue = e.target.value;
    setUsers((prevUsers) =>
      prevUsers.map((user) =>
        user.idUsuario === idUsuario ? { ...user, [field]: newValue } : user
      )
    );
  };

  // Función para obtener la lista de usuarios desde el backend
  const cargarUsuarios = async () => {
    try {
      const response = await axios.get('http://localhost:8080/usuario/');
      setUsers(response.data);
    } catch (error) {
      console.error('Error al cargar los usuarios:', error);
      toast.error('Ocurrió un error al cargar los usuarios');
    }
  };

  // Función para agregar un usuario
  const agregarUsuario = async (usuario) => {
    // Validación de correo duplicado
    const correoDuplicado = users.some(
      (user) => user.correoUsuario.toLowerCase() === usuario.correoUsuario.toLowerCase()
    );

    if (correoDuplicado) {
      toast.error('El correo del usuario ya existe. Por favor, elige uno diferente.');
      return;
    }

    try {
      await axios.post('http://localhost:8080/usuario/registrar', usuario);
      console.log('Usuario agregado:', usuario);
      toast.success('Usuario agregado con éxito', {
        autoClose: 1500,
        onClose: () => {
          cargarUsuarios();
        }
      });
    } catch (error) {
      console.error('Error al agregar usuario:', error);
      toast.error('Ocurrió un error al agregar el usuario');
    }
  };

  // Función para actualizar un usuario
  const actualizarUsuario = async (usuario) => {
    // Validación de correo duplicado al actualizar
    const correoDuplicado = users.some(
      (user) =>
        user.correoUsuario.toLowerCase() === usuario.correoUsuario.toLowerCase() &&
        user.idUsuario !== usuario.idUsuario
    );

    if (correoDuplicado) {
      toast.error('El correo del usuario ya existe. Por favor, elige uno diferente.', {
        autoClose: 1500,
        onClose: () => {
          cargarUsuarios();
        },
      });
      return;
    }

    const { isConfirmed } = await Swal.fire({
      title: '¿Estás seguro?',
      text: 'Esta acción no se puede deshacer.',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonText: 'Sí, actualizar',
      cancelButtonText: 'No, cancelar',
      reverseButtons: true,
    });

    if (isConfirmed) {
      try {
        await axios.put('http://localhost:8080/usuario/actualizar', usuario);
        toast.success('Usuario actualizado con éxito', {
          autoClose: 1500,
          onClose: () => {
            cargarUsuarios();
          },
        });
      } catch (error) {
        console.error('Error al actualizar usuario:', error);
        toast.error('Ocurrió un error al actualizar el usuario');
      }
    }
  };

  // Función para eliminar un usuario
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

    if (!isConfirmed) {
      return;
    }

    try {
      const response = await axios.delete(`http://localhost:8080/usuario/eliminar/${idUsuario}`);
      if (response.status === 200) {
        toast.success('Usuario eliminado con éxito', {
          autoClose: 1500,
          onClose: () => {
            cargarUsuarios();
          },
        });
      }
    } catch (error) {
      console.error('Error al eliminar usuario:', error);
      if (error.response) {
        console.error('Detalles del error:', error.response.data);
      }
      toast.error('Ocurrió un error al eliminar el usuario');
    }
  };

  // Función para manejar la búsqueda
  const handleSearchChange = (e) => {
    setSearch(e.target.value);
  };

  // Función para mostrar el modal
  const handleShowModal = (user = null) => {
    setUserEdit(user);
    setShowModal(true);
  };
  const handleCloseModal = () => {
    setShowModal(false);
    setUserEdit(null);
  };

  // Filtrar los usuarios según la búsqueda
  const filteredUsers = users.filter(user =>
    user.nombreUsuario.toLowerCase().includes(search.toLowerCase())
  );

   // Paginación
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
        <Modal show={showModal} onHide={handleCloseModal}>
          <Modal.Header closeButton>
            <Modal.Title>{userEdit && userEdit.idUsuario ? 'Actualizar Usuario' : 'Agregar Usuario'}</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <form className="user" onSubmit={(e) => {
              e.preventDefault();
              if (userEdit && userEdit.idUsuario) {
                actualizarUsuario(userEdit);
              } else {
                console.log('userEdit:', userEdit);
                agregarUsuario(userEdit);
              }
              handleCloseModal();
            }}>
              <div className="mb-3">
                <input
                  className="form-control form-control-user"
                  type="email"
                  id="email"
                  placeholder="Correo Electrónico"
                  required
                  value={userEdit ? userEdit.correoUsuario : ''}
                  onChange={(e) => setUserEdit({ ...userEdit, correoUsuario: e.target.value })}
                  style={{ borderColor: '#d7d7d7', color: '#212529' }}
                />
              </div>
              <div className="row mb-3">
                <div className="col-sm-6 col-md-4 mb-3 mb-sm-0">
                  <input
                    className="form-control form-control-user"
                    type="text"
                    placeholder="Nombre"
                    required
                    value={userEdit ? userEdit.nombreUsuario : ''}
                    onChange={(e) => setUserEdit({ ...userEdit, nombreUsuario: e.target.value })}
                  />
                </div>
                <div className="col-sm-6 col-md-4">
                  <input
                    className="form-control form-control-user"
                    type="text"
                    placeholder="Primer apellido"
                    required
                    value={userEdit ? userEdit.primerApellido : ''}
                    onChange={(e) => setUserEdit({ ...userEdit, primerApellido: e.target.value })}
                  />
                </div>
                <div className="col-sm-6 col-md-4">
                  <input
                    className="form-control form-control-user"
                    type="text"
                    placeholder="Segundo apellido"
                    required
                    value={userEdit ? userEdit.segundoApellido : ''}
                    onChange={(e) => setUserEdit({ ...userEdit, segundoApellido: e.target.value })}
                  />
                </div>
              </div>
              <div className="row mb-3">
  <div className="col-sm-6 mb-3 mb-sm-0">
    <input
      className="form-control form-control-user"
      type="password"
      id="password"
      placeholder="Contraseña"
      required
      value={userEdit ? userEdit.contraseniaUsuario : ''}
      onChange={(e) => setUserEdit({ ...userEdit, contraseniaUsuario: e.target.value })}
    />
  </div>
  <div className="col-sm-6">
    <input
      className="form-control form-control-user"
      type="password"
      id="verifyPassword"
      placeholder="Confirmar contraseña"
      required
      value={userEdit ? userEdit.verifyPassword : ''}
      onChange={(e) => setUserEdit({ ...userEdit, verifyPassword: e.target.value })}
    />
  </div>
</div>
              <Button variant="primary" type="submit">
                {userEdit ? 'Actualizar Usuario' : 'Registrar Usuario'}
              </Button>
            </form>
          </Modal.Body>
          <Modal.Footer>
            <Button variant="secondary" onClick={handleCloseModal}>Cerrar</Button>
          </Modal.Footer>
        </Modal>
        <ToastContainer />
        <div className="col-md-10 search-table-col" style={{ paddingTop: '0px', marginTop: '50px', marginLeft: '50px' }}>
          <div className="form-group pull-right col-lg-4">
            <input
              type="text"
              className="search form-control"
              placeholder="Buscar por nombre"
              value={search}
              onChange={handleSearchChange}
            />
          </div>
          <div className="table-responsive table table-hover table-bordered results">
            <table className="table table-hover table-bordered">
              <thead className="bill-header cs">
                <tr>
                  
                  <th className="col-lg-2">Nombre</th>
                  <th className="col-lg-3">Primer apellido</th>
                  <th className="col-lg-2">Segundo apellido</th>
                  <th className="col-lg-2">Correo</th>
                  <th className="col-lg-2">Acción</th>
                </tr>
              </thead>
              <tbody>
                {filteredUsers.length === 0 ? (
                  <tr className="warning no-result">
                    <td colSpan="6" className="text-center">
                      <FaExclamationTriangle /> No Result !!!
                    </td>
                  </tr>
                ) : (
                  filteredUsers.map((user, index) => (
                    <tr key={user.idUsuario}>          
                      <td>{user.nombreUsuario}</td>
                      <td>{user.primerApellido}</td>
                      <td>{user.segundoApellido}</td>
                      <td>{user.correoUsuario}</td>
                      <td>
                        <button
                          className="btn btn-warning btn-sm me-2"
                          type="button"
                          onClick={() => handleShowModal(user)}
                        >
                          <FontAwesomeIcon icon={faEdit} style={{ fontSize: '15px' }} />
                        </button>
                        <button
                          className="btn btn-danger btn-sm"
                          type="button"
                          onClick={() => handleDelete(user.idUsuario)}
                        >
                          <FaTrash style={{ fontSize: '15px' }} />
                        </button>
                      </td>
                    </tr>
                  ))
                )}
              </tbody>
            </table>
          </div>
          <div className="d-flex justify-content-between align-items-center mt-3">
            <button className="btn btn-secondary" onClick={() => window.history.back()}>
              Volver
            </button>
            <nav>
              <ul className="pagination">
                {[...Array(totalPages)].map((_, index) => (
                  <li key={index} className={`page-item ${currentPage === index + 1 ? 'active' : ''}`}>
                    <button onClick={() => paginate(index + 1)} className="page-link">
                      {index + 1}
                    </button>
                  </li>
                ))}
              </ul>
            </nav>
          </div>
        </div>
      </div>
    </div>
  );
};

export default GestionarUsuario;

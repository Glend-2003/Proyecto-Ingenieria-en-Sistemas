import React, { useState, useEffect } from 'react';
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.min.css';
import { FaCheck, FaTrash, FaExclamationTriangle } from 'react-icons/fa';
import { toast, ToastContainer } from 'react-toastify'; // Importar toast y ToastContainer
import 'react-toastify/dist/ReactToastify.css';
import Swal from 'sweetalert2';
import Navbar from '../Navbar';

const GestionarUsuario = () => {
  // Estado para manejar los datos de los usuarios
  const [users, setUsers] = useState([]);
  const [search, setSearch] = useState('');
  const [editableUsers, setEditableUsers] = useState(users);


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
      await axios.post('http://localhost:8080/usuario/agregar', usuario);
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
        console.log(idUsuario); // Para verificar el ID antes de hacer la solicitud
        const response = await axios.delete(`http://localhost:8080/usuario/eliminar/${idUsuario}`);
        if (response.status === 200) {
            toast.success('Usuario eliminado con éxito', {
                autoClose: 1500,
                onClose: () => {
                    cargarUsuarios();
                },
            });
        }
        /*await axios.delete(`http://localhost:8080/usuario/eliminar/${idUsuario}`);
        toast.success('Usuario eliminado con éxito', {
            autoClose: 1500,
            onClose: () => {
                cargarUsuarios();
            },
        });*/
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

  // Filtrar los usuarios según la búsqueda
  const filteredUsers = users.filter(user =>
    user.nombreUsuario.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div>
      <Navbar /> {/* Agrega la barra de navegación aquí */}
      <div className="container mt-5">
        
      <h1>Gestión de Usuarios</h1>
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
                <th className="col-lg-1">No.</th>
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
                    <td>{index + 1}</td>
                    <td>
                      <input
                        type="text"
                        className="form-control"
                        value={user.nombreUsuario}
                        onChange={(e) => handleInputChange(e, user.idUsuario, 'nombreUsuario')}
                      />
                    </td>
                    <td>
                      <input
                        type="text"
                        className="form-control"
                        value={user.primerApellido}
                        onChange={(e) => handleInputChange(e, user.idUsuario, 'primerApellido')}
                      />
                    </td>
                    <td>
                      <input
                        type="text"
                        className="form-control"
                        value={user.segundoApellido}
                        onChange={(e) => handleInputChange(e, user.idUsuario, 'segundoApellido')}
                      />
                    </td>
                    <td>
                      <input
                        type="text"
                        className="form-control"
                        value={user.correoUsuario}
                        onChange={(e) => handleInputChange(e, user.idUsuario, 'correoUsuario')}
                      />
                    </td>
                    <td>
                      <button
                        className="btn btn-success btn-sm"
                        style={{ marginLeft: '5px' }}
                        onClick={() => actualizarUsuario(user)}
                      >
                        <FaCheck style={{ fontSize: '15px' }} />
                      </button>
                      <button
                        className="btn btn-danger btn-sm"
                        style={{ marginLeft: '5px' }}
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
        <div className="d-flex justify-content-end mt-3">
          <button className="btn btn-secondary" onClick={() => window.history.back()}>
            Volver
          </button>
        </div>
      </div>
    </div>
    </div>
  );
};

export default GestionarUsuario;

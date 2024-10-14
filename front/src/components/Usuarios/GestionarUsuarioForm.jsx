import React, { useState } from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import { FaCheck, FaTrash, FaExclamationTriangle } from 'react-icons/fa';

const GestionarUsuarioForm = () => {
  const [users, setUsers] = useState([
    {
      idUsuario: 1,
      nombreUsuario: 'John',
      primerApellido: 'Doe',
      segundoApellido: 'Smith',
      correoUsuario: 'john.doe@example.com'
    }
  ]);

  const [search, setSearch] = useState('');

  const handleSearchChange = (e) => {
    setSearch(e.target.value);
  };

  const handleDelete = (idUsuario) => {
    const filteredUsers = users.filter(user => user.idUsuario !== idUsuario);
    setUsers(filteredUsers);
  };

  const filteredUsers = users.filter(user =>
    user.nombreUsuario.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div className="container mt-5">
      <h1>Gestión de Usuarios</h1>
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
                    <td>{user.nombreUsuario}</td>
                    <td>{user.primerApellido}</td>
                    <td>{user.segundoApellido}</td>
                    <td>{user.correoUsuario}</td>
                    <td>
                      <button className="btn btn-success btn-sm" style={{ marginLeft: '5px' }}>
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
        {/* Botón para volver */}
        <div className="d-flex justify-content-end mt-3">
          <button className="btn btn-secondary" onClick={() => window.history.back()}>
            Volver
          </button>
        </div>
      </div>
    </div>
  );
};

export default GestionarUsuarioForm;

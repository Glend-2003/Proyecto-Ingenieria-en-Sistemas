// CategoriaApp.js
import React, { useState, useEffect } from 'react';
import CategoriaForm from './CategoriaForm';
import { toast, ToastContainer } from 'react-toastify'; // Importar toast y ToastContainer
import 'react-toastify/dist/ReactToastify.css'; 
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.min.css';
import '../styles.min.css';
import Swal from 'sweetalert2';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faCheck, faTrash, faExclamationTriangle, faEdit } from '@fortawesome/free-solid-svg-icons';
import Navbar from '../Navbar';
import useAuth from '../../hooks/useAuth';
import { Button, Modal } from 'react-bootstrap';

const CategoriaApp = () => {
  const [categorias, setCategorias] = useState([]);
  const [categoriaEdit, setCategoriaEdit] = useState(null);
  const [showModal, setShowModal] = useState(false);
  const { usuario, handleLogout } = useAuth();
  const [search, setSearch] = useState('');
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 5;

  useEffect(() => {
    cargarCategorias();
  }, []);

  const cargarCategorias = async () => {
    try {
      const response = await axios.get('http://localhost:8080/categoria/');
      setCategorias(response.data);
    } catch (error) {
      console.error('Error al cargar categorías:', error);
      toast.error('Ocurrió un error al cargar las categorías');
    }
  };

  const agregarCategoria = async (categoria) => {
    // Validación de nombre duplicado
    const nombreDuplicado = categorias.some(
      (cat) => cat.nombreCategoria.toLowerCase() === categoria.nombreCategoria.toLowerCase()
    );

    if (nombreDuplicado) {
      toast.error('El nombre de la categoría ya existe. Por favor, elige un nombre diferente.');
      return;
    }

    try {
      await axios.post('http://localhost:8080/categoria/agregar', categoria);
      toast.success('Categoría agregada con éxito', {
        autoClose: 1500,
        onClose: () => {
          cargarCategorias(); 
        }
      });
    } catch (error) {
      console.error('Error al agregar categoría:', error);
      if (error.response) {
        if (error.response.status === 400) {
          toast.error('Error de validación. Verifica los datos ingresados');
        } else if (error.response.status === 409) {
          toast.error('La categoría ya existe');
        } else {
          toast.error('Ocurrió un error al agregar la categoría');
        }
      } else {
        toast.error('Error de red. Por favor, verifica tu conexión');
      }
    }
  };

  const actualizarCategoria = async (categoria) => {
    // Validación de nombre duplicado al actualizar
    const nombreDuplicado = categorias.some(
      (cat) =>
        cat.nombreCategoria.toLowerCase() === categoria.nombreCategoria.toLowerCase() &&
        cat.idCategoria !== categoria.idCategoria
    );
  
    if (nombreDuplicado) {
      toast.error('El nombre de la categoría ya existe. Por favor, elige un nombre diferente.', {
        autoClose: 1500,
        onClose: () => {
          cargarCategorias();
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
        await axios.put('http://localhost:8080/categoria/actualizar', categoria);
        toast.success('Categoría actualizada con éxito', {
          autoClose: 1500,
          onClose: () => {
            cargarCategorias();
          },
        });
      } catch (error) {
        console.error('Error al actualizar categoría:', error);
        toast.error('Ocurrió un error al actualizar la categoría');
      }
    }
  };
  
  const eliminarCategoria = async (id) => {
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
      return; // Si el usuario cancela, no hacer nada
    }
  
    try {
      await axios.delete(`http://localhost:8080/categoria/eliminar/${id}`);
      toast.success('Categoría eliminada con éxito', {
        autoClose: 1500,
        onClose: () => {
          cargarCategorias();
        },
      });
    } catch (error) {
      console.error('Error al eliminar categoría:', error);
      if (error.response) {
        if (error.response.status === 404) {
          toast.error('Categoría no encontrada');
        } else {
          toast.error('Ocurrió un error al eliminar la categoría');
        }
      } else {
        toast.error('Error de red. Por favor, verifica tu conexión');
      }
    }
  };

  const handleSearchChange = (e) => {
    setSearch(e.target.value);
  };

  const filteredCategorias = categorias.filter(categoria =>
    categoria.nombreCategoria.toLowerCase().includes(search.toLowerCase())
  );

  // Paginación
  const totalPages = Math.ceil(filteredCategorias.length / itemsPerPage);
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentCategorias = filteredCategorias.slice(indexOfFirstItem, indexOfLastItem);

  const paginate = (pageNumber) => setCurrentPage(pageNumber);
  
  const handleShowModal = (categoria = null) => {
    setCategoriaEdit(categoria);
    setShowModal(true);
  };
  const handleCloseModal = () => {
    setShowModal(false);
    setCategoriaEdit(null);
  };
  
  return (
    <div>
      <Navbar usuario={usuario} onLogout={handleLogout} />
      <div className="container mt-5">
        <h1>Gestión de Categorías</h1>
        <Button variant="primary" onClick={() => handleShowModal()}>
          Agregar Nueva Categoría
        </Button>
        <Modal show={showModal} onHide={handleCloseModal}>
          <Modal.Header closeButton>
            <Modal.Title>{categoriaEdit ? 'Actualizar Categoría' : 'Agregar Categoría'}</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <CategoriaForm
              onSubmit={(categoria) => {
                if (categoriaEdit) {
                  actualizarCategoria({ ...categoria, idCategoria: categoriaEdit.idCategoria });
                } else {
                  agregarCategoria(categoria);
                }
                handleCloseModal();
              }}
              categoriaEdit={categoriaEdit}
            />
          </Modal.Body>
          <Modal.Footer>
            <Button variant="secondary" onClick={handleCloseModal}>
              Cerrar
            </Button>
          </Modal.Footer>
        </Modal>
        <ToastContainer />
        <div
          className="col-md-10 search-table-col"
          style={{ paddingTop: '0px', paddingRight: '0px', marginRight: '86px', marginTop: '172px', paddingLeft: '1px', marginLeft: '63px' }}
        >
          <div className="form-group pull-right col-lg-4">
            <input
              type="text"
              className="search form-control"
              placeholder="Buscar por nombre"
              value={search}
              onChange={handleSearchChange}
            />
          </div>
          <span className="counter pull-right"></span>
          <div className="table-responsive table table-hover table-bordered results">
            <table className="table table-hover table-bordered">
              <thead className="bill-header cs">
                <tr>
                  <th id="trs-hd-4" className="col-lg-2">Nombre</th>
                  <th id="trs-hd-5" className="col-lg-2">Descripción</th>
                  <th id="trs-hd-6" className="col-lg-1 text-center" style={{ width: '5%' }}>Acción</th>
                </tr>
              </thead>
              <tbody>
                {currentCategorias.length === 0 ? (
                  <tr className="warning no-result">
                    <td colSpan="3">
                      <FontAwesomeIcon icon={faExclamationTriangle} />&nbsp; No Result !!!
                    </td>
                  </tr>
                ) : (
                  currentCategorias.map((categoria) => (
                    <tr key={categoria.idCategoria}>
                      <td>{categoria.nombreCategoria}</td>
                      <td>{categoria.descripcionCategoria}</td>
                      <td className="text-center" style={{ width: '5%' }}>
                        <button
                          className="btn btn-warning btn-sm me-2"
                          type="button"
                          onClick={() => handleShowModal(categoria)}
                        >
                          <FontAwesomeIcon icon={faEdit} style={{ fontSize: '15px' }} />
                        </button>
                        <button
                          className="btn btn-danger btn-sm"
                          type="button"
                          onClick={() => eliminarCategoria(categoria.idCategoria)}
                        >
                          <FontAwesomeIcon icon={faTrash} style={{ fontSize: '15px' }} />
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

export default CategoriaApp;

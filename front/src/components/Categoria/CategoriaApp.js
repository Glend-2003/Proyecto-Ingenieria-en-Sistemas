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
import { faCheck, faTrash, faExclamationTriangle } from '@fortawesome/free-solid-svg-icons';
import Navbar from '../Navbar';



const CategoriaApp = () => {
  const [categorias, setCategorias] = useState([]);
  const [categoriaEdit, setCategoriaEdit] = useState(null);

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
  
  return (
    <Navbar /> {/* Agrega la barra de navegación aquí */}
    <div className="container mt-5">
    <h1>Gestión de Categorías</h1>
    <CategoriaForm onSubmit={agregarCategoria} categoriaEdit={categoriaEdit} />
    <ToastContainer />
    <div className="col-md-10 search-table-col" style={{ paddingTop: '0px', paddingRight: '0px', marginRight: '86px', marginTop: '172px', paddingLeft: '1px', marginLeft: '63px' }}>
      <div className="form-group pull-right col-lg-4">
        <input type="text" className="search form-control" placeholder="Buscar por nombre" />
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
            {categorias.length === 0 ? (
              <tr className="warning no-result">
                <td colSpan="3">
                  <FontAwesomeIcon icon={faExclamationTriangle} />&nbsp; No Result !!!
                </td>
              </tr>
            ) : (
              categorias.map((categoria) => (
                <tr key={categoria.idCategoria}>
                  <td>
                    <input
                      type="text"
                      className="form-control"
                      value={categoria.nombreCategoria}
                      onChange={(e) =>
                        setCategorias((prev) =>
                          prev.map((c) =>
                            c.idCategoria === categoria.idCategoria
                              ? { ...c, nombreCategoria: e.target.value }
                              : c
                          )
                        )
                      }
                    />
                  </td>
                  <td>
                    <input
                      type="text"
                      className="form-control"
                      value={categoria.descripcionCategoria}
                      onChange={(e) =>
                        setCategorias((prev) =>
                          prev.map((c) =>
                            c.idCategoria === categoria.idCategoria
                              ? { ...c, descripcionCategoria: e.target.value }
                              : c
                          )
                        )
                      }
                    />
                  </td>
                  <td className="text-center" style={{ width: '5%' }}>
                    <button
                      className="btn btn-success btn-sm"
                      type="button"
                      onClick={() => actualizarCategoria(categoria)}
                    >
                      <FontAwesomeIcon icon={faCheck} style={{ fontSize: '12px' }} />
                    </button>
                    <button
                      className="btn btn-danger btn-sm"
                      type="button"
                      onClick={() => eliminarCategoria(categoria.idCategoria)}
                    >
                      <FontAwesomeIcon icon={faTrash} style={{ fontSize: '12px' }} />
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

export default CategoriaApp;
// CategoriaApp.js
import React, { useState, useEffect } from "react";
import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import axios from "axios";
import "bootstrap/dist/css/bootstrap.min.css";
import Swal from "sweetalert2";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faExclamationTriangle,
  faEdit,
  faTrash,
} from "@fortawesome/free-solid-svg-icons";
import SideBar from "../SideBar/SideBar";
import useAuth from "../../hooks/useAuth";
import { Button, Modal } from "react-bootstrap";
import "./Categoria.css";
import FooterApp from '../Footer/FooterApp';
import PaginacionApp from "../Paginacion/PaginacionApp";

const CategoriaApp = () => {
  const [categorias, setCategorias] = useState([]);
  const [categoriaEdit, setCategoriaEdit] = useState(null);
  const [showModal, setShowModal] = useState(false);
  const { usuario, handleLogout } = useAuth();
  const [search, setSearch] = useState("");
  const [nombreCategoria, setNombreCategoria] = useState("");
  const [descripcionCategoria, setDescripcionCategoria] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 5;

  useEffect(() => {
    cargarCategorias();
  }, []);

  const cargarCategorias = async () => {
    try {
      const response = await axios.get("http://localhost:8080/categoria/", {
        params: { estadoCategoria: 0 }
      });
      setCategorias(response.data);
    } catch (error) {
      console.error("Error al cargar categorías:", error);
      toast.error("Ocurrió un error al cargar las categorías");
    }
  };

  const validarCamposCategoria = () => {
    if (!nombreCategoria.trim() || !descripcionCategoria.trim()) {
      toast.error(
        "Todos los campos son obligatorios y no pueden estar vacíos o contener solo espacios"
      );
      return false;
    }
    if (descripcionCategoria.length < 8) {
      toast.error("La descripción debe tener al menos 8 caracteres");
      return false;
    }
    return true;
  };

  const agregarCategoria = async () => {
    if (!validarCamposCategoria()) return;

    const nombreDuplicado = categorias.some(
      (cat) =>
        cat.nombreCategoria.toLowerCase() ===
        nombreCategoria.trim().toLowerCase()
    );

    if (nombreDuplicado) {
      toast.error(
        "El nombre de la categoría ya existe. Por favor, elige un nombre diferente."
      );
      return;
    }

    try {
      await axios.post("http://localhost:8080/categoria/agregar", {
        nombreCategoria: nombreCategoria.trim(),
        descripcionCategoria: descripcionCategoria.trim(),
      });
      toast.success("Categoría agregada con éxito");
      cargarCategorias();
      handleCloseModal();
    } catch (error) {
      console.error("Error al agregar categoría:", error);
      toast.error("Ocurrió un error al agregar la categoría");
    }
  };

  const actualizarCategoria = async () => {
    if (!validarCamposCategoria()) return;

    // Verificar si la categoría está activa antes de permitir la actualización
    if (!categoriaEdit.estadoCategoria) {
      toast.error("No se puede actualizar una categoría inactiva");
      return;
    }

    const nombreDuplicado = categorias.some(
      (cat) =>
        cat.nombreCategoria.toLowerCase() ===
        nombreCategoria.trim().toLowerCase() &&
        cat.idCategoria !== categoriaEdit.idCategoria
    );

    if (nombreDuplicado) {
      toast.error(
        "El nombre de la categoría ya existe. Por favor, elige un nombre diferente."
      );
      return;
    }

    const { isConfirmed } = await Swal.fire({
      title: "¿Estás seguro?",
      text: "Esta acción no se puede deshacer.",
      icon: "warning",
      showCancelButton: true,
      confirmButtonText: "Sí, actualizar",
      cancelButtonText: "No, cancelar",
      reverseButtons: true,
    });

    if (isConfirmed) {
      try {
        await axios.put("http://localhost:8080/categoria/actualizar", {
          idCategoria: categoriaEdit.idCategoria,
          nombreCategoria: nombreCategoria.trim(),
          descripcionCategoria: descripcionCategoria.trim(),
        });
        toast.success("Categoría actualizada con éxito");
        cargarCategorias();
        handleCloseModal();
      } catch (error) {
        console.error("Error al actualizar categoría:", error);
        toast.error("Ocurrió un error al actualizar la categoría");
      }
    }
  };
  const showAlertaInactivo = () => {
    Swal.fire({
      title: "Categoria inactiva",
      text: "No puedes editar un registro inactivo.",
      icon: "warning",
      confirmButtonText: "Aceptar",
    });
  }
  const eliminarCategoria = async (id) => {
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
      await axios.delete(`http://localhost:8080/categoria/eliminar/${id}`);
      toast.success("Categoría eliminada con éxito");
      cargarCategorias();
    } catch (error) {
      console.error("Error al eliminar categoría:", error);
      toast.error("Ocurrió un error al eliminar la categoría");
    }
  };

  const activarDesactivarCategoria = async (id) => {
    try {
      await axios.put(`http://localhost:8080/categoria/activar/${id}`);
      toast.success("Cambio realizado con éxito.");
      cargarCategorias();
    } catch (error) {
      console.error("Error al realizar el cambio:", error);
      toast.error("Ocurrió un error al cambiar el estado de la categoria.");
    }
  };

  const handleShowModal = (categoria = null) => {


    if (categoria) {
      setCategoriaEdit(categoria);
      setNombreCategoria(categoria.nombreCategoria);
      setDescripcionCategoria(categoria.descripcionCategoria);
    } else {
      setCategoriaEdit(null);
      setNombreCategoria("");
      setDescripcionCategoria("");
    }
    setShowModal(true);
  };

  const handleCloseModal = () => {
    setShowModal(false);
    setCategoriaEdit(null);
    setNombreCategoria("");
    setDescripcionCategoria("");
  };

  const handleSearchChange = (e) => setSearch(e.target.value);

  const filteredCategorias = categorias.filter((categoria) =>
    categoria.nombreCategoria.toLowerCase().includes(search.toLowerCase())
  );

  const totalPages = Math.ceil(filteredCategorias.length / itemsPerPage);
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentCategorias = filteredCategorias.slice(
    indexOfFirstItem,
    indexOfLastItem
  );

  const handleNextPage = () => {
    if (currentPage < totalPages) setCurrentPage(currentPage + 1);
  };

  const handlePreviousPage = () => {
    if (currentPage > 1) setCurrentPage(currentPage - 1);
  };

  return (
    <div className="content-container">
      <SideBar usuario={usuario} />
      <div className="container mt-5">
        <h1>Gestión de categorías</h1>
        <Button className="custom-button" onClick={() => handleShowModal()}>
          Agregar nueva categoría
        </Button>
        <div className="mb-2"></div>
        <label>Buscar categoría</label>
        <input
          type="text"
          className="form-control my-3"
          placeholder="Buscar categoría por nombre"
          value={search}
          onChange={handleSearchChange}
        />

        <Modal show={showModal} onHide={handleCloseModal}>
          <Modal.Header closeButton>
            <Modal.Title>
              {categoriaEdit ? "Actualizar Categoría" : "Agregar Categoría"}
            </Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <form
              onSubmit={(e) => {
                e.preventDefault();
                categoriaEdit ? actualizarCategoria() : agregarCategoria();
              }}
            >
              <div className="mb-3">
                <label>Nombre de la categoria</label>
                <input
                  className="form-control"
                  type="text"
                  placeholder="Nombre de la Categoría"
                  required
                  value={nombreCategoria}
                  onChange={(e) => setNombreCategoria(e.target.value)}
                />
              </div>
              <div className="mb-3">
                <label>Descripción</label>
                <input
                  className="form-control"
                  type="text"
                  placeholder="Descripción de la Categoría"
                  required
                  value={descripcionCategoria}
                  onChange={(e) => setDescripcionCategoria(e.target.value)}
                />
              </div>
              <Button variant="primary" type="submit">
                {categoriaEdit ? "Actualizar" : "Agregar"}
              </Button>
            </form>
          </Modal.Body>
          <Modal.Footer>
            <Button variant="secondary" onClick={handleCloseModal}>
              Cerrar
            </Button>
          </Modal.Footer>
        </Modal>

        <ToastContainer />

        <div className="table-responsive mt-5">
          <table className="table table-hover table-bordered">
            <thead>
              <tr>
                <th>No</th>
                <th>Nombre</th>
                <th>Descripción</th>
                <th>Estado</th>
                <th>Acción</th>
              </tr>
            </thead>
            <tbody>
              {currentCategorias.length === 0 ? (
                <tr className="warning no-result">
                  <td colSpan="4" className="text-center">
                    <FontAwesomeIcon icon={faExclamationTriangle} /> No hay registros.
                    !!!
                  </td>
                </tr>
              ) : (
                currentCategorias.map((categoria, index) => (
                  <tr key={categoria.idCategoria}>
                    <td>{index + 1 + (currentPage - 1) * itemsPerPage}</td>
                    <td>{categoria.nombreCategoria}</td>
                    <td>{categoria.descripcionCategoria}</td>
                    <td>
                      <button
                        className={`btn btn-sm ${categoria.estadoCategoria
                            ? "btn-success"
                            : "btn-danger"
                          }`}
                        onClick={() => activarDesactivarCategoria(categoria.idCategoria)}
                      >
                        {categoria.estadoCategoria ? "Activo" : "Inactivo"}
                      </button>
                    </td>
                    <td className="text-center">
                      <button
                        className={`btn btn-sm me-2 ${categoria.estadoCategoria ? "btn-warning" : "btn-secondary"
                          }`}
                        type="button"
                        onClick={() => {
                          if (!categoria.estadoCategoria) {
                            showAlertaInactivo();
                          } else {
                            handleShowModal(categoria);
                          }
                        }}
                        title="Editar producto"
                      >
                        <FontAwesomeIcon
                          icon={faEdit}
                          style={{ fontSize: "15px" }}
                        />
                      </button>
                      <button
                        className="btn btn-danger btn-sm"
                        type="button"
                        onClick={() => eliminarCategoria(categoria.idCategoria)}
                      >
                        <FontAwesomeIcon
                          icon={faTrash}
                          style={{ fontSize: "15px" }}
                        />
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
          onNextPage={handleNextPage}
          onPreviousPage={handlePreviousPage}
        />
      </div>
      <FooterApp />
    </div>
  );
};

export default CategoriaApp;
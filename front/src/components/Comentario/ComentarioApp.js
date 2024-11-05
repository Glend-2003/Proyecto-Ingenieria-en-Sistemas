import React, { useState, useEffect } from "react";
import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import axios from "axios";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faExclamationTriangle,
  faEdit,
  faTrash,
} from "@fortawesome/free-solid-svg-icons";
import { Button, Modal } from "react-bootstrap";
import "bootstrap/dist/css/bootstrap.min.css";
import SideBar from "../SideBar/SideBar";
import useAuth from "../../hooks/useAuth";
import FooterApp from '../Footer/FooterApp';
import "./Comentario.css";
import PaginacionApp from "../Paginacion/PaginacionApp";

const ComentarioApp = () => {
  const { usuario } = useAuth();
  const [comentarios, setComentarios] = useState([]);
  const [comentarioEdit, setComentarioEdit] = useState(null);
  const [showModal, setShowModal] = useState(false);
  const [search, setSearch] = useState("");
  const [descripcionComentario, setDescripcionComentario] = useState("");
  const [numCalificacion, setNumCalificacion] = useState("");
  const [verificacion, setVerificacion] = useState("Activo");
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 5;

  useEffect(() => {
    cargarComentarios();
  }, []);
  
  const cargarComentarios = async () => {
    try {
      const response = await axios.get("http://localhost:8080/comentario/admin");
      console.log("Comentarios recibidos del backend:", response.data);
      setComentarios(response.data);
    } catch (error) {
      console.error("Error al cargar comentarios:", error);
      toast.error("Ocurrió un error al cargar los comentarios");
    }
  };

  const validarCamposComentario = () => {
    if (!descripcionComentario.trim() || !numCalificacion) {
      toast.error("Todos los campos son obligatorios y no pueden estar vacíos");
      return false;
    }
    return true;
  };

  const agregarComentario = async () => {
    if (!validarCamposComentario()) return;

    try {
        const fechaComentario = new Date().toISOString();

        // Crea el objeto con los datos del comentario
        const comentarioData = {
            descripcionComentario: descripcionComentario.trim(),
            numCalificacion: numCalificacion,
            idUsuario: usuario.idUsuario,  // Cambia esto para enviar el ID directamente
            fechaComentario: fechaComentario,
            verificacion: verificacion,
        };

        console.log("Datos que se enviarán al backend:", comentarioData);

        // Realiza la solicitud al backend
        await axios.post("http://localhost:8080/comentario/agregar", comentarioData);

        toast.success("Comentario agregado con éxito");
        cargarComentarios();
        handleCloseModal();
    } catch (error) {
        console.error("Error al agregar comentario:", error);
        toast.error("Ocurrió un error al agregar el comentario");
    }
};

  
  const actualizarComentario = async () => {
    if (!validarCamposComentario()) return;

    try {
      await axios.put("http://localhost:8080/comentario/actualizar", {
        idComentario: comentarioEdit.idComentario,
        descripcionComentario: descripcionComentario.trim(),
        numCalificacion,
        verificacion,
      });
      toast.success("Comentario actualizado con éxito");
      cargarComentarios();
      handleCloseModal();
    } catch (error) {
      console.error("Error al actualizar comentario:", error);
      toast.error("Ocurrió un error al actualizar el comentario");
    }
  };

  const eliminarComentario = async (id) => {
    try {
      await axios.delete(`http://localhost:8080/comentario/eliminar/${id}`);
      toast.success("Comentario eliminado con éxito");
      cargarComentarios();
    } catch (error) {
      console.error("Error al eliminar comentario:", error);
      toast.error("Ocurrió un error al eliminar el comentario");
    }
  };

  const handleShowModal = (comentario = null) => {
    if (comentario) {
      setComentarioEdit(comentario);
      setDescripcionComentario(comentario.descripcionComentario);
      setNumCalificacion(comentario.numCalificacion);
      setVerificacion(comentario.verificacion);
    } else {
      setComentarioEdit(null);
      setDescripcionComentario("");
      setNumCalificacion("");
      setVerificacion("Activo");
    }
    setShowModal(true);
  };

  const handleCloseModal = () => {
    setShowModal(false);
    setComentarioEdit(null);
    setDescripcionComentario("");
    setNumCalificacion("");
    setVerificacion("Activo");
  };

  const handleSearchChange = (e) => setSearch(e.target.value);

  const filteredComentarios = comentarios.filter(
    (comentario) =>
      comentario.descripcionComentario &&
      comentario.descripcionComentario.toLowerCase().includes(search.toLowerCase())
  );

  const totalPages = Math.ceil(filteredComentarios.length / itemsPerPage);
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentComentarios = filteredComentarios.slice(
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
        <h1>Gestión de Comentarios</h1>
        <Button className="custom-button" onClick={() => handleShowModal()}>
          Agregar comentario nuevo
        </Button>
        <div className="mb-2"></div>
        <label>Buscar comentario</label>
        <input
          type="text"
          className="form-control my-3"
          placeholder="Buscar comentario"
          value={search}
          onChange={handleSearchChange}
        />

        <Modal show={showModal} onHide={handleCloseModal}>
          <Modal.Header closeButton>
            <Modal.Title>
              {comentarioEdit ? "Actualizar Comentario" : "Agregar Comentario"}
            </Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <form
              onSubmit={(e) => {
                e.preventDefault();
                comentarioEdit ? actualizarComentario() : agregarComentario();
              }}
            >
              <div className="mb-3">
              <label>Escribe tu comentario</label>
                <textarea
                  className="form-control"
                  placeholder="Comentar.."
                  required
                  value={descripcionComentario}
                  onChange={(e) => setDescripcionComentario(e.target.value)}
                />
              </div>
              <div className="mb-3">
              <label>Deja tu calificación</label>
                <input
                  className="form-control"
                  type="number"
                  placeholder="Calificación"
                  required
                  value={numCalificacion}
                  onChange={(e) => setNumCalificacion(e.target.value)}
                />
              </div>
              <Button variant="primary" type="submit">
                {comentarioEdit ? "Actualizar" : "Agregar"}
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
            <thead className="bill-header cs">
              <tr>
                <th>No.</th>
                <th>Usuario</th>
                <th>Comentario</th>
                <th>Calificación</th>
                <th>Fecha</th>
                <th>Estado</th>
                <th>Acción</th>
              </tr>
            </thead>
            <tbody>
                  {currentComentarios.length === 0 ? (
                    <tr className="warning no-result">
                      <td colSpan="7" className="text-center">
                        <FontAwesomeIcon icon={faExclamationTriangle} /> No hay registros.
                      </td>
                    </tr>
                  ) : (
                  currentComentarios.map((comentario, index) => (
                  <tr key={comentario.idComentario}>
                    <td>{index + 1 + (currentPage - 1) * itemsPerPage}</td>
                    <td>{comentario.usuario ? comentario.usuario.nombre : "Sin usuario"}</td>
                    <td>{comentario.descripcionComentario}</td>
                    <td>{comentario.numCalificacion}</td>
                    <td>{comentario.fechaComentario || "Fecha no disponible"}</td>
                    <td>
                      <button
                        className={`btn btn-sm ${
                          comentario.verificacion === "Activo" ? "btn-success" : "btn-danger"
                        }`}
                      >
                        {comentario.verificacion}
                      </button>
                    </td>
                    <td className="text-center">
                      <Button
                        variant="warning"
                        className="btn-sm me-2"
                        onClick={() => handleShowModal(comentario)}
                      >
                        <FontAwesomeIcon icon={faEdit} style={{ fontSize: "15px" }} />
                      </Button>
                      <Button
                        variant="danger"
                        className="btn-sm"
                        onClick={() => eliminarComentario(comentario.idComentario)}
                      >
                        <FontAwesomeIcon icon={faTrash} style={{ fontSize: "15px" }} />
                      </Button>
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

export default ComentarioApp;

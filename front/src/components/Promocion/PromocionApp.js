import React, { useState, useEffect } from "react";
import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import axios from "axios";
import "bootstrap/dist/css/bootstrap.min.css";
import Swal from "sweetalert2";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faEdit, faTrash, faExclamationTriangle } from "@fortawesome/free-solid-svg-icons";
import SideBar from "../SideBar/SideBar";
import useAuth from "../../hooks/useAuth";
import { Button, Modal } from "react-bootstrap";
import FooterApp from '../Footer/FooterApp';
import "./Promocion.css";
import PaginacionApp from "../Paginacion/PaginacionApp";

const PromocionApp = () => {
  const [promociones, setPromociones] = useState([]);
  const [productos, setProductos] = useState([]);
  const [promocionEdit, setPromocionEdit] = useState(null);
  const [showModal, setShowModal] = useState(false);
  const { usuario } = useAuth();
  const [search, setSearch] = useState("");
  const [descripcionPromocion, setDescripcionPromocion] = useState("");
  const [fechaInicioPromocion, setFechaInicioPromocion] = useState("");
  const [fechaFinPromocion, setFechaFinPromocion] = useState("");
  const [montoPromocion, setMontoPromocion] = useState("");
  const [idProducto, setIdProducto] = useState("");
  const [estadoPromocion, setEstadoPromocion] = useState(1);
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 5;

  useEffect(() => {
    cargarPromociones();
    cargarProductos();
  }, []);

  const cargarPromociones = async () => {
    try {
      const response = await axios.get("http://localhost:8080/promocion/");
      console.log("Promociones recibidas del backend:", response.data);
      setPromociones(response.data);
    } catch (error) {
      console.error("Error al cargar promociones:", error);
      toast.error("Ocurrió un error al cargar las promociones");
    }
  };

  const cargarProductos = async () => {
    try {
      const response = await axios.get("http://localhost:8080/producto/");
      setProductos(response.data);
    } catch (error) {
      console.error("Error al cargar productos:", error);
      toast.error("Ocurrió un error al cargar los productos");
    }
  };

  const validarCamposPromocion = () => {
    if (!fechaInicioPromocion || isNaN(Date.parse(fechaInicioPromocion))) {
      toast.error("La fecha de inicio es inválida o está vacía");
      return false;
    }
    if (!fechaFinPromocion || isNaN(Date.parse(fechaFinPromocion))) {
      toast.error("La fecha de fin es inválida o está vacía");
      return false;
    }
    if (!montoPromocion || !/^\d+(\.\d+)?$/.test(montoPromocion)) {
      toast.error("El monto de la promoción debe ser un número válido");
      return false;
    }
    if (!idProducto || isNaN(Number(idProducto)) || Number(idProducto) <= 0) {
      toast.error("Debe seleccionar un producto válido");
      return false;
    }
    return true;
  };

  const agregarPromocion = async () => {
    if (!validarCamposPromocion()) return;


    try {
      const promocionData = {
        descripcionPromocion: descripcionPromocion.trim(),
        fechaInicioPromocion: fechaInicioPromocion.trim(),
        fechaFinPromocion: fechaFinPromocion.trim(),
        montoPromocion,
        producto: {
          idProducto,
        },
      };


      console.log("Datos enviados al backend:", promocionData);

      await axios.post("http://localhost:8080/promocion/agregarPromocion", promocionData);
      toast.success("Producto agregado con éxito");
      cargarPromociones();
      handleCloseModal();
    } catch (error) {
      console.error("Error al agregar promoción:", error.response?.data || error.message);
      toast.error("Ocurrió un error al agregar la promoción");
    }
  };


  const actualizarPromocion = async () => {
    if (!validarCamposPromocion()) return;

    const promocionData = {
      idPromocion: promocionEdit.idPromocion,
      descripcionPromocion: descripcionPromocion.trim(),
      fechaInicioPromocion: fechaInicioPromocion.trim(),
      fechaFinPromocion: fechaFinPromocion.trim(),
      montoPromocion,
      producto: {
        idProducto,
      },
    };

    try {
      console.log("Datos enviados al backend:", promocionData);
      await axios.put("http://localhost:8080/promocion/actualizar", promocionData);
      toast.success("Promoción actualizada con éxito");
      cargarPromociones();
      handleCloseModal();
    } catch (error) {
      console.error("Error al actualizar promoción:", error);
      toast.error("Ocurrió un error al actualizar la promoción");
    }
  };

  const eliminarPromocion = async (id) => {
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
      await axios.delete(`http://localhost:8080/promocion/eliminar/${id}`);

      toast.success("Promoción eliminada con éxito");
      cargarPromociones();
    } catch (error) {
      console.error("Error al eliminar promoción:", error);
      toast.error("Ocurrió un error al eliminar la promoción");
    }
  };

  const handleShowModal = (promocion = null) => {
    if (promocion) {
      setPromocionEdit(promocion);
      setDescripcionPromocion(promocion.descripcionPromocion);
      setFechaInicioPromocion(new Date(promocion.fechaInicioPromocion)); // Asegúrate de convertir a Date
      setFechaFinPromocion(new Date(promocion.fechaFinPromocion)); // Asegúrate de convertir a Date
      setMontoPromocion(promocion.montoPromocion);

      setIdProducto(promocion.producto?.idProducto || "");

    } else {
      setPromocionEdit(null);
      setDescripcionPromocion("");
      setFechaInicioPromocion("");
      setFechaFinPromocion("");
      setMontoPromocion("");

      setIdProducto("");
    }
    setShowModal(true);
  };

  const handleCloseModal = () => {
    setShowModal(false);
    setPromocionEdit(null);
    setDescripcionPromocion("");
    setFechaInicioPromocion("");
    setFechaFinPromocion("");
    setMontoPromocion("");

    setIdProducto("");
  };

  const handleSearchChange = (e) => setSearch(e.target.value);

  const filteredPromociones = promociones.filter((promocion) =>
    promocion.descripcionPromocion.toLowerCase().includes(search.toLowerCase())
  );

  const totalPages = Math.ceil(filteredPromociones.length / itemsPerPage);
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentPromociones = filteredPromociones.slice(indexOfFirstItem, indexOfLastItem);

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
        <h1>Gestión de promociones</h1>
        <Button className="custom-button" onClick={() => handleShowModal()}>
          Agregar promoción nueva
        </Button>
        <div className="mb-2"></div>
        <label>Buscar promoción</label>
        <input
          type="text"
          className="form-control my-3"
          placeholder="Buscar promoción por descripción"
          value={search}
          onChange={handleSearchChange}
        />

        <Modal show={showModal} onHide={handleCloseModal}>
          <Modal.Header closeButton>
            <Modal.Title>
              {promocionEdit ? "Actualizar Promoción" : "Agregar Promoción"}
            </Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <form
              onSubmit={(e) => {
                e.preventDefault();
                promocionEdit ? actualizarPromocion() : agregarPromocion();
              }}
            >
              <div className="mb-3">
                <label>Descripción de la promoción</label>
                <input
                  className="form-control"
                  type="text"
                  placeholder="Descripción de la promoción"
                  required
                  value={descripcionPromocion}
                  onChange={(e) => setDescripcionPromocion(e.target.value)}
                />
              </div>
              <div className="mb-3">
                <label>Fecha de inicio</label>
                <input
                  className="form-control"
                  type="date"
                  required
                  value={fechaInicioPromocion}
                  onChange={(e) => setFechaInicioPromocion(e.target.value)}
                />
              </div>
              <div className="mb-3">
                <label>Fecha de fin</label>
                <input
                  className="form-control"
                  type="date"
                  required
                  value={fechaFinPromocion}
                  onChange={(e) => setFechaFinPromocion(e.target.value)}
                />
              </div>
              <div className="mb-3">
                <label>Monto de la promoción</label>
                <input
                  className="form-control"
                  type="number"
                  required
                  value={montoPromocion}
                  onChange={(e) => setMontoPromocion(e.target.value)}
                />
              </div>
              <div className="mb-3">
                <label>Producto relacionado</label>
                <select
                  className="form-control"
                  value={idProducto}
                  onChange={(e) => setIdProducto(e.target.value)}
                  required
                >
                  <option value="">Seleccione un producto</option>
                  {productos.map((producto) => (
                    <option key={producto.idProducto} value={producto.idProducto}>
                      {producto.nombreProducto}
                    </option>
                  ))}
                </select>

              </div>

              <div className="modal-footer">
                <Button variant="secondary" onClick={handleCloseModal}>
                  Cerrar
                </Button>
                <Button type="submit" variant="primary">
                  {promocionEdit ? "Actualizar" : "Agregar"}
                </Button>
              </div>
            </form>
          </Modal.Body>
        </Modal>

        <table className="table">
          <thead>
            <tr>
              <th>Descripción</th>
              <th>Producto</th>
              <th>Fecha Inicio</th>
              <th>Fecha Fin</th>
              <th>Monto</th>

              <th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            {currentPromociones.map((promocion, index) => (
              <tr key={promocion.idPromocion}>

                <td>{promocion.descripcionPromocion}</td>
                <td>{promocion.nombreProducto || "Sin producto"}</td>
                <td>{new Date(promocion.fechaInicioPromocion).toLocaleDateString()}</td>
                <td>{new Date(promocion.fechaFinPromocion).toLocaleDateString()}</td>
                <td>{promocion.montoPromocion}</td>
                <td>
                  <button
                    className="btn btn-warning btn-sm mx-1"
                    onClick={() => handleShowModal(promocion)}
                  >
                    <FontAwesomeIcon icon={faEdit} />
                  </button>
                  <button
                    className="btn btn-danger btn-sm"
                    onClick={() => eliminarPromocion(promocion.idPromocion)}
                  >
                    <FontAwesomeIcon icon={faTrash} />
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>

        {filteredPromociones.length > itemsPerPage && (
          <PaginacionApp
            currentPage={currentPage}
            totalPages={totalPages}
            onPageChange={setCurrentPage}
            onNextPage={handleNextPage}
            onPreviousPage={handlePreviousPage}
          />
        )}
      </div>
      <ToastContainer />
      <FooterApp />
    </div>
  );
};

export default PromocionApp; 
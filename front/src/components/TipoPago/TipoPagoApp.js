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
import FooterApp from "../Footer/FooterApp";
import "./TipoPago.css";
import PaginacionApp from "../Paginacion/PaginacionApp";

const TipoPagoApp = () => {
  const [tipoPagos, setTipoPagos] = useState([]);
  const [tipoPagoEdit, setTipoPagoEdit] = useState(null);
  const [showModal, setShowModal] = useState(false);
  const { usuario } = useAuth();
  const [search, setSearch] = useState("");
  const [descripcionTipoPago, setDescripcionTipoPago] = useState("");
  const [estadoTipoPago, setEstadoTipoPago] = useState(1);
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 5;

  useEffect(() => {
    cargarTipoPago();
  }, []);

  const cargarTipoPago = async () => {
    try {
      const response = await axios.get("http://localhost:8080/tipopago/");
      setTipoPagos(response.data);
    } catch (error) {
      console.error("Error al cargar tipos de pago:", error);
      toast.error("Ocurrió un error al cargar los tipos de pago");
    }
  };

  const validarCamposTipoPago = () => {
    if (!descripcionTipoPago.trim()) {
      toast.error("Debe ingresar una descripción");
      return false;
    }
    return true;
  };

  const agregarTipoPago = async () => {
    if (!validarCamposTipoPago()) return;

    const tipoPagoDuplicado = tipoPagos.some(
      (tipoPago) =>
        tipoPago.descripcionTipoPago.toLowerCase() ===
        descripcionTipoPago.trim().toLowerCase()
    );

    if (tipoPagoDuplicado) {
      toast.error("El nombre del tipo de pago ya existe. Por favor, elige un nombre diferente.");
      return;
    }

    try {
      const tipoPagoData = {
        descripcionTipoPago: descripcionTipoPago.trim(),
        estadoTipoPago: 1,
      };

      await axios.post("http://localhost:8080/tipopago/agregar", tipoPagoData);
      toast.success("Tipo de pago agregado con éxito");
      cargarTipoPago();
      handleCloseModal();
    } catch (error) {
      console.error("Error al agregar tipo de pago:", error);
      toast.error("Ocurrió un error al agregar el tipo de pago");
    }
  };

  const actualizarTipoPago = async () => {
    if (!validarCamposTipoPago()) return;

    const tipoPagoDuplicado = tipoPagos.some(
      (tipoPago) =>
        tipoPago.descripcionTipoPago.toLowerCase() ===
        descripcionTipoPago.trim().toLowerCase()
    );

    if (tipoPagoDuplicado) {
      toast.error("El nombre del tipo de pago ya existe. Por favor, elige un nombre diferente.");
      return;
    }
      const tipoPagoData = {
        idTipoPago: tipoPagoEdit.idTipoPago,
        descripcionTipoPago: descripcionTipoPago.trim(),
        estadoTipoPago: 1,
      };

    try {
      console.log("Datos enviados al backend:", tipoPagoData);
      await axios.put("http://localhost:8080/tipopago/actualizar", tipoPagoData);
      toast.success("Tipo pago actualizado con éxito");
      cargarTipoPago();
      handleCloseModal();
    } catch (error) {
      console.error("Error al actualizar tipo pago:", error);
      toast.error("Ocurrió un error al actualizar el tipo pago");
    }
  
  };

  const eliminarTipoPago = async (id) => {
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
      await axios.delete(`http://localhost:8080/tipopago/eliminar/${id}`);

      toast.success("Tipo pago eliminado con éxito");
      cargarTipoPago();
    } catch (error) {
      console.error("Error al eliminar el tipo pago:", error);
      toast.error("Ocurrió un error al eliminar el tipo pago");
    }
  };

  const activarDesactivarTipoPago = async (id) => {
    try {
      await axios.put(`http://localhost:8080/tipopago/activar/${id}`);
      toast.success("Cambio realizado con éxito.");
      cargarTipoPago();
    } catch (error) {
      console.error("Error al realizar el cambio:", error);
      toast.error("Ocurrió un error al cambiar el estado del tipo pago.");
    }
  };

  const handleShowModal = (tipoPago = null) => {
    if (tipoPago) {
      setTipoPagoEdit(tipoPago);
      setDescripcionTipoPago(tipoPago.descripcionTipoPago);

    } else {
      setTipoPagoEdit(null);
      setDescripcionTipoPago("");
    
    }
    setShowModal(true);
  };

  const handleCloseModal = () => {
    setShowModal(false);
    setTipoPagoEdit(null);
    setDescripcionTipoPago("");
  
  };

  const handleSearchChange = (e) => setSearch(e.target.value);

  const filteredTIpoPagos = tipoPagos.filter((tipoPago) =>
    tipoPago.descripcionTipoPago.toLowerCase().includes(search.toLowerCase())
  );

  const totalPages = Math.ceil(filteredTIpoPagos.length / itemsPerPage);
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentTipoPagos = filteredTIpoPagos.slice(indexOfFirstItem, indexOfLastItem);

  const handleNextPage = () => {
    if (currentPage < totalPages) setCurrentPage(currentPage + 1);
  };

  const handlePreviousPage = () => {
    if (currentPage > 1) setCurrentPage(currentPage - 1);
  };


  return (
    <div className="content-tipoPago">
      <SideBar usuario={usuario} />
      <div className="container mt-5">
        <h1>Gestión tipo de pagos</h1>
        <Button className="custom-button" onClick={() => handleShowModal()}>
          Agregar nuevo tipo pago
        </Button>
        <div className="mb-2"></div>
        <label>Buscar tipo pago</label>
        <input
          type="text"
          className="form-control my-3"
          placeholder="Buscar tipo pago por descripción"
          value={search}
          onChange={handleSearchChange}
        />

        <Modal show={showModal} onHide={handleCloseModal}>
          <Modal.Header closeButton>
            <Modal.Title>
              {tipoPagoEdit ? "Actualizar Tipo Pago" : "Agregar Tipo Pago"}
            </Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <form
              onSubmit={(e) => {
                e.preventDefault();
                tipoPagoEdit ? actualizarTipoPago() : agregarTipoPago();
              }}
            >
              <div className="mb-3">
                <label>Nombre del tipo pago</label>
                <input
                  className="form-control"
                  type="text"
                  placeholder="Nombre del tipo de pago"
                  required
                  value={descripcionTipoPago}
                  onChange={(e) => setDescripcionTipoPago(e.target.value)}
                />
              </div>

              <div className="modal-footer">
                <Button variant="secondary" onClick={handleCloseModal}>
                  Cerrar
                </Button>
                <Button type="submit" variant="primary">
                  {tipoPagoEdit ? "Actualizar" : "Agregar"}
                </Button>
                
              </div>
            </form>
          </Modal.Body>
        </Modal>

        <table className="table">
          <thead>
            <tr>
              <th>Tipo de pago</th>
              <th>Estado</th>

              <th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            {currentTipoPagos.map((tipoPago, index) => (
              <tr key={tipoPago.idTipoPago}>

                <td>{tipoPago.descripcionTipoPago}</td>
                <td>
                      <button
                        className={`btn btn-sm ${
                          tipoPago.estadoTipoPago ? "btn-success" : "btn-danger"
                        }`}
                        onClick={() => activarDesactivarTipoPago(tipoPago.idTipoPago)}
                      >
                        {tipoPago.estadoTipoPago ? "Activo" : "Inactivo"}
                      </button>
                    </td>
                <td>
                  <button
                    className="btn btn-warning btn-sm mx-1"
                    onClick={() => handleShowModal(tipoPago)}
                  >
                    <FontAwesomeIcon icon={faEdit} />
                  </button>
                  <button
                    className="btn btn-danger btn-sm"
                    onClick={() => eliminarTipoPago(tipoPago.idTipoPago)}
                  >
                    <FontAwesomeIcon icon={faTrash} />
                  </button>

                  
                </td>
              </tr>
            ))}
          </tbody>
        </table>

        {filteredTIpoPagos.length > itemsPerPage && (
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

export default TipoPagoApp;

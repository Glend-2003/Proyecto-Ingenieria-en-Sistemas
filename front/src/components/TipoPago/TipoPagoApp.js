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
  const [estadoTipoPago, setEstadoTipoPago] = useState("");
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
        estadoTipoPago: estadoTipoPago.trim(),
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

  const handleCloseModal = () => {
    setShowModal(false);
    setDescripcionTipoPago("");
    setEstadoTipoPago("");
  };

  return (
    <div>
      <SideBar />
      <div className="container mt-4">
        <h2>Gestión de Tipos de Pago</h2>
        <Button onClick={() => setShowModal(true)}>Agregar Tipo de Pago</Button>
        <Modal show={showModal} onHide={handleCloseModal}>
          <Modal.Header closeButton>
            <Modal.Title>Agregar Tipo de Pago</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <input
              type="text"
              placeholder="Descripción"
              className="form-control"
              value={descripcionTipoPago}
              onChange={(e) => setDescripcionTipoPago(e.target.value)}
            />
            <input
              type="text"
              placeholder="Estado"
              className="form-control mt-2"
              value={estadoTipoPago}
              onChange={(e) => setEstadoTipoPago(e.target.value)}
            />
          </Modal.Body>
          <Modal.Footer>
            <Button variant="secondary" onClick={handleCloseModal}>
              Cancelar
            </Button>
            <Button variant="primary" onClick={agregarTipoPago}>
              Guardar
            </Button>
          </Modal.Footer>
        </Modal>
      </div>
      <FooterApp />
      <ToastContainer />
    </div>
  );
};

export default TipoPagoApp;

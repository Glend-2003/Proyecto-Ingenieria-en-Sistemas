import React, { useState, useEffect } from "react";
import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import axios from "axios";
import "bootstrap/dist/css/bootstrap.min.css";
import Swal from "sweetalert2";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faEdit, faTrash, faExclamationTriangle, faEnvelope } from "@fortawesome/free-solid-svg-icons";
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
      const response = await axios.get("http://localhost:8080/producto/", {
        params: { estadoProducto: 1 }
      });
      setProductos(response.data);
    } catch (error) {
      console.error("Error al cargar productos:", error);
      toast.error("Ocurrió un error al cargar los productos");
    }
  };

  const validarCamposPromocion = () => {
    const hoy = new Date();
    hoy.setHours(0, 0, 0, 0); // Eliminar la hora para comparar solo fechas
    
    const fechaInicio = new Date(fechaInicioPromocion);
    const fechaFin = new Date(fechaFinPromocion);
  

  
    if (!fechaFinPromocion || isNaN(fechaFin)) {
      toast.error("La fecha de fin es inválida o está vacía");
      return false;
    }
  
    if (fechaInicio < hoy-2) {
      toast.error("La fecha de inicio no puede ser menor a la actual");
      return false;
    }
  
    if (fechaFin < fechaInicio) {
      toast.error("La fecha de fin debe ser mayor o igual a la fecha de inicio");
      return false;
    }
  
    if (!montoPromocion || isNaN(montoPromocion) || Number(montoPromocion) <= 0) {
      toast.error("El monto de la promoción debe ser un número mayor a cero");
      return false;
    }
  
    if (!idProducto || isNaN(Number(idProducto)) || Number(idProducto) <= 0 || !Number.isInteger(Number(idProducto))) {
      toast.error("Debe seleccionar un producto válido");
      return false;
    }
  
    return true;
  };
  
  

  const agregarPromocion = async () => {
    if (!validarCamposPromocion()) {

      return;
    }
  
    const promocionData = {
      descripcionPromocion: descripcionPromocion.trim(),
      fechaInicioPromocion: fechaInicioPromocion.trim(),
      fechaFinPromocion: fechaFinPromocion.trim(),
      montoPromocion,
      producto: {
        idProducto,
      },
    };
  
    console.log(" Datos enviados al backend:", promocionData);
    
    try {
      await axios.post("http://localhost:8080/promocion/agregarPromocion", promocionData);
      toast.success("Promoción agregada con éxito");
      
    } catch (error) {
      console.error("Error al agregar promoción:", error.response?.data || error.message);
      toast.error(error.response?.data?.mensaje || "Ocurrió un error al agregar la promoción");
    }

    cargarPromociones();
      handleCloseModal();
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

  const enviarMensaje = async (promocion) => {
    const { isConfirmed } = await Swal.fire({
        title: "¿Estás seguro?",
        text: "No podrás revertir esto.",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Sí, enviar",
        cancelButtonText: "No, cancelar",
        reverseButtons: true,
    });

    if (!isConfirmed) return;

    console.log("Datos enviados al backend:", promocion);

    // Mostrar un indicador de carga mientras se envía el correo
    const loadingToast = toast.loading("Enviando mensaje...");

    try {
        // Enviar la solicitud de backend
        const response = await axios.post(`http://localhost:8080/promocion/mensaje?nombreProducto=${encodeURIComponent(promocion.nombreProducto)}`, promocion);

        // Verificar la respuesta del servidor
        if (response.status === 200) {
            // Cerrar el indicador de carga y mostrar el mensaje de éxito
            toast.update(loadingToast, {
                render: "Mensaje enviado con éxito",
                type: "success",
                isLoading: false,
                autoClose: 5000,
            });
            cargarPromociones();  // Recargar las promociones después de enviar el correo
        } else {
            // En caso de error, mostrar mensaje de error
            toast.update(loadingToast, {
                render: "Ocurrió un error al enviar el mensaje",
                type: "error",
                isLoading: false,
                autoClose: 5000,
            });
        }
    } catch (error) {
        console.error("Error al enviar mensaje:", error);
        toast.update(loadingToast, {
            render: error.response?.data?.error || "Ocurrió un error al enviar el mensaje",
            type: "error",
            isLoading: false,
            autoClose: 5000,
        });
    }
};

const activarDesactivarPromocion = async (id) => {
  try {
    await axios.put(`http://localhost:8080/promocion/activar/${id}`);
    toast.success("Cambio realizado con éxito.");
    cargarPromociones();
  } catch (error) {
    console.error("Error al realizar el cambio:", error);
    toast.error("Ocurrió un error al cambiar el estado de la promocion.");
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
              <th>Estado</th>
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
                    className={`btn btn-sm ${
                      promocion.estadoPromocion ? "btn-success" : "btn-danger"
                    }`}
                    onClick={() => activarDesactivarPromocion(promocion.idPromocion)}
                  >
                    {promocion.estadoPromocion ? "Activo" : "Inactivo"}
                  </button>
                </td>
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
                  <button
                    className="btn btn-primary btn-sm mx-1"
                    onClick={() => enviarMensaje(promocion)}
                  >
                    <FontAwesomeIcon icon={faEnvelope} />
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
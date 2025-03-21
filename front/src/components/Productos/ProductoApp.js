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
import "./Producto.css";
import PaginacionApp from "../Paginacion/PaginacionApp";

const ProductoApp = () => {
  const [productos, setProductos] = useState([]);
  const [categorias, setCategorias] = useState([]);
  const [productoEdit, setProductoEdit] = useState(null);
  const [showModal, setShowModal] = useState(false);
  const { usuario } = useAuth();
  const [search, setSearch] = useState("");
  const [nombreProducto, setNombreProducto] = useState("");
  const [montoPrecioProducto, setMontoPrecioProducto] = useState("");
  const [descripcionProducto, setDescripcionProducto] = useState("");
  const [cantidadProducto, setCantidadProducto] = useState("");
  const [tipoPesoProducto, setTipoPesoProducto] = useState("");
  const [codigoProducto, setCodigoProducto] = useState("");
  const [stockProducto, setStockProducto] = useState("");
  const [idCategoria, setIdCategoria] = useState("");
  const [estadoProducto, setEstadoProducto] = useState(1);
  const [currentPage, setCurrentPage] = useState(1);
  const [imgProductoFile, setImgProductoFile] = useState(null);
  const itemsPerPage = 5;

  useEffect(() => {
    cargarProductos();
    cargarCategorias();
  }, []);

  const cargarProductos = async () => {
    try {
      const response = await axios.get("http://localhost:8080/producto/", {
        params: { estadoProducto: 0 }
      });
      console.log(response.data);
      const productos = response.data;

      // Iterar sobre cada producto y obtener el nombre de la categoría
      for (let producto of productos) {
        if (producto.categoria && producto.categoria.idCategoria) {
          producto.nombreCategoria = producto.categoria.nombreCategoria;
        } else {
          producto.nombreCategoria = "Sin categoría";
        }
      }

      setProductos(productos);
    } catch (error) {
      console.error("Error al cargar productos:", error);
      toast.error("Ocurrió un error al cargar los productos");
    }
  };

  const cargarCategorias = async () => {
    try {
      const response = await axios.get("http://localhost:8080/categoria/", {
        params: { estadoCategoria: 1 }
      });
      setCategorias(response.data);
    } catch (error) {
      console.error("Error al cargar categorías:", error);
      toast.error("Ocurrió un error al cargar las categorías");
    }
  };

  const validarCamposProducto = () => {
    if (
      !nombreProducto.trim() ||
      !descripcionProducto.trim() ||
      !cantidadProducto < 0 ||
      !tipoPesoProducto.trim() ||
      !codigoProducto.trim() ||
      !stockProducto < 0 ||
      !montoPrecioProducto ||
      !idCategoria
    ) {
      toast.error("Todos los campos son obligatorios y no pueden estar vacíos");
      return false;
    }

    if (imgProductoFile && !["image/jpeg", "image/png"].includes(imgProductoFile.type)) {
      toast.error("Solo se permiten imágenes en formato JPG o PNG");
      return false;
    }

    return true;
  };

  const agregarProducto = async () => {
    if (!validarCamposProducto()) return;

    const formData = new FormData();
    formData.append("nombreProducto", nombreProducto.trim());
    formData.append("montoPrecioProducto", montoPrecioProducto);
    formData.append("descripcionProducto", descripcionProducto.trim());
    formData.append("cantidadProducto", cantidadProducto);
    formData.append("tipoPesoProducto", tipoPesoProducto.trim());
    formData.append("codigoProducto", codigoProducto.trim());
    formData.append("stockProducto", stockProducto);
    formData.append("idCategoria", idCategoria);
    formData.append("estadoProducto", estadoProducto);


    if (imgProductoFile) {
      formData.append("file", imgProductoFile);

      console.log("Datos enviados al backend:", formData);
      try {
        await axios.post("http://localhost:8080/producto/agregarConImagen", formData, {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        });
        toast.success("Producto agregado con éxito");
      } catch (error) {
        console.error("Error al agregar producto con imagen:", error);
        toast.error("Ocurrió un error al agregar el producto");
        return;
      }
    } else {
      try {
        const productoData = {
          nombreProducto: nombreProducto.trim(),
          montoPrecioProducto,
          descripcionProducto: descripcionProducto.trim(),
          cantidadProducto,
          tipoPesoProducto: tipoPesoProducto.trim(),
          codigoProducto: codigoProducto.trim(),
          stockProducto,
          idCategoria,
          estadoProducto,
        };
        await axios.post("http://localhost:8080/producto/agregarProducto", productoData);
        toast.success("Producto agregado con éxito");
      } catch (error) {
        console.error("Error al agregar producto sin imagen:", error);
        toast.error("Ocurrió un error al agregar el producto");
        return;
      }
    }

    cargarProductos();
    handleCloseModal();
  };

  const actualizarProducto = async () => {
    if (!validarCamposProducto()) return;

    const formData = new FormData();
    formData.append("idProducto", productoEdit.idProducto);
    formData.append("nombreProducto", nombreProducto.trim());
    formData.append("montoPrecioProducto", montoPrecioProducto);
    formData.append("descripcionProducto", descripcionProducto.trim());
    formData.append("cantidadProducto", cantidadProducto);
    formData.append("tipoPesoProducto", tipoPesoProducto.trim());
    formData.append("codigoProducto", codigoProducto.trim());
    formData.append("stockProducto", stockProducto);
    formData.append("idCategoria", idCategoria);
    formData.append("estadoProducto", estadoProducto ? 1 : 0);

    if (imgProductoFile) {
        formData.append("file", imgProductoFile); // Cambiado de "file" a "imgProducto"
    }

    console.log("Datos enviados al backend:", formData);
    try {
        await axios.put("http://localhost:8080/producto/actualizar", formData, {
            headers: { "Content-Type": "multipart/form-data" },
        });
        toast.success("Producto actualizado con éxito");
        cargarProductos();
        handleCloseModal();
    } catch (error) {
        console.error("Error al actualizar producto:", error);
        toast.error("Ocurrió un error al actualizar el producto");
    }
};


  const eliminarProducto = async (id) => {
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
      await axios.delete(`http://localhost:8080/producto/eliminar/${id}`);
      toast.success("Producto eliminado con éxito");
      cargarProductos();
    } catch (error) {
      console.error("Error al eliminar producto:", error);
      toast.error("Ocurrió un error al eliminar el producto");
    }
  };

  const activarDesactivarProductos = async (id) => {
    try {
      await axios.put(`http://localhost:8080/producto/activar/${id}`);
      toast.success("Cambio realizado con éxito.");
      cargarProductos();
    } catch (error) {
      console.error("Error al realizar el cambio:", error);
      toast.error("Ocurrió un error al cambiar el estado del producto.");
    }
  };

  const handleShowModal = (producto = null) => {
    if (producto) {
      setProductoEdit(producto);
      setNombreProducto(producto.nombreProducto);
      setMontoPrecioProducto(producto.montoPrecioProducto);
      setDescripcionProducto(producto.descripcionProducto);
      setCantidadProducto(producto.cantidadProducto);
      setTipoPesoProducto(producto.tipoPesoProducto);
      setCodigoProducto(producto.codigoProducto);
      setStockProducto(producto.stockProducto);
      setIdCategoria(producto.categoria?.idCategoria || "");
      setEstadoProducto(producto.estadoProducto);
      setImgProductoFile(null);
    } else {
      setProductoEdit(null);
      setNombreProducto("");
      setMontoPrecioProducto("");
      setDescripcionProducto("");
      setCantidadProducto(0);
      setTipoPesoProducto("");
      setCodigoProducto("");
      setStockProducto(-1);
      setIdCategoria("");
      setEstadoProducto(1);
      setImgProductoFile(null);
    }
    setShowModal(true);
  };

  const handleCloseModal = () => {
    setShowModal(false);
    setProductoEdit(null);
    setNombreProducto("");
    setMontoPrecioProducto("");
    setDescripcionProducto("");
    setCantidadProducto(0);
    setTipoPesoProducto("");
    setCodigoProducto("");
    setStockProducto(-1);
    setIdCategoria("");
    setEstadoProducto(1);
    setImgProductoFile(null);
  };

  const handleFileChange = (e) => {
    setImgProductoFile(e.target.files[0]);
  };

  const handleSearchChange = (e) => setSearch(e.target.value);

  const filteredProductos = productos.filter((producto) =>
    producto.nombreProducto.toLowerCase().includes(search.toLowerCase())
  );

  const totalPages = Math.ceil(filteredProductos.length / itemsPerPage);
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentProductos = filteredProductos.slice(indexOfFirstItem, indexOfLastItem);

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
        <h1>Gestión de productos</h1>
        <Button className="custom-button" onClick={() => handleShowModal()}>
          Agregar producto nuevo
        </Button>
        <div className="mb-2"></div>
        <label>Buscar producto</label>
        <input
          type="text"
          className="form-control my-3"
          placeholder="Buscar producto por nombre"
          value={search}
          onChange={handleSearchChange}
        />

        <Modal show={showModal} onHide={handleCloseModal}>
          <Modal.Header closeButton>
            <Modal.Title>
              {productoEdit ? "Actualizar Producto" : "Agregar Producto"}
            </Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <form
              onSubmit={(e) => {
                e.preventDefault();
                productoEdit ? actualizarProducto() : agregarProducto();
              }}
            >
              <div className="mb-3">
              <label>Nombre del producto</label>
                <input
                  className="form-control"
                  type="text"
                  placeholder="Nombre del producto"
                  required
                  value={nombreProducto}
                  onChange={(e) => setNombreProducto(e.target.value)}
                />
              </div>
              <div className="mb-3">
              <label>Seleccionar una imagen</label>
                <input
                  className="form-control"
                  type="file"
                  accept="image/*"
                  onChange={handleFileChange}
                />
              </div>
              <div className="mb-3">
              <label>Precio</label>
                <input
                  className="form-control"
                  type="number"
                  placeholder="Precio del producto"
                  required
                  value={montoPrecioProducto}
                  onChange={(e) => setMontoPrecioProducto(e.target.value)}
                />
              </div>
              <div className="mb-3">
              <label>Describe el producto</label>
                <textarea
                  className="form-control"
                  placeholder="Descripción del producto"
                  required
                  value={descripcionProducto}
                  onChange={(e) => setDescripcionProducto(e.target.value)}
                />
              </div>
              <div className="mb-3">
              <label>Ingresa el peso o unidades del producto</label>
                <textarea
                  className="form-control"
                  type="number"
                  placeholder="Cantidad del producto"
                  required
                  value={cantidadProducto}
                  onChange={(e) => setCantidadProducto(e.target.value)}
                />
              </div>
              <div className="mb-3">
              <label>Ingresa el tipo de peso</label>
                <textarea
                  className="form-control"
                  placeholder="Kg - Gr - Ud"
                  required
                  value={tipoPesoProducto}
                  onChange={(e) => setTipoPesoProducto(e.target.value)}
                />
              </div>
              <div className="mb-3">
              <label>Ingresa el código del producto</label>
                <textarea
                  className="form-control"
                  placeholder="Código del producto"
                  required
                  value={codigoProducto}
                  onChange={(e) => setCodigoProducto(e.target.value)}
                />
              </div>
              <div className="mb-3">
              <label>Ingresa el stock disponible</label>
                <textarea
                  className="form-control"
                  type="number"
                  placeholder="Stock disponible del producto"
                  required
                  value={stockProducto}
                  onChange={(e) => setStockProducto(e.target.value)}
                />
              </div>
              <div className="mb-3">
              <label>Elegir categoría</label>
                <select
                  className="form-control"
                  required
                  value={idCategoria}
                  onChange={(e) => setIdCategoria(e.target.value)}
                >
                  <option value="">Seleccionar Categoría</option>
                  {categorias.map((categoria) => (
                    <option key={categoria.idCategoria} value={categoria.idCategoria}>
                      {categoria.nombreCategoria}
                    </option>
                  ))}
                </select>
              </div>
              <Button variant="primary" type="submit">
                {productoEdit ? "Actualizar" : "Agregar"}
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
                <th>No.</th>
                <th>Nombre</th>
                <th>Imagen</th>
                <th>Precio</th>
                <th>Descripción</th>
                <th>Cantidad</th>
                <th>Tipo peso</th>
                <th>Codigo</th>
                <th>Stock</th>
                <th>Categoría</th>
                <th>Estado</th>
                <th>Acción</th>
              </tr>
            </thead>
            <tbody>
              {currentProductos.length === 0 ? (
                <tr className="warning no-result">
                  <td colSpan="7" className="text-center">
                    <FontAwesomeIcon icon={faExclamationTriangle} /> No hay productos disponibles
                  </td>
                </tr>
              ) : (
                currentProductos.map((producto, index) => (
                  <tr key={producto.idProducto}>
                    <td>{index + 1 + (currentPage - 1) * itemsPerPage}</td>
                    <td>{producto.nombreProducto}</td>
                    <td>
                      {producto.imgProducto ? (
                        <img
                          src={`http://localhost:8080/producto/images/${producto.imgProducto}`}
                          alt={producto.imgProducto}
                          width="50"
                        />
                      ) : (
                        "No disponible"
                      )}
                    </td>
                    <td>{producto.montoPrecioProducto}</td>
                    <td>{producto.descripcionProducto}</td>
                    <td>{producto.cantidadProducto}</td>
                    <td>{producto.tipoPesoProducto}</td>
                    <td>{producto.codigoProducto}</td>
                    <td>{producto.stockProducto}</td>
                    <td>{producto.nombreCategoria || "Sin categoría"}</td>
                    <td>
                      <button
                        className={`btn btn-sm ${
                          producto.estadoProducto ? "btn-success" : "btn-danger"
                        }`}
                        onClick={() => activarDesactivarProductos(producto.idProducto)}
                      >
                        {producto.estadoProducto ? "Activo" : "Inactivo"}
                      </button>
                    </td>
                    <td className="text-center">
                      <button
                        className="btn btn-warning btn-sm me-2"
                        type="button"
                        onClick={() => handleShowModal(producto)}
                      >
                        <FontAwesomeIcon icon={faEdit} style={{ fontSize: "15px" }} />
                      </button>
                      <button
                        className="btn btn-danger btn-sm"
                        type="button"
                        onClick={() => eliminarProducto(producto.idProducto)}
                      >
                        <FontAwesomeIcon icon={faTrash} style={{ fontSize: "15px" }} />
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

export default ProductoApp;

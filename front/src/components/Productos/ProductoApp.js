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
  const [cantidadProducto, setCantidadProducto] = useState(1);
  const [unidadMedida, setUnidadMedida] = useState("Ud");
  const [codigoProducto, setCodigoProducto] = useState("");
  const [stockProducto, setStockProducto] = useState(0);
  const [idCategoria, setIdCategoria] = useState("");
  const [estadoProducto, setEstadoProducto] = useState(1);
  const [currentPage, setCurrentPage] = useState(1);
  const [imgProductoFile, setImgProductoFile] = useState(null);
  const itemsPerPage = 5;
  
  // Opciones para el combobox de unidad de medida
  const unidadesMedida = ["Ud", "Kg", "Gr", "Lb", "Oz", "Lt", "Ml"];

  const [imgPreview, setImgPreview] = useState(null);

  useEffect(() => {
    cargarProductos();
    cargarCategorias();
  }, []);

  const cargarProductos = async () => {
    try {
      const response = await axios.get("http://localhost:8080/producto/", {
        params: { estadoProducto: 0 }
      });
      const productos = response.data;

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
      cantidadProducto <= 0 ||
      !unidadMedida ||
      !codigoProducto.trim() ||
      stockProducto < 0 ||
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
    formData.append("tipoPesoProducto", unidadMedida);
    formData.append("codigoProducto", codigoProducto.trim());
    formData.append("stockProducto", stockProducto);
    formData.append("idCategoria", idCategoria);
    formData.append("estadoProducto", estadoProducto);


    if (imgProductoFile) {
      formData.append("file", imgProductoFile);
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
          tipoPesoProducto: unidadMedida,
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
    formData.append("tipoPesoProducto", unidadMedida);
    formData.append("codigoProducto", codigoProducto.trim());
    formData.append("stockProducto", stockProducto);
    formData.append("idCategoria", idCategoria);
    formData.append("estadoProducto", estadoProducto ? 1 : 0);

    if (imgProductoFile) {
        formData.append("file", imgProductoFile);
    }

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
      setUnidadMedida(producto.tipoPesoProducto);
      setCodigoProducto(producto.codigoProducto);
      setStockProducto(producto.stockProducto);
      setIdCategoria(producto.categoria?.idCategoria || "");
      setEstadoProducto(producto.estadoProducto);
      setImgProductoFile(null);
      
      // Si el producto tiene una imagen, mostrar la previsualización
      if (producto.imgProducto) {
        setImgPreview(`http://localhost:8080/producto/images/${producto.imgProducto}`);
      } else {
        setImgPreview(null);
      }
    } else {
      setProductoEdit(null);
      setNombreProducto("");
      setMontoPrecioProducto("");
      setDescripcionProducto("");
      setCantidadProducto(1);
      setUnidadMedida("Ud");
      setCodigoProducto("");
      setStockProducto(0);
      setIdCategoria("");
      setEstadoProducto(1);
      setImgProductoFile(null);
      setImgPreview(null);
    }
    setShowModal(true);
  };

  const handleCloseModal = () => {
    setShowModal(false);
    setProductoEdit(null);
    setNombreProducto("");
    setMontoPrecioProducto("");
    setDescripcionProducto("");
    setCantidadProducto(1);
    setUnidadMedida("Ud");
    setCodigoProducto("");
    setStockProducto(0);
    setIdCategoria("");
    setEstadoProducto(1);
    setImgProductoFile(null);
    setImgPreview(null);
  };

  const handleFileChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      setImgProductoFile(file);
      // Crear URL para previsualización
      const previewURL = URL.createObjectURL(file);
      setImgPreview(previewURL);
    } else {
      setImgProductoFile(null);
      setImgPreview(null);
    }
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
        <Button className="custom-button add-product-btn" onClick={() => handleShowModal()}>
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

        <Modal show={showModal} onHide={handleCloseModal} className="producto-modal" size="lg" centered>
          <Modal.Header closeButton className="modal-header">
            <Modal.Title>
              {productoEdit ? "Actualizar Producto" : "Agregar Producto"}
            </Modal.Title>
          </Modal.Header>
          <Modal.Body className="modal-body">
            <form
              onSubmit={(e) => {
                e.preventDefault();
                productoEdit ? actualizarProducto() : agregarProducto();
              }}
            >
              <div className="row">
                <div className="col-md-6">
                  <div className="form-group mb-3">
                    <label htmlFor="nombreProducto">Nombre del producto</label>
                    <input
                      id="nombreProducto"
                      className="form-control"
                      type="text"
                      placeholder="Nombre del producto"
                      required
                      value={nombreProducto}
                      onChange={(e) => setNombreProducto(e.target.value)}
                    />
                  </div>
                  
                  <div className="form-group mb-3">
                    <label htmlFor="precioProducto">Precio</label>
                    <div className="input-group">
                      <span className="input-group-text">₡</span>
                      <input
                        id="precioProducto"
                        className="form-control"
                        type="number"
                        placeholder="Precio del producto"
                        required
                        value={montoPrecioProducto}
                        onChange={(e) => setMontoPrecioProducto(e.target.value)}
                      />
                    </div>
                  </div>
                  
                  <div className="form-group mb-3">
                    <label htmlFor="codigoProducto">Código del producto</label>
                    <input
                      id="codigoProducto"
                      className="form-control"
                      type="text"
                      placeholder="Código del producto"
                      required
                      value={codigoProducto}
                      onChange={(e) => setCodigoProducto(e.target.value)}
                    />
                  </div>
                  
                  <div className="form-group mb-3">
                    <label htmlFor="categoriaProducto">Categoría</label>
                    <select
                      id="categoriaProducto"
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
                </div>
                
                <div className="col-md-6">
                  <div className="form-group mb-3">
                    <label htmlFor="imgProducto">Imagen del producto</label>
                    <input
                      id="imgProducto"
                      className="form-control"
                      type="file"
                      accept="image/*"
                      onChange={handleFileChange}
                    />
                    {imgPreview && (
                      <div className="mt-2 text-center">
                        <img
                          src={imgPreview}
                          alt="Vista previa"
                          className="img-preview"
                          style={{ maxWidth: '100%', maxHeight: '200px', objectFit: 'contain' }}
                        />
                      </div>
                    )}
                  </div>
                  
                  <div className="form-group mb-3">
                    <label htmlFor="descripcionProducto">Descripción</label>
                    <textarea
                      id="descripcionProducto"
                      className="form-control"
                      placeholder="Descripción del producto"
                      required
                      rows="3"
                      value={descripcionProducto}
                      onChange={(e) => setDescripcionProducto(e.target.value)}
                    />
                  </div>
                  
                  <div className="row mb-3">
                    <div className="col-6">
                      <label htmlFor="cantidadProducto">Cantidad</label>
                      <input
                        id="cantidadProducto"
                        type="number"
                        className="form-control"
                        min="1"
                        value={cantidadProducto}
                        onChange={(e) => setCantidadProducto(parseInt(e.target.value) || 1)}
                      />
                    </div>
                    
                    <div className="col-6">
                      <label htmlFor="unidadMedida">Unidad de medida</label>
                      <select
                        id="unidadMedida"
                        className="form-control"
                        value={unidadMedida}
                        onChange={(e) => setUnidadMedida(e.target.value)}
                        required
                      >
                        {unidadesMedida.map((unidad) => (
                          <option key={unidad} value={unidad}>
                            {unidad}
                          </option>
                        ))}
                      </select>
                    </div>
                  </div>
                  
                  <div className="form-group mb-3">
                    <label htmlFor="stockProducto">Stock disponible</label>
                    <input
                      id="stockProducto"
                      type="number"
                      className="form-control"
                      min="0"
                      value={stockProducto}
                      onChange={(e) => setStockProducto(parseInt(e.target.value) || 0)}
                    />
                  </div>
                </div>
              </div>
              
              <div className="d-flex justify-content-end gap-2 mt-4">
                <Button variant="outline-secondary" onClick={handleCloseModal}>
                  Cancelar
                </Button>
                <Button className="btn-submit" type="submit">
                  {productoEdit ? "Actualizar" : "Agregar"}
                </Button>
              </div>
            </form>
          </Modal.Body>
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
                <th>Unidad de medida</th>
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
                  <td colSpan="12" className="text-center">
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
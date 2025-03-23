import React, { useState, useEffect } from "react";
import axios from "axios";
import { Card, Button, Modal, Form } from "react-bootstrap";
import { toast, ToastContainer } from "react-toastify";
import "./ListaProductos.css";
import { useCart } from '../../contexto/ContextoCarrito';

function ListaProductosApp({ categoria }) {
  const { addToCart } = useCart(); 
  const [productos, setProductos] = useState([]);
  const [categorias, setCategorias] = useState([]);
  const [showModal, setShowModal] = useState(false);
  const [selectedProduct, setSelectedProduct] = useState(null);
  const [cantidad, setCantidad] = useState(1);
  const [productosFiltrados, setProductosFiltrados] = useState([]);
  const [loading, setLoading] = useState(true);

  const verDetalles = (producto) => {
    setSelectedProduct(producto);
    setCantidad(1);
    setShowModal(true);
  };

  const handleCloseModal = () => {
    setShowModal(false);
    setSelectedProduct(null);
  };

  const handleAddToCartFromModal = () => {
    if (selectedProduct) {
      const cantidadValida = Math.max(1, Math.min(cantidad, selectedProduct.stockProducto || 10));
      const productoConCantidad = {
        ...selectedProduct,
        cantidad: cantidadValida,
      };
      addToCart(productoConCantidad, cantidadValida); 
      toast.success(
        `${selectedProduct.nombreProducto} agregado al carrito (${cantidadValida} unidad${cantidadValida > 1 ? "es" : ""})`,
      );
      handleCloseModal();
    }
  };
  
  // Obtener todas las categorías para mapear nombres a IDs
  useEffect(() => {
    const fetchCategorias = async () => {
      try {
        const response = await axios.get('http://localhost:8080/categoria/');
        console.log("Categorías obtenidas:", response.data);
        setCategorias(response.data);
      } catch (error) {
        console.error('Error al cargar categorías:', error);
      }
    };

    fetchCategorias();
  }, []);

  // Cargar todos los productos
  useEffect(() => {
    const fetchProductos = async () => {
      try {
        setLoading(true);
        const response = await axios.get('http://localhost:8080/producto/');
        console.log("Productos obtenidos:", response.data);
        setProductos(response.data);
        setLoading(false);
      } catch (error) {
        console.error('Error al cargar productos:', error);
        setLoading(false);
      }
    };

    fetchProductos();
  }, []);

// Filtrar productos cuando cambie la categoría o los productos
useEffect(() => {
  if (productos.length > 0 && categorias.length > 0) {
    // Caso especial para "Productos Varios"
    if (categoria && categoria.toLowerCase() === "varios") {
      console.log("Filtrando productos varios (excluyendo Res, Cerdo y Pollo)");
      
      // Encontrar los IDs de las categorías a excluir
      const categoriasExcluidas = categorias
        .filter(cat => 
          ["res", "cerdo", "pollo"].includes(cat.nombreCategoria.toLowerCase())
        )
        .map(cat => cat.idCategoria);
      
      console.log("Categorías excluidas:", categoriasExcluidas);
      
      // Filtrar productos que NO pertenecen a las categorías excluidas
      const filtrados = productos.filter(producto => 
        producto.categoria && !categoriasExcluidas.includes(producto.categoria.idCategoria)
      );
      
      console.log("Productos varios filtrados:", filtrados);
      setProductosFiltrados(filtrados);
    } 
    // Filtrado normal por categoría
    else if (categoria) {
      console.log(`Intentando filtrar por categoría: ${categoria}`);
      
      // Encontrar el idCategoria correspondiente al nombre de categoría
      const categoriaObj = categorias.find(cat => 
        cat.nombreCategoria.toLowerCase() === categoria.toLowerCase()
      );
      
      if (categoriaObj) {
        const idCategoriaFiltro = categoriaObj.idCategoria;
        console.log(`Encontrada categoría con ID: ${idCategoriaFiltro}`);
        
        // Filtrar productos por idCategoria
        const filtrados = productos.filter(producto => 
          producto.categoria && producto.categoria.idCategoria === idCategoriaFiltro
        );
        
        console.log(`Productos filtrados por categoría ${categoria} (ID: ${idCategoriaFiltro}):`, filtrados);
        setProductosFiltrados(filtrados);
      } else {
        console.log(`No se encontró la categoría ${categoria} en la lista de categorías`);
        setProductosFiltrados([]);
      }
    } else {
      // Si no hay categoría, mostrar todos los productos
      setProductosFiltrados(productos);
    }
  } else {
    // Si no hay productos o categorías cargados, mostrar lista vacía
    setProductosFiltrados([]);
  }
}, [categoria, productos, categorias]);

  return (
    <>
      <ToastContainer position="top-right" autoClose={3000} />

      <div id="product-slider" className="product-slider">
        {loading ? (
          <p>Cargando productos...</p>
        ) : productosFiltrados.length === 0 ? (
          <p>No hay productos disponibles en esta categoría</p>
        ) : (
          productosFiltrados.map((product) => (
            <div className="product-card" key={product.idProducto}>
              <Card style={{ width: "18rem" }}>
                <Card.Img
                  variant="top"
                  src={`http://localhost:8080/producto/images/${product.imgProducto}`}
                  onError={(e) => {
                    e.target.onerror = null;
                    e.target.src = "/placeholder-image.jpg";
                  }}
                />
                <Card.Body>
                  <Card.Title>{product.nombreProducto + " - " + product.cantidadProducto + product.tipoPesoProducto}</Card.Title>
                  <Card.Text>
                    <strong>Precio:</strong>{" "}
                    {new Intl.NumberFormat("es-CR", {
                      style: "currency",
                      currency: "CRC",
                      minimumFractionDigits: 0,
                    }).format(product.montoPrecioProducto)}
                  </Card.Text>
                  <div>
                    <Button onClick={() => verDetalles(product)} variant="primary">
                      Ver detalles
                    </Button>
                  </div>
                </Card.Body>
              </Card>
            </div>
          ))
        )}
      </div>

      {/* Modal (sin cambios) */}
      <Modal show={showModal} onHide={handleCloseModal} size="lg">
        <Modal.Header closeButton>
          <Modal.Title>{selectedProduct?.nombreProducto}</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          {selectedProduct && (
            <div className="row">
              <div className="col-md-6">
                <img
                  src={`http://localhost:8080/producto/images/${selectedProduct.imgProducto}`}
                  alt={selectedProduct.nombreProducto}
                  className="img-fluid rounded"
                  onError={(e) => {
                    e.target.onerror = null;
                    e.target.src = "/placeholder-image.jpg";
                  }}
                />
              </div>
              <div className="col-md-6">
                <h4>Detalles del producto</h4>
                <p>
                  <strong>Precio:</strong>{" "}
                  {new Intl.NumberFormat("es-CR", {
                    style: "currency",
                    currency: "CRC",
                    minimumFractionDigits: 0,
                  }).format(selectedProduct.montoPrecioProducto)}
                </p>

                {selectedProduct.descripcionProducto && (
                  <p>
                    <strong>Descripción:</strong> {selectedProduct.descripcionProducto}
                  </p>
                )}

                {selectedProduct.categoria && selectedProduct.categoria.nombreCategoria && (
                  <p>
                    <strong>Categoría:</strong> {selectedProduct.categoria.nombreCategoria}
                  </p>
                )}

                {selectedProduct.codigoProducto && (
                  <p>
                    <strong>SKU:</strong> {selectedProduct.codigoProducto} 
                  </p>
                )}

                <Form.Group className="mb-3">
                  <Form.Label>
                    <strong>Cantidad:</strong>
                  </Form.Label>
                  <Form.Control
                    type="number"
                    min="1"
                    max={selectedProduct.stockProducto || 10}
                    value={cantidad}
                    onChange={(e) => setCantidad(Number.parseInt(e.target.value) || 1)}
                  />
                </Form.Group>

                <Button variant="success" className="mt-3 w-100" onClick={handleAddToCartFromModal}>
                  Agregar al carrito
                </Button>
              </div>
            </div>
          )}
        </Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={handleCloseModal}>
            Cerrar
          </Button>
        </Modal.Footer>
      </Modal>
    </>
  );
}

export default ListaProductosApp;
import React, { useState, useEffect } from "react";
import axios from "axios";
import { Card, Button, Modal, Form, Row, Col } from "react-bootstrap";
import { toast, ToastContainer } from "react-toastify";
import "./ListaProductos.css";
import { useCart } from '../../contexto/ContextoCarrito';
import { useAppContext } from "../Navbar/AppContext"

function ListaProductosApp({ categoria, nombre }) {
  const { addToCart } = useCart();
  const [productos, setProductos] = useState([]);
  const [categorias, setCategorias] = useState([]);
  const [showModal, setShowModal] = useState(false);
  const [selectedProduct, setSelectedProduct] = useState(null);
  const [cantidad, setCantidad] = useState(1);
  const [productosFiltrados, setProductosFiltrados] = useState([]);
  const [loading, setLoading] = useState(true);
  const [priceRange, setPriceRange] = useState({ min: 0, max: 0 });
  const [filteredProducts, setFilteredProducts] = useState([]);
  const [selectedPrice, setSelectedPrice] = useState(0);
  const [sortOrder, setSortOrder] = useState("default");
  const [searchTerm, setSearchTerm] = useState("");

  const { globalSearchTerm } = useAppContext(); // Solo necesitamos el término de búsqueda del contexto

  // Función para ver detalles del producto
  const verDetalles = (producto) => {
    setSelectedProduct(producto);
    setCantidad(1);
    setShowModal(true);
  };

  // Función para cerrar el modal
  const handleCloseModal = () => {
    setShowModal(false);
    setSelectedProduct(null);
  };

  // Función para agregar un producto al carrito desde el modal
  const handleAddToCartFromModal = () => {
    if (selectedProduct) {
      const cantidadValida = Math.max(1, Math.min(cantidad, selectedProduct.stockProducto || 10));
      const productoConCantidad = {
        ...selectedProduct,
        cantidad: cantidadValida,
      };
      addToCart(productoConCantidad, cantidadValida);
      toast.success(
        `${selectedProduct.nombreProducto} agregado al carrito (${cantidadValida} unidad${cantidadValida > 1 ? "es" : ""})`
      );
      handleCloseModal();
    }
  };

  // Cargar categorías
  useEffect(() => {
    const fetchCategorias = async () => {
      try {
        const response = await axios.get('http://localhost:8080/categoria/');
        setCategorias(response.data);
      } catch (error) {
        console.error('Error al cargar categorías:', error);
      }
    };

    fetchCategorias();
  }, []);

  // Cargar productos
  useEffect(() => {
    const fetchProductos = async () => {
      try {
        setLoading(true);
        const response = await axios.get('http://localhost:8080/producto/');
        setProductos(response.data);
        setLoading(false);
      } catch (error) {
        console.error('Error al cargar productos:', error);
        setLoading(false);
      }
    };

    fetchProductos();
  }, []);

  useEffect(() => {
    
    
    if (productos.length > 0 && categorias.length > 0) {
      let filtrados = productos;
  
      // Filtrar por categoría
      if (categoria) {
        if (categoria.toLowerCase() === "varios") {
          const categoriasExcluidas = categorias
            .filter(cat => ["res", "cerdo", "pollo"].includes(cat.nombreCategoria.toLowerCase()))
            .map(cat => cat.idCategoria);
  
          filtrados = filtrados.filter(producto =>
            producto.categoria && !categoriasExcluidas.includes(producto.categoria.idCategoria)
          );
        } else {
          const categoriaObj = categorias.find(cat =>
            cat.nombreCategoria.toLowerCase() === categoria.toLowerCase()
          );
          if (categoriaObj) {
            filtrados = filtrados.filter(producto =>
              producto.categoria && producto.categoria.idCategoria === categoriaObj.idCategoria
            );
          }
        }
      }
  
      setProductosFiltrados(filtrados);
    }
  }, [categoria, productos, categorias]);
  useEffect(() => {
    if (productosFiltrados.length > 0) {
      let resultados = [...productosFiltrados];
      
      // Aplicar filtro de búsqueda si hay término
      if (globalSearchTerm) {
        resultados = resultados.filter(producto =>
          producto.nombreProducto.toLowerCase().includes(globalSearchTerm.toLowerCase())
        );
      }
      
      // Aplicar filtro de precio
      resultados = resultados.filter(product => product.montoPrecioProducto <= selectedPrice);
      
      // Aplicar ordenamiento
      if (sortOrder === "price-asc") {
        resultados.sort((a, b) => a.montoPrecioProducto - b.montoPrecioProducto);
      } else if (sortOrder === "price-desc") {
        resultados.sort((a, b) => b.montoPrecioProducto - a.montoPrecioProducto);
      }
      
      setFilteredProducts(resultados);
      
      // Calcular rango de precios
      const prices = productosFiltrados.map(p => p.montoPrecioProducto);
      const minPrice = Math.min(...prices);
      const maxPrice = Math.max(...prices);
      setPriceRange({ min: minPrice, max: maxPrice });
    }
  }, [globalSearchTerm, productosFiltrados, selectedPrice, sortOrder]);



  useEffect(() => {
    if (nombre) {
      setProductosFiltrados(prevProductos =>
        prevProductos.filter(producto =>
          producto.nombreProducto.toLowerCase().includes(nombre.toLowerCase())
        )
      );
    }
  }, [nombre]);
  
  

  // Calcular el rango de precios y aplicar filtros
  useEffect(() => {
    if (productosFiltrados.length > 0) {
      const prices = productosFiltrados.map(p => p.montoPrecioProducto);
      const minPrice = Math.min(...prices);
      const maxPrice = Math.max(...prices);
      setPriceRange({ min: minPrice, max: maxPrice });
      setSelectedPrice(maxPrice);
      setFilteredProducts(productosFiltrados);
    }
  }, [productosFiltrados]);

  // Función para filtrar por precio y término de búsqueda
  const handlePriceFilter = () => {
    const filtered = productosFiltrados.filter(product =>
      product.montoPrecioProducto <= selectedPrice &&
      product.nombreProducto.toLowerCase().includes(searchTerm.toLowerCase())
    );
    setFilteredProducts(filtered);
  };

  // Función para manejar la búsqueda
  const handleSearch = (term) => {
    setSearchTerm(term);
    const filtered = productosFiltrados.filter(product =>
      product.nombreProducto.toLowerCase().includes(term.toLowerCase())
    );
    setFilteredProducts(filtered);
  };

  // Función para ordenar los productos
  const handleSortChange = (e) => {
    const order = e.target.value;
    setSortOrder(order);

    let sortedProducts = [...filteredProducts];
    if (order === "price-asc") {
      sortedProducts.sort((a, b) => a.montoPrecioProducto - b.montoPrecioProducto);
    } else if (order === "price-desc") {
      sortedProducts.sort((a, b) => b.montoPrecioProducto - a.montoPrecioProducto);
    }

    setFilteredProducts(sortedProducts);
  };

  return (
    <>
      <ToastContainer position="top-right" autoClose={3000} />
  {/* Sección del buscador */}
  
      <Row>
        <Col md={3}>
          <div className="price-filter">
            <h4>FILTRAR POR PRECIO</h4>
            <p>Precio: ₡{priceRange.min} – ₡{priceRange.max}</p>
            <input
              type="range"
              min={priceRange.min}
              max={priceRange.max}
              value={selectedPrice}
              onChange={(e) => setSelectedPrice(Number(e.target.value))}
              className="price-slider"
            />
            <button onClick={handlePriceFilter} className="filter-button">FILTRAR</button>
          </div>

        </Col>
        <Col md={9}>
          <div className="sort-container">
            <select value={sortOrder} onChange={handleSortChange} className="sort-dropdown">
              <option value="default">Orden predeterminado</option>
              <option value="price-asc">Precio: Menor a Mayor</option>
              <option value="price-desc">Precio: Mayor a Menor</option>
            </select>
          </div>
          <div className="product-grid">
            {loading ? (
              <p>Cargando productos...</p>
            ) : filteredProducts.length === 0 ? (
              <p>No hay productos disponibles en esta categoría</p>
            ) : (
              filteredProducts.map((product) => (
                <div className="product-card" key={product.idProducto}>
                  <Card>
                    <Card.Img
                      variant="top"
                      src={`http://localhost:8080/producto/images/${product.imgProducto}`}
                      onError={(e) => {
                        e.target.onerror = null;
                        e.target.src = "/placeholder-image.jpg";
                      }}
                    />
                    <Card.Body>
                      <Card.Title>{`${product.nombreProducto} - ${product.cantidadProducto}${product.tipoPesoProducto}`}</Card.Title>
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
        </Col>
      </Row>

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
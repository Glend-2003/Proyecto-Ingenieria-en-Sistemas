import React, { useState, useEffect } from "react";
import axios from "axios";
import { Card, Button, Modal, Form, Row, Col } from "react-bootstrap";
import { toast, ToastContainer } from "react-toastify";
import "./ListaProductos.css";
import { useCart } from '../../contexto/ContextoCarrito';
import { useAppContext } from "../Navbar/AppContext";

function ListaProductosApp({ categoria }) {
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
  const [searchTerm, setSearchTerm] = useState("");
  const [sortOrder, setSortOrder] = useState("default");
  const { globalSearchTerm, buscarProductos, allProducts } = useAppContext();
  const [isBuscando, setIsBuscando] = useState(false);

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
     
      handleCloseModal();
    }
  };

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

  useEffect(() => {
    const fetchProductos = async () => {
      try {
        setLoading(true);
        const response = await axios.get('http://localhost:8080/producto/', { params: { estadoProducto: 1 } });
        setProductos(response.data);
        
        // Calcular el rango de precios
        if (response.data.length > 0) {
          const prices = response.data.map(p => p.montoPrecioProducto);
          setPriceRange({
            min: Math.min(...prices),
            max: Math.max(...prices)
          });
          setSelectedPrice(Math.max(...prices)); // Inicializar en el precio máximo
        }
        
        setLoading(false);
      } catch (error) {
        console.error('Error al cargar productos:', error);
        setLoading(false);
      }
    };

    fetchProductos();
  }, []);useEffect(() => {
    if (!productos.length || !categorias.length) return;
  
    let resultadosFiltrados = [...productos];
  
    // Filtrado por categoría
    if (categoria) {
      if (categoria.toLowerCase() === "varios") {
        const categoriasExcluidas = categorias
          .filter(cat => ["res", "cerdo", "pollo"].includes(cat.nombreCategoria.toLowerCase()))
          .map(cat => cat.idCategoria);
        
        resultadosFiltrados = resultadosFiltrados.filter(
          producto => producto.categoria && 
          !categoriasExcluidas.includes(producto.categoria.idCategoria)
        );
      } else {
        const categoriaObj = categorias.find(
          cat => cat.nombreCategoria.toLowerCase() === categoria.toLowerCase()
        );
        
        if (categoriaObj) {
          resultadosFiltrados = resultadosFiltrados.filter(
            producto => producto.categoria && 
            producto.categoria.idCategoria === categoriaObj.idCategoria
          );
        }
      }
    }
  
    // Filtrado por búsqueda global (si existe)
    if (globalSearchTerm) {
      resultadosFiltrados = resultadosFiltrados.filter(producto =>
        producto.nombreProducto.toLowerCase().includes(globalSearchTerm.toLowerCase()) ||
        (producto.descripcionProducto?.toLowerCase().includes(globalSearchTerm.toLowerCase())) ||
        (producto.codigoProducto?.toLowerCase().includes(globalSearchTerm.toLowerCase()))
      );
    }
  
    setFilteredProducts(resultadosFiltrados);
  }, [productos, categorias, categoria, globalSearchTerm]);

  // Efecto para sincronizar searchTerm local con globalSearchTerm
  useEffect(() => {
    if (globalSearchTerm) {
      setSearchTerm(globalSearchTerm);
      setIsBuscando(true);
    } else {
      setSearchTerm("");
      setIsBuscando(false);
    }
  }, [globalSearchTerm]);

  // Efecto para aplicar filtros a los productos (precio y ordenamiento)
  useEffect(() => {
    if (!productosFiltrados.length) return;
    
    let filtered = [...productosFiltrados];
    
    // Aplicar filtro de precio si está seleccionado y no es el máximo
    if (selectedPrice < priceRange.max) {
      filtered = filtered.filter(product =>
        product.montoPrecioProducto <= selectedPrice
      );
    }
    
    // Aplicar ordenamiento
    if (sortOrder === "price-asc") {
      filtered.sort((a, b) => a.montoPrecioProducto - b.montoPrecioProducto);
    } else if (sortOrder === "price-desc") {
      filtered.sort((a, b) => b.montoPrecioProducto - a.montoPrecioProducto);
    }
    
    setFilteredProducts(filtered);
  }, [productosFiltrados, selectedPrice, sortOrder, priceRange.max]);

  const handlePriceFilter = () => {
    // La lógica ya está en el useEffect de arriba
    // Este método solo sirve para disparar la acción al hacer clic en el botón
  };

  const handleSortChange = (e) => {
    const order = e.target.value;
    setSortOrder(order);
  };


  return (
    <>
      <ToastContainer position="top-right" autoClose={3000} />

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
          <div className="mb-2"></div>

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
              globalSearchTerm ? (
                <div className="no-results-message">
                  <p>No hay productos disponibles con el término: "{globalSearchTerm}"</p>

                </div>
              ) : (
                <p>No hay productos disponibles en esta categoría</p>
              )
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
import { useState, useEffect } from "react"
import axios from "axios"
import { useNavigate } from "react-router-dom"
import { Card, Button, Modal, Form } from "react-bootstrap"
import { toast, ToastContainer } from "react-toastify"
import "./ListaProductos.css"

function ListaProductosApp({ addToCart }) {
  const [productos, setProductos] = useState([])
  const [showModal, setShowModal] = useState(false)
  const [selectedProduct, setSelectedProduct] = useState(null)
  const [cantidad, setCantidad] = useState(1)
  const navigate = useNavigate()

  const verDetalles = (producto) => {
    setSelectedProduct(producto)
    setCantidad(1)
    setShowModal(true)
  }

  const handleCloseModal = () => {
    setShowModal(false)
    setSelectedProduct(null)
  }

  const handleAddToCartFromModal = () => {
    if (selectedProduct) {
      const cantidadValida = Math.max(1, Math.min(cantidad, selectedProduct.stockProducto || 10));
      const productoConCantidad = {
        ...selectedProduct,
        cantidad: cantidadValida,
      };
      addToCart(productoConCantidad); // Llama a addToCart
      toast.success(
        `${selectedProduct.nombreProducto} agregado al carrito (${cantidadValida} unidad${cantidadValida > 1 ? "es" : ""})`,
      );
      handleCloseModal();
    }
  };

  const cargarProductos = async () => {
    try {
      const response = await axios.get("http://localhost:8080/producto/", {
        params: { estadoProducto: 1 }
      });
      setProductos(response.data)
    } catch (error) {
      console.error("Error al cargar productos:", error)
      toast.error("Ocurrió un error al cargar los productos")
    }
  }

  useEffect(() => {
    cargarProductos()
  }, [])

  return (
    <>
      <ToastContainer position="top-right" autoClose={3000} />

      <div id="product-slider" className="product-slider">
        {productos.length === 0 ? (
          <p>Cargando productos...</p>
        ) : (
          productos.map((product) => (
            <div className="product-card" key={product.idProducto}>
              <Card style={{ width: "18rem" }}>
                <Card.Img
                  variant="top"
                  src={`http://localhost:8080/producto/images/${product.imgProducto}`}
                  onError={(e) => {
                    e.target.onerror = null
                    e.target.src = "/placeholder-image.jpg"
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
                    e.target.onerror = null
                    e.target.src = "/placeholder-image.jpg"
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

                {selectedProduct.categoriaProducto && (
                  <p>
                    <strong>Categoría:</strong> {selectedProduct.categoriaProducto}
                  </p>
                )}

                {selectedProduct.stockProducto && (
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
  )
}

export default ListaProductosApp


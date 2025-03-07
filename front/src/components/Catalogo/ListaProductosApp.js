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

  // Función para mostrar el modal con los detalles del producto
  const verDetalles = (producto) => {
    setSelectedProduct(producto)
    setCantidad(1)
    setShowModal(true)
  }

  // Función para cerrar el modal
  const handleCloseModal = () => {
    setShowModal(false)
    setSelectedProduct(null)
  }

  // Función para agregar al carrito desde el modal con la cantidad seleccionada
  const handleAddToCartFromModal = () => {
    if (selectedProduct) {
      // Crear una copia del producto con la cantidad seleccionada
      const productoConCantidad = {
        ...selectedProduct,
        cantidad: cantidad,
      }

      // Llamar a la función addToCart del componente padre
      addToCart(productoConCantidad)

      // Mostrar notificación
      toast.success(
        `${selectedProduct.nombreProducto} agregado al carrito (${cantidad} unidad${cantidad > 1 ? "es" : ""})`,
      )

      // Opcional: cerrar el modal después de agregar
      handleCloseModal()
    }
  }

  const cargarProductos = async () => {
    try {
      const response = await axios.get("http://localhost:8080/producto/")
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
        {/* Muestra un mensaje de carga si no hay productos */}
        {productos.length === 0 ? (
          <p>Cargando productos...</p>
        ) : (
          // Mapea los productos y crea una tarjeta para cada uno
          productos.map((product) => (
            <div className="product-card" key={product.idProducto}>
              <Card style={{ width: "18rem" }}>
                {/* Imagen del producto, asegurando la ruta correcta */}
                <Card.Img
                  variant="top"
                  src={`http://localhost:8080/producto/images/${product.imgProducto}`}
                  onError={(e) => {
                    e.target.onerror = null
                    e.target.src = "/placeholder-image.jpg"
                  }}
                />
                <Card.Body>
                  <Card.Title>{product.nombreProducto}</Card.Title>
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
                    <Button
                      variant="success"
                      size="sm"
                      className="float-end"
                      onClick={() => {
                        // Agregar con cantidad 1 por defecto
                        const productoConCantidad = { ...product, cantidad: 1 }
                        addToCart(productoConCantidad)
                        toast.success(`${product.nombreProducto} agregado al carrito`)
                      }}
                    >
                      Agregar
                    </Button>
                  </div>
                </Card.Body>
              </Card>
            </div>
          ))
        )}
      </div>

      {/* Modal para mostrar detalles del producto */}
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
                    <strong>Stock disponible:</strong> {selectedProduct.stockProducto} unidades
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


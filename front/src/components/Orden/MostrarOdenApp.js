import { useState, useEffect } from "react"
import { useNavigate } from "react-router-dom"
import { X } from "lucide-react"
import "./MostrarOrden.css"

function MostrarOrdenApp() {
  const navigate = useNavigate()
  const idUsuario = localStorage.getItem("idUsuario")
  const [cart, setCart] = useState(JSON.parse(localStorage.getItem("carrito")) || [])

  const calcularSubtotal = () => {
    return cart.reduce((total, item) => total + item.cantidad * item.montoPrecioProducto, 0)
  }

  const subtotal = calcularSubtotal()

  const updateQuantity = (index, increment) => {
    const newCart = [...cart]
    if (increment) {
      newCart[index].cantidad += 1
    } else {
      if (newCart[index].cantidad > 1) {
        newCart[index].cantidad -= 1
      }
    }
    setCart(newCart)
    localStorage.setItem("carrito", JSON.stringify(newCart))
  }
  
  const removeItem = (index) => {
    const newCart = cart.filter((_, i) => i !== index)
    setCart(newCart)
    localStorage.setItem("carrito", JSON.stringify(newCart))
  }

  // Add placeholder images for products if they don't have images
  useEffect(() => {
    const cartWithImages = cart.map((item) => {
      if (!item.imagenProducto) {
        return { ...item, imagenProducto: "/placeholder.svg?height=80&width=80" }
      }
      return item
    })
    if (JSON.stringify(cartWithImages) !== JSON.stringify(cart)) {
      setCart(cartWithImages)
      localStorage.setItem("carrito", JSON.stringify(cartWithImages))
    }
  }, [])

  return (
    <div className="page-container"> 
      <div className="orden-container">
        <div className="carrito-detalles">
          <table>
            <thead>
              <tr>
                <th></th>
                <th>PRODUCTO</th>
                <th>PRECIO</th>
                <th>CANTIDAD</th>
                <th>SUBTOTAL</th>
              </tr>
            </thead>
            <tbody>
              {cart.map((item, index) => (
                <tr key={index}>
                  <td>
                    <button className="remove-btn" onClick={() => removeItem(index)}>
                      <X size={16} />
                    </button>
                  </td>
                  <td>
                    <div className="producto-info">
                    <img
                      src={`http://localhost:8080/producto/images/${item.imgProducto}`}
                      alt={item.nombreProducto}
                      className="img-fluid rounded"
                      onError={(e) => {
                        e.target.onerror = null
                        e.target.src = "/placeholder-image.jpg"
                      }}
                    />
                      <span>{item.nombreProducto}</span>
                    </div>
                  </td>
                  <td className="precio">₡{item.montoPrecioProducto.toLocaleString()}</td>
                  <td>
                    <div className="cantidad-control">
                      <button className="cantidad-btn" onClick={() => updateQuantity(index, false)}>
                        -
                      </button>
                      <span className="cantidad-valor">{item.cantidad}</span>
                      <button className="cantidad-btn" onClick={() => updateQuantity(index, true)}>
                        +
                      </button>
                    </div>
                  </td>
                  <td className="subtotal">₡{(item.cantidad * item.montoPrecioProducto).toLocaleString()}</td>
                </tr>
              ))}
            </tbody>
          </table>
          {!idUsuario && (
            <div className="iniciar-sesion">
              <p>Debes iniciar sesión para continuar con el pago.</p>
              <button onClick={() => navigate("/")}>Iniciar Sesión</button>
            </div>
          )}
        </div>
        <div className="carrito-totales">
          <h2>TOTALES DEL CARRITO</h2>
          <div className="totales">
            <div className="total-line">
              <span>Subtotal</span>
              <span className="monto">₡{subtotal.toLocaleString()}</span>
            </div>
            <div className="total-line total-final">
              <span>Total</span>
              <span className="monto total-monto">₡{subtotal.toLocaleString()}</span>
            </div>
            <button className="finalizar-compra">FINALIZAR COMPRA</button>
          </div>
        </div>
      </div>
    </div>
  )
}

export default MostrarOrdenApp


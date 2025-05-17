import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { X, ShoppingCart, ChevronLeft, Plus, Minus, Shield } from "lucide-react";
import "./MostrarOrden.css";

function MostrarOrdenApp() {
  const navigate = useNavigate();
  const idUsuario = localStorage.getItem("idUsuario");
  const [cart, setCart] = useState(JSON.parse(localStorage.getItem("carrito")) || []);
  const [imagesLoaded, setImagesLoaded] = useState(false);

  const calcularSubtotal = () => {
    return cart.reduce((total, item) => total + item.cantidad * item.montoPrecioProducto, 0);
  };

  const subtotal = calcularSubtotal();

  const updateQuantity = (index, increment) => {
    const newCart = [...cart];
    if (increment) {
      newCart[index].cantidad += 1;
    } else {
      if (newCart[index].cantidad > 1) {
        newCart[index].cantidad -= 1;
      }
    }
    setCart(newCart);
    localStorage.setItem("carrito", JSON.stringify(newCart));
  };
  
  const removeItem = (index) => {
    const newCart = cart.filter((_, i) => i !== index);
    setCart(newCart);
    localStorage.setItem("carrito", JSON.stringify(newCart));
  };

  // Mejorar la calidad de las imágenes precargándolas
  useEffect(() => {
    const cartWithImages = cart.map((item) => {
      if (!item.imagenProducto) {
        return { ...item, imagenProducto: "/images/placeholder-product.jpg" };
      }
      return item;
    });
    
    if (JSON.stringify(cartWithImages) !== JSON.stringify(cart)) {
      setCart(cartWithImages);
      localStorage.setItem("carrito", JSON.stringify(cartWithImages));
    }

    // Precargar imágenes para mejor calidad visual
    if (!imagesLoaded && cart.length > 0) {
      Promise.all(
        cart.map((item) => {
          return new Promise((resolve) => {
            const img = new Image();
            img.src = `http://localhost:8080/producto/images/${item.imgProducto}`;
            img.onload = () => resolve();
            img.onerror = () => resolve();
          });
        })
      ).then(() => {
        setImagesLoaded(true);
      });
    }
  }, [cart, imagesLoaded]);

  return (
    <div className="page-container">
      <div className="orden-hero">
        <div className="orden-hero-content">
          <h1>Su Carrito de Compras</h1>
          <p>Revise sus productos y proceda al pago cuando esté listo</p>
        </div>
      </div>
      
      <div className="orden-header">
        <button 
          onClick={() => navigate("/")}
          className="back-button"
        >
          <ChevronLeft size={18} />
          Volver a la tienda
        </button>
      </div>

      <div className="orden-container">
        <div className="carrito-detalles">
          <div className="cart-section-title">
            <ShoppingCart size={20} />
            <h2>DETALLE DE PRODUCTOS</h2>
          </div>

          {cart.length === 0 ? (
            <div className="carrito-vacio">
              <img src="/images/empty-cart.png" alt="Carrito vacío" className="empty-cart-image" onError={(e) => {e.target.src = "/images/placeholder-cart.png"}} />
              <h3>Su carrito está vacío</h3>
              <p>Agregue algunos productos de nuestro catálogo para continuar</p>
              <button onClick={() => navigate("/")} className="continuar-comprando">
                CONTINUAR COMPRANDO
              </button>
            </div>
          ) : (
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
                      <button className="remove-btn" onClick={() => removeItem(index)} title="Eliminar producto">
                        <X size={18} />
                      </button>
                    </td>
                    <td>
                      <div className="producto-info">
                        <div className="producto-imagen-container">
                          <img
                            src={`http://localhost:8080/producto/images/${item.imgProducto}`}
                            alt={item.nombreProducto}
                            className="producto-imagen"
                            onError={(e) => {
                              e.target.onerror = null;
                              e.target.src = "/images/placeholder-product.jpg";
                            }}
                          />
                        </div>
                        <div className="producto-detalles">
                          <span className="producto-nombre">{item.nombreProducto}</span>
                          <span className="producto-categoria">Carnicería La Bendición</span>
                        </div>
                      </div>
                    </td>
                    <td className="precio">₡{item.montoPrecioProducto.toLocaleString()}</td>
                    <td>
                      <div className="cantidad-control">
                        <button className="cantidad-btn" onClick={() => updateQuantity(index, false)} title="Reducir cantidad">
                          <Minus size={14} />
                        </button>
                        <span className="cantidad-valor">{item.cantidad}</span>
                        <button className="cantidad-btn" onClick={() => updateQuantity(index, true)} title="Aumentar cantidad">
                          <Plus size={14} />
                        </button>
                      </div>
                    </td>
                    <td className="subtotal">₡{(item.cantidad * item.montoPrecioProducto).toLocaleString()}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
          
          {cart.length > 0 && (
            <div className="carrito-acciones">
              
            </div>
          )}
        </div>
        
        {cart.length > 0 && (
          <div className="carrito-totales">
            <h2>TOTALES DEL CARRITO</h2>
            <div className="totales">
              <div className="total-line">
                <span>Subtotal</span>
                <span className="monto">₡{subtotal.toLocaleString()}</span>
              </div>
              
              <div className="separador"></div>
              <div className="total-line total-final">
                <span>Total</span>
                <span className="monto total-monto">₡{subtotal.toLocaleString()}</span>
              </div>
              
              {!idUsuario ? (
                <div className="iniciar-sesion">
                  <div className="mensaje-sesion">
                    <p>Inicie sesión para continuar con el pago</p>
                  </div>
                  <button onClick={() => navigate("/login")} className="btn-sesion">INICIAR SESIÓN</button>
                </div>
              ) : (
                <button 
                  onClick={() => navigate("/pedido")} 
                  className="finalizar-compra"
                  disabled={cart.length === 0}
                >
                  FINALIZAR COMPRA
                </button>
              )}
              
              <div className="politica-seguridad">
                <div className="seguridad-icon">
                  <Shield size={20} color="#875725" />
                </div>
                <p>Pedido 100% seguro. Sus datos están protegidos.</p>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

export default MostrarOrdenApp;
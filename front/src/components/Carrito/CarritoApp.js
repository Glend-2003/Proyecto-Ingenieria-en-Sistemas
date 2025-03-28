import React, { useContext } from 'react';
import { Offcanvas, ListGroup, Button } from 'react-bootstrap';
import { useCart } from '../../contexto/ContextoCarrito';
import { useNavigate } from 'react-router-dom';
import './Carrito.css';
import useAuth from '../../hooks/userInfo'; 
import axios from 'axios'; 

function CarritoApp() {
  const {
    cart,
    increaseQuantity,
    decreaseQuantity,
    removeFromCart,
    clearCart,
    showCartMenu,
    setShowCartMenu,
  } = useCart();

  const { usuario } = useAuth();
  const navigate = useNavigate();

  const total = cart.reduce((sum, item) => sum + (item.montoPrecioProducto || 0) * item.cantidad, 0);

  const handleVerOrden = () => {
    setShowCartMenu(false); 
    navigate('/verOrden'); 
  };

  const handlePagar = async () => {
    if (!usuario?.idUsuario) {
      navigate('/register');
      return;
    }
  
    try {
      const token = localStorage.getItem('token');
      const carritoLocal = JSON.parse(localStorage.getItem('carrito')) || [];
      
      if (carritoLocal.length === 0) {
        alert('El carrito está vacío');
        return;
      }
  
      // Calcular totales
      const total = carritoLocal.reduce((sum, item) => sum + (item.montoPrecioProducto || 0) * item.cantidad, 0);
      const cantidadTotal = carritoLocal.reduce((sum, item) => sum + item.cantidad, 0);
  
      // Crear objeto carrito como lo espera el backend
      const carritoData = {
        usuario: { idUsuario: usuario.idUsuario }, // Esto es lo más importante
        montoTotalCarrito: total,
        estadoCarrito: true,
        cantidadCarrito: cantidadTotal
      };
  
      // Primero crear el carrito
      const { data: carritoCreado } = await axios.post('http://localhost:8080/carrito', carritoData, {
        headers: { 'Authorization': `Bearer ${token}` }
      });
  
      // Luego agregar productos
      await Promise.all(
        carritoLocal.map(item => 
          axios.post(`http://localhost:8080/carrito/${carritoCreado.idCarrito}/productos`, {
            idProducto: item.idProducto,
            cantidadProducto: item.cantidad
          }, {
            headers: { 'Authorization': `Bearer ${token}` }
          })
        )
      );
  
      localStorage.removeItem('carrito');
      clearCart();
      navigate('/pedido', { 
        state: { 
          idCarrito: carritoCreado.idCarrito,
          total: total 
        }
      });
  
    } catch (error) {
      console.error('Error en el pago:', error);
      alert(error.response?.data?.message || 'Error al procesar el pago');
    }
  };

  const groupedCart = cart.reduce((acc, item) => {
    const existingItem = acc.find((i) => i.idProducto === item.idProducto);
    if (existingItem) {
      existingItem.cantidad += item.cantidad;
    } else {
      acc.push({ ...item });
    }
    return acc;
  }, []);

  return (
    <Offcanvas show={showCartMenu} onHide={() => setShowCartMenu(false)} placement="end">
      <Offcanvas.Header closeButton>
        <Offcanvas.Title>Tu carrito de compras</Offcanvas.Title>
      </Offcanvas.Header>
      <Offcanvas.Body>
        {groupedCart.length > 0 ? (
          <ListGroup className="container-cart-products">
            {groupedCart.map((item, index) => (
              <ListGroup.Item key={index} className="cart-product">
                {item.imgProducto ? (
                  <img
                    src={
                      item.imgProducto.startsWith('http')
                        ? item.imgProducto
                        : `http://localhost:8080/producto/images/${item.imgProducto}`
                    }
                    alt={item.nombreProducto}
                    width="50"
                    className="item-img"
                  />
                ) : (
                  'No disponible'
                )}
                <div className="info-cart-product">
                  <div className="titulo-producto-carrito">
                    {item.nombreProducto}
                    <span className="cantidad-producto-carrito"> - 1 Kg</span>
                  </div>
                  <div className="precio-producto-carrito">
                    {item.cantidad} x ₡{item.montoPrecioProducto}
                  </div>
                </div>
                <Button
                  variant="danger"
                  size="sm"
                  className="float-end"
                  onClick={() => removeFromCart(item.idProducto)} // Usa item.idProducto
                >
                  X
                </Button>
              </ListGroup.Item>
            ))}
            <div className="cart-total">
              <h3>Total:</h3>
              <span className="total-pagar">
                ₡{groupedCart.reduce(
                  (total, item) => total + item.montoPrecioProducto * item.cantidad,
                  0
                )}
              </span>
            </div>

            <Button variant="primary" className="btn-ver-orden" onClick={handleVerOrden}>
              Ver Orden
            </Button>

            <Button variant="success" className="btn-pagar" onClick={handlePagar}>
              Pagar
            </Button>
          </ListGroup>
        ) : (
          <p className="cart-empty">No hay productos en el carrito.</p>
        )}
      </Offcanvas.Body>
    </Offcanvas>
  );
}

export default CarritoApp;
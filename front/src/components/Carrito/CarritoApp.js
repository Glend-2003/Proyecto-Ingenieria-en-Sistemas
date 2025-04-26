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

  const handlePagar2 = async () => {
    if (!usuario?.idUsuario) {
      navigate('/register');
      return;
    } else {
      navigate('/pedido');
    }
  }
  
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
      <Offcanvas.Header closeButton className="border-bottom">
        <Offcanvas.Title className="fw-bold">Carro de la compra</Offcanvas.Title>
      </Offcanvas.Header>
      <Offcanvas.Body className="d-flex flex-column p-0" style={{ minHeight: 0 }}>
        {groupedCart.length > 0 ? (
          <>
            <div className="cart-products-container px-3 pt-3">
              {groupedCart.map((item, index) => (
                <div key={index} className="cart-product mb-3">
                  <div className="d-flex justify-content-between align-items-start">
                    <div className="d-flex gap-3 w-100">
                      {item.imgProducto && (
                        <img
                          src={
                            item.imgProducto.startsWith('http')
                              ? item.imgProducto
                              : `http://localhost:8080/producto/images/${item.imgProducto}`
                          }
                          alt={item.nombreProducto}
                          width="60"
                          height="60"
                          className="item-img rounded"
                          style={{ objectFit: 'cover' }}
                        />
                      )}
                      <div className="flex-grow-1">
                        <div className="fw-bold">{item.nombreProducto}</div>
                        <div className="text-muted small">
                          {item.cantidad} × ₡{item.montoPrecioProducto.toLocaleString()}
                        </div>
                      </div>
                      <Button
                        variant="link"
                        size="sm"
                        className="text-danger p-0 align-self-start"
                        onClick={() => removeFromCart(item.idProducto)}
                      >
                        X
                      </Button>
                    </div>
                  </div>
                </div>
              ))}
            </div>
  
            <div className="cart-footer border-top px-3 py-3 mt-auto">
              <div className="d-flex justify-content-between mb-3">
                <span className="fw-bold">Subtotal:</span>
                <span className="fw-bold">
                  ₡{groupedCart.reduce(
                    (total, item) => total + item.montoPrecioProducto * item.cantidad,
                    0
                  ).toLocaleString()}
                </span>
              </div>
              
              <Button 
                variant="outline-dark" 
                className="w-100 mb-2 fw-bold"
                onClick={handleVerOrden}
              >
                VER CARRITO
              </Button>
              
              <Button 
                variant="success" 
                className="w-100 fw-bold"
                onClick={handlePagar2}
              >
                FINALIZAR COMPRA
              </Button>
            </div>
          </>
        ) : (
          <div className="text-center p-4">
            <p className="text-muted">No hay productos en el carrito.</p>
          </div>
        )}
      </Offcanvas.Body>
    </Offcanvas>
  );
}

export default CarritoApp;
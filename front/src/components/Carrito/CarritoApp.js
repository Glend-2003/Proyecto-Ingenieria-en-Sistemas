import React from 'react';
import { Offcanvas, ListGroup, Button, Badge} from 'react-bootstrap';
import { createContext, useContext, useState, useEffect } from "react";
import { useNavigate } from 'react-router-dom';
import './Carrito.css';


function CarritoApp({ showCart, handleShowCart, cart, removeFromCart }) {

  const navigate = useNavigate();

  const handleVerOrden = () => {
    handleShowCart(); 
    navigate('/verOrden', { state: { cart } }); 
  };

  // Función para manejar el clic en el botón pagar
  const handlePagar = () => {
    // Cerramos el carrito
    handleShowCart();
    // Redirigimos a la página de pedido (mantenemos la misma ruta)
    navigate('/pedido');
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
    <Offcanvas show={showCart} onHide={handleShowCart} placement="end">
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
                  <div className="titulo-producto-carrito">{item.nombreProducto}
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
                  onClick={() => removeFromCart(index)}
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
                
            <Button
              variant="primary"
              className="btn-ver-orden"
              onClick={handleVerOrden}
            >
              Ver Orden
            </Button>

            <Button 
              variant="success" 
              className="btn-pagar"
              onClick={handlePagar}
            >
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

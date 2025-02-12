import React from 'react';
import { Offcanvas, ListGroup, Button } from 'react-bootstrap';
import './Carrito.css'; // Importación del CSS

function CarritoApp({ showCart, handleShowCart, cart, removeFromCart }) {
  return (
    <Offcanvas show={showCart} onHide={handleShowCart} placement="end">
      <Offcanvas.Header closeButton>
        <Offcanvas.Title>Carrito de Compras</Offcanvas.Title>
      </Offcanvas.Header>
      <Offcanvas.Body>
        <h5>Tu Carrito</h5>
        {cart.length > 0 ? (
          <ListGroup className="container-cart-products">
            {cart.map((item, index) => (
              <ListGroup.Item key={index} className="cart-product">
                {item.imgProducto ? (
                  <img
                    src={item.imgProducto.startsWith('http') ? item.imgProducto : `http://localhost:8080/producto/images/${item.imgProducto}`}
                    alt={item.nombreProducto}
                    width="50"
                    className="item-img"
                  />
                ) : (
                  'No disponible'
                )}
                <div className="info-cart-product">
                  <span className="titulo-producto-carrito">{item.nombreProducto}</span>
                  <span className="precio-producto-carrito">₡{item.montoPrecioProducto}</span>
                  <span className="cantidad-producto-carrito"> - 1 Kg</span>
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
                ₡{cart.reduce((total, item) => total + item.montoPrecioProducto, 0)}
              </span>
            </div>
          </ListGroup>
        ) : (
          <p className="cart-empty">No hay productos en el carrito.</p>
        )}
      </Offcanvas.Body>
    </Offcanvas>
  );
}

export default CarritoApp;

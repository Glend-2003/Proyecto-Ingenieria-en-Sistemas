import React from 'react';
import { useLocation } from 'react-router-dom';

function MostrartOrdenApp() {
  const location = useLocation();
  const { cart } = location.state || { cart: [] }; // Obtener el carrito desde el estado de la navegación

  return (
    <div>
      <h1>Detalles de la Orden</h1>
      {cart.length > 0 ? (
        <ul>
          {cart.map((item, index) => (
            <li key={index}>
              {item.nombreProducto} - {item.cantidad} x ₡{item.montoPrecioProducto}
            </li>
          ))}
        </ul>
      ) : (
        <p>No hay productos en la orden.</p>
      )}
    </div>
  );
}

export default MostrartOrdenApp;
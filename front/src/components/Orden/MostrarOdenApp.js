import React from 'react';
import { useNavigate } from 'react-router-dom';

function MostrartOrdenApp() {
  const navigate = useNavigate();
  const idUsuario = localStorage.getItem('idUsuario'); // Verificar si el usuario está registrado
  const cart = JSON.parse(localStorage.getItem('carrito')) || []; // Obtener el carrito desde el localStorage

  return (
    <div>
      <h1>Detalles de la Orden</h1>
      {cart.length > 0 ? (
        <>
          <ul>
            {cart.map((item, index) => (
              <li key={index}>
                {item.nombreProducto} - {item.cantidad} x ₡{item.montoPrecioProducto}
              </li>
            ))}
          </ul>
          {!idUsuario && (
            <p>
              Debes iniciar sesión para continuar con el pago.{" "}
              <button onClick={() => navigate('/login')}>Iniciar Sesión</button>
            </p>
          )}
        </>
      ) : (
        <p>No hay productos en la orden.</p>
      )}
    </div>
  );
}

export default MostrartOrdenApp;
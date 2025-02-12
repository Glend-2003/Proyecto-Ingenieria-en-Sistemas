import { useState } from "react";
import "./Carrito.css";

const products = [
  {
    id: 1,
    name: "Zapatos Nike",
    price: 80,
    img: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
  },
  {
    id: 2,
    name: "Audifonos",
    price: 20,
    img: "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
  },
  {
    id: 3,
    name: "Reloj",
    price: 50,
    img: "https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1099&q=80",
  },
  {
    id: 4,
    name: "Smartwatch",
    price: 90,
    img: "https://images.unsplash.com/photo-1546868871-7041f2a55e12?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
  },
  {
    id: 5,
    name: "Perfume",
    price: 50,
    img: "https://images.unsplash.com/photo-1585386959984-a4155224a1ad?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80",
  },
];

export default function CarritoApp() {
  const [cart, setCart] = useState([]);

  const addToCart = (product) => {
    setCart((prevCart) => [...prevCart, product]);
  };

  return (
    <div>
      <header>
        <h1>Tienda</h1>
        <div className="container-icon">
          <div className="container-cart-icon">
            <span id="contador-productos">{cart.length}</span>
          </div>
        </div>
      </header>
      <div className="container-items">
        {products.map((product) => (
          <div className="item" key={product.id}>
            <figure>
              <img src={product.img} alt={product.name} />
            </figure>
            <div className="info-product">
              <h2>{product.name}</h2>
              <p className="price">${product.price}</p>
              <button className="btn-add-cart" onClick={() => addToCart(product)}>
                Añadir al carrito
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

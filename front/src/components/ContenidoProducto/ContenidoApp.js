import { createContext, useContext, useState, useEffect } from "react";

// Creación del contexto del carrito de compras
const CartContext = createContext();

// Proveedor del contexto que envolverá la aplicación y permitirá gestionar el carrito
export const CartProvider = ({ children }) => {
  // Estado para almacenar los productos en el carrito
  const [cart, setCart] = useState(() => {
    // Cargar el carrito desde localStorage al iniciar la aplicación
    const savedCart = localStorage.getItem("cart");
    return savedCart ? JSON.parse(savedCart) : [];
  });

  // Estado para mostrar u ocultar el menú del carrito
  const [showCartMenu, setShowCartMenu] = useState(false);
  
  // Estado para almacenar mensajes de error relacionados con el carrito
  const [errorMessage, setErrorMessage] = useState("");

  // useEffect para guardar el carrito en localStorage cada vez que se modifique
  useEffect(() => {
    localStorage.setItem("cart", JSON.stringify(cart));
  }, [cart]);

};

export const useCart = () => useContext(CartContext);
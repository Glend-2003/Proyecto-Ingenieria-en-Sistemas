import { createContext, useContext, useState, useEffect } from "react";

const CartContext = createContext();

export const CartProvider = ({ children }) => {
  const [cart, setCart] = useState(() => {
    const savedCart = localStorage.getItem("carrito");
    return savedCart ? JSON.parse(savedCart) : [];
  });

  const [showCartMenu, setShowCartMenu] = useState(false);
  const [errorMessage, setErrorMessage] = useState("");

  useEffect(() => {
    localStorage.setItem("carrito", JSON.stringify(cart));
  }, [cart]);

  const addToCart = (product, quantity) => {
    // Buscar si el producto ya está en el carrito
    const existingProductIndex = cart.findIndex((item) => item.idProducto === product.idProducto);

    if (existingProductIndex !== -1) {
      // Si el producto ya está en el carrito, actualizar la cantidad
      const updatedCart = [...cart];
      const totalQuantity = updatedCart[existingProductIndex].quantity + quantity;

      // Verificar si hay suficiente stock
      if (totalQuantity > product.stockProducto) {
        setErrorMessage(
          `No hay suficiente stock disponible. Solo puedes agregar ${
            product.stockProducto - updatedCart[existingProductIndex].quantity
          } unidades más.`
        );
        return;
      } else {
        // Actualizar la cantidad del producto existente
        updatedCart[existingProductIndex].quantity += quantity;
        setCart(updatedCart);
        setErrorMessage("");
      }
    } else {
      // Si el producto no está en el carrito, agregarlo
      if (quantity > product.stockProducto) {
        setErrorMessage(
          `No hay suficiente stock disponible. Solo puedes agregar ${product.stockProducto} unidades.`
        );
        return;
      } else {
        setCart([...cart, { ...product, quantity }]);
        setErrorMessage("");
      }
    }

    setShowCartMenu(true); // Mostrar el carrito después de agregar un producto
  };

  const increaseQuantity = (productId) => {
    setCart(
      cart.map((item) =>
        item.idProducto === productId
          ? { ...item, quantity: item.quantity + 1 }
          : item
      )
    );
  };

  const decreaseQuantity = (productId) => {
    setCart(
      cart.map((item) =>
        item.idProducto === productId && item.quantity > 1
          ? { ...item, quantity: item.quantity - 1 }
          : item
      )
    );
  };

  const removeFromCart = (productId) => {
    setCart(cart.filter((item) => item.idProducto !== productId));
  };

  const clearCart = () => {
    setCart([]);
    localStorage.removeItem("carrito"); 
  };

  return (
    <CartContext.Provider
      value={{
        cart,
        addToCart,
        increaseQuantity, 
        decreaseQuantity,
        removeFromCart,
        showCartMenu, 
        setShowCartMenu, 
        errorMessage, 
        setErrorMessage, 
        clearCart, 
      }}
    >
      {children}
    </CartContext.Provider>
  );
};

export const useCart = () => useContext(CartContext);
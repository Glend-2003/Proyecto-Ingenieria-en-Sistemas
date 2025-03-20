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
    const existingProduct = cart.find((item) => item.id === product.id);

    if (existingProduct) {
      const totalQuantity = existingProduct.quantity + quantity;

      if (totalQuantity > product.stockProducto) {
        setErrorMessage(
          `No hay suficiente stock disponible. Solo puedes agregar ${
            product.stockProducto - existingProduct.quantity
          } unidades más.`
        );
        return;
      } else {
        setCart(
          cart.map((item) =>
            item.id === product.idProducto
              ? { ...item, quantity: item.quantity + quantity }
              : item
          )
        );
        setErrorMessage("");
      }
    } else {
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

    setShowCartMenu(true); 
  };

  const increaseQuantity = (productId) => {
    setCart(
      cart.map((item) =>
        item.id === productId
          ? { ...item, quantity: item.quantity + 1 }
          : item
      )
    );
  };

  const decreaseQuantity = (productId) => {
    setCart(
      cart.map((item) =>
        item.id === productId && item.quantity > 1
          ? { ...item, quantity: item.quantity - 1 }
          : item
      )
    );
  };

  const removeFromCart = (productId) => {
    setCart(cart.filter((item) => item.id !== productId));
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
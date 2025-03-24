import { createContext, useState, useContext, useEffect } from "react"
import { toast } from "react-toastify"
import axios from "axios";

// Crear el contexto
const AppContext = createContext()

// Proveedor del contexto
export const AppProvider = ({ children }) => {
  const [showSidebar, setShowSidebar] = useState(false)
  const [showCart, setShowCart] = useState(false)
  const [cart, setCart] = useState([])
  const idUsuario = localStorage.getItem("idUsuario")
  const [filteredCart, setFilteredCart] = useState([]) // Nuevo estado para productos filtrados
  const [searchTerm, setSearchTerm] = useState("")
  const [globalSearchTerm, setGlobalSearchTerm] = useState("");
  const [allProducts, setAllProducts] = useState([]);
  const [filteredProducts, setFilteredProducts] = useState([]);

  // Cargar el carrito desde localStorage al iniciar
  useEffect(() => {
    const savedCart = JSON.parse(localStorage.getItem("carrito") || "[]")
    setCart(savedCart)
  }, [])

  // Cargar productos
  const loadProducts = async () => {
    try {
      const response = await axios.get('http://localhost:8080/producto/');
      setAllProducts(response.data);
      setFilteredProducts(response.data);
    } catch (error) {
      console.error('Error al cargar productos:', error);
    }
  };

  // Manejar búsqueda global
  const handleGlobalSearch = (term) => {
    setGlobalSearchTerm(term);
    if (term) {
      const filtered = allProducts.filter(product =>
        product.nombreProducto.toLowerCase().includes(term.toLowerCase())
      );
      setFilteredProducts(filtered);
    } else {
      setFilteredProducts(allProducts);
    }
  };


  useEffect(() => {
    if (searchTerm) {
      setFilteredCart(
        cart.filter((producto) =>
          producto.nombreProducto.toLowerCase().includes(searchTerm.toLowerCase())
        )
      )
    } else {
      setFilteredCart(cart)
    }
  }, [searchTerm, cart])

  // Función para actualizar el término de búsqueda
  const handleSearch = (nombre) => {
    setSearchTerm(nombre)
  }

  // Actualizar el carrito cuando cambia el usuario
  useEffect(() => {
    const savedCart = JSON.parse(localStorage.getItem("carrito") || "[]")
    if (idUsuario) {
      // Asociar el idUsuario a los productos que no lo tienen
      const updatedCart = savedCart.map((item) => ({
        ...item,
        usuarioId: item.usuarioId || idUsuario, // Asignar idUsuario si no existe
      }))
      setCart(updatedCart)
      localStorage.setItem("carrito", JSON.stringify(updatedCart))
    } else {
      // Si no hay idUsuario, mantener el carrito sin cambios
      setCart(savedCart)
    }
  }, [idUsuario])

  // Limpiar el carrito si el usuario cambia
  useEffect(() => {
    if (idUsuario && cart.length > 0 && cart[0].usuarioId !== idUsuario) {
      setCart([])
      localStorage.setItem("carrito", JSON.stringify([]))
    }
  }, [idUsuario, cart])

  // Función para mostrar/ocultar el sidebar
  const handleShowSidebar = () => {
    setShowSidebar(!showSidebar && !idUsuario)
  }

  // Función para mostrar/ocultar el carrito
  const handleShowCart = () => {
    setShowCart(!showCart)
  }

  // Función para añadir productos al carrito
  const addToCart = (producto) => {
    setCart((prevCart) => {
      const existingItem = prevCart.find((item) => item.idProducto === producto.idProducto)

      let newCart
      if (existingItem) {
        newCart = prevCart.map((item) =>
          item.idProducto === producto.idProducto ? { ...item, cantidad: item.cantidad + producto.cantidad } : item,
        )
      } else {
        // Asociar el idUsuario solo si está disponible
        newCart = [...prevCart, { ...producto, usuarioId: idUsuario || null }]
      }

      localStorage.setItem("carrito", JSON.stringify(newCart))
      return newCart
    })
  }

  // Función para eliminar productos del carrito
  const removeFromCart = (indexToRemove) => {
    const updatedCart = cart.filter((_, idx) => idx !== indexToRemove)
    setCart(updatedCart)
    localStorage.setItem("carrito", JSON.stringify(updatedCart))
    toast.info("Producto eliminado del carrito")
  }

  // Función para limpiar el carrito
  const clearCart = () => {
    setCart([])
    localStorage.setItem("carrito", JSON.stringify([]))
  }

  // Valor del contexto que se proporcionará
// Valor del contexto que se proporcionará
 // Valor del contexto
  const contextValue = {
    showSidebar,
    showCart,
    cart,
    filteredCart,
    idUsuario,
    allProducts,
    filteredProducts,
    globalSearchTerm,
    handleShowSidebar,
    handleShowCart,
    addToCart,
    handleGlobalSearch,
    loadProducts,
    setFilteredProducts
  };

  return <AppContext.Provider value={contextValue}>{children}</AppContext.Provider>
}

// Hook personalizado para usar el contexto
export const useAppContext = () => {
  const context = useContext(AppContext)
  if (context === undefined) {
    throw new Error("useAppContext debe ser usado dentro de un AppProvider")
  }
  return context
}


import { createContext, useState, useContext, useEffect } from "react"
import { toast } from "react-toastify"

// Crear el contexto
const AppContext = createContext()

// Proveedor del contexto
export const AppProvider = ({ children }) => {
  const [showSidebar, setShowSidebar] = useState(false)
  const [showCart, setShowCart] = useState(false)
  const [cart, setCart] = useState([])
  const idUsuario = localStorage.getItem("idUsuario")

  // Cargar el carrito desde localStorage al iniciar
  useEffect(() => {
    const savedCart = JSON.parse(localStorage.getItem("carrito") || "[]")
    setCart(savedCart)
  }, [])

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
  const contextValue = {
    showSidebar,
    showCart,
    cart,
    idUsuario,
    handleShowSidebar,
    handleShowCart,
    addToCart,
    removeFromCart,
    clearCart,
  }

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


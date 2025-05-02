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
  const [idUsuario, setIdUsuario] = useState(localStorage.getItem("idUsuario"));
  const [productos, setProductos] = useState([]);
  const [globalSearchTerm, setGlobalSearchTerm] = useState(""); 
  const [allProducts, setAllProducts] = useState([]); // Almacenamiento global de todos los productos

  // Cargar todos los productos al iniciar, sin importar la categoría
  useEffect(() => {
    const fetchAllProducts = async () => {
      try {
        const response = await axios.get('http://localhost:8080/producto/', { 
          params: { estadoProducto: 1 } 
        });
        setAllProducts(response.data);
      } catch (error) {
        console.error('Error al cargar todos los productos:', error);
      }
    };
    
    fetchAllProducts();
  }, []);

  // Función para buscar en TODOS los productos, sin importar la categoría actual
  const buscarProductos = (termino) => {
    // Guardar el término en sessionStorage para mantenerlo durante la redirección
    sessionStorage.setItem("searchTerm", termino);
    setGlobalSearchTerm(termino);
  };
  
  // Añadir al final del useEffect inicial en AppContext.js (línea ~21)
  useEffect(() => {
    const fetchAllProducts = async () => {
      try {
        const response = await axios.get('http://localhost:8080/producto/', { 
          params: { estadoProducto: 1 } 
        });
        setAllProducts(response.data);
      } catch (error) {
        console.error('Error al cargar todos los productos:', error);
      }
    };
    
    fetchAllProducts();
    
    // Recuperar término de búsqueda de sessionStorage
    const savedTerm = sessionStorage.getItem("searchTerm");
    if (savedTerm) {
      setGlobalSearchTerm(savedTerm);
    }
  }, []);


  
  // Función para limpiar la búsqueda
  const limpiarBusqueda = () => {
    localStorage.removeItem("globalSearchTerm");
    setGlobalSearchTerm("");
  };

  // Cargar el carrito desde localStorage al iniciar
  useEffect(() => {
    const savedCart = JSON.parse(localStorage.getItem("carrito") || "[]")
    setCart(savedCart)
  }, [])

  // Actualizar el carrito cuando cambia el usuario
  useEffect(() => {
    const savedCart = JSON.parse(localStorage.getItem("carrito") || "[]")
    
    if (idUsuario) {
      // Usuario logueado: asignar ID a todos los productos
      const updatedCart = savedCart.map((item) => ({
        ...item,
        usuarioId: idUsuario,
      }))
      setCart(updatedCart)
      localStorage.setItem("carrito", JSON.stringify(updatedCart))
    } else {
      // No hay usuario logueado: eliminar usuarioId de todos los productos
      const updatedCart = savedCart.map(({ usuarioId, ...rest }) => rest)
      setCart(updatedCart)
      localStorage.setItem("carrito", JSON.stringify(updatedCart))
    }
  }, [idUsuario])

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

  const updateUserStatus = () => {
    const id = localStorage.getItem("idUsuario");
    setIdUsuario(id);
   
    return id;
  };

  // Función para logout
  const handleLogout = () => {
    localStorage.removeItem("token");
    localStorage.removeItem("correoUsuario");
    localStorage.removeItem("nombreUsuario");
    localStorage.removeItem("nombreRol");
    localStorage.removeItem("idUsuario");
    updateUserStatus(); // Actualizar el estado
    window.location.href = "/"; // Redirige a la página principal
  };

  // Valor del contexto
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
    globalSearchTerm,
    buscarProductos,
    limpiarBusqueda,
    setGlobalSearchTerm,
    allProducts, // Agregamos todos los productos al contexto
    updateUserStatus,
    handleLogout
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
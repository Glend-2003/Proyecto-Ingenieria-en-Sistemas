import React, { useState, useEffect } from 'react';
import { NavLink } from 'react-router-dom';
import { FaHome, FaFileAlt, FaDownload, FaMapMarkerAlt, FaUser, FaSignOutAlt, FaSpinner, FaCheck, FaClock, FaEdit, FaFilter, FaSearch, FaTimes, FaCog, FaExclamationTriangle } from 'react-icons/fa';
import axios from 'axios';
import Swal from 'sweetalert2';
import DatePicker from 'react-datepicker';
import "react-datepicker/dist/react-datepicker.css";
import NavbarApp from "../Navbar/NavbarApp";
import Carrito from "../Carrito/CarritoApp";
import FooterApp from '../Footer/FooterApp';
import './Orders.css';

const Orders = () => {
  const [pedidos, setPedidos] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [usuario, setUsuario] = useState(null);
  const [showFilters, setShowFilters] = useState(false);
  
  // Estados para los filtros
  const [estadoEntrega, setEstadoEntrega] = useState('');
  const [fechaInicio, setFechaInicio] = useState(null);
  const [fechaFin, setFechaFin] = useState(null);
  const [estadoPedido, setEstadoPedido] = useState('');
  
  useEffect(() => {
    const loadUserAndOrders = async () => {
      try {
        setLoading(true);
        
        const idUsuario = localStorage.getItem('idUsuario');
        const nombreUsuario = localStorage.getItem('nombreUsuario');
        
        if (!idUsuario) {
          setError("No hay sesión de usuario activa. Por favor, inicie sesión nuevamente.");
          setLoading(false);
          return;
        }
        
        const usuarioObj = {
          idUsuario: idUsuario,
          nombreUsuario: nombreUsuario || "Usuario"
        };
        
        setUsuario(usuarioObj);
        
        // Carga inicial sin filtros
        await fetchPedidos(idUsuario);
        
      } catch (error) {
        setError("Error al cargar los datos. Por favor, inténtelo nuevamente.");
        setLoading(false);
      }
    };
    
    loadUserAndOrders();
  }, []);
  
  const fetchPedidos = async (idUsuario, filters = {}) => {
    try {
      setLoading(true);
      
      // Construir los parámetros de la consulta
      let url = `http://localhost:8080/pedido/usuario/${idUsuario}`;
      
      // Si hay filtros, usar el endpoint de filtrado
      if (Object.keys(filters).length > 0) {
        url = `http://localhost:8080/pedido/filtrar?idUsuario=${idUsuario}`;
        
        if (filters.estadoEntrega) {
          // Ahora enviamos el estado directamente como texto sin convertir
          url += `&estadoEntrega=${encodeURIComponent(filters.estadoEntrega)}`;
        }
        
        if (filters.fechaInicio) {
          const formattedDate = formatDateToString(filters.fechaInicio);
          url += `&fechaInicio=${encodeURIComponent(formattedDate)}`;
        }
        
        if (filters.fechaFin) {
          const formattedDate = formatDateToString(filters.fechaFin);
          url += `&fechaFin=${encodeURIComponent(formattedDate)}`;
        }
        
        if (filters.estadoPedido) {
          url += `&estadoPedido=${filters.estadoPedido}`;
        }
      }
      
      console.log("URL de búsqueda: ", url); // Depuración
      
      const response = await axios.get(url);
      
      if (!response.data || response.data.length === 0) {
        setPedidos([]);
        setLoading(false);
        return;
      }
      
      const pedidosMap = new Map();
      
      response.data.forEach(item => {
        if (!item.idPedido) {
          return;
        }
        
        if (!pedidosMap.has(item.idPedido)) {
          pedidosMap.set(item.idPedido, {
            idPedido: item.idPedido,
            montoTotalPedido: item.montoTotalPedido || 0,
            fechaPedido: item.fechaPedido ? new Date(item.fechaPedido).toLocaleDateString() : 'Fecha no disponible',
            estadoPedido: item.estadoPedido,
            estadoPedidoTexto: item.estadoPedidoTexto || 'Estado desconocido',
            estadoEntregaPedido: item.estadoEntregaPedido || "Pendiente",
            descripcionTipoPago: item.descripcionTipoPago || 'Pago no especificado',
            productos: []
          });
        }
        
        if (item.idProducto) {
          pedidosMap.get(item.idPedido).productos.push({
            idProducto: item.idProducto,
            nombreProducto: item.nombreProducto || 'Producto sin nombre',
            imgProducto: item.imgProducto || '',
            montoPrecioProducto: item.montoPrecioProducto || 0,
            cantidadProducto: item.cantidadProducto || 1,
            tipoPesoProducto: item.tipoPesoProducto || 'unidad'
          });
        }
      });
      
      const pedidosArray = Array.from(pedidosMap.values());
      setPedidos(pedidosArray);
      setLoading(false);
    } catch (error) {
      console.error("Error en fetchPedidos:", error);
      setError("No se pudieron cargar los pedidos. Intente nuevamente más tarde.");
      setLoading(false);
    }
  };

  // Función auxiliar mejorada para formatear fechas
  const formatDateToString = (date) => {
    if (!date) return null;
    
    try {
      const year = date.getFullYear();
      const month = String(date.getMonth() + 1).padStart(2, '0');
      const day = String(date.getDate()).padStart(2, '0');
      const hours = String(date.getHours()).padStart(2, '0');
      const minutes = String(date.getMinutes()).padStart(2, '0');
      const seconds = String(date.getSeconds()).padStart(2, '0');
      
      return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
    } catch (error) {
      console.error("Error formateando fecha:", error);
      return null;
    }
  };

  const handleApplyFilters = () => {
    const filters = {};
    
    if (estadoEntrega) {
      filters.estadoEntrega = estadoEntrega;
    }
    
    if (fechaInicio) {
      filters.fechaInicio = fechaInicio;
    }
    
    if (fechaFin) {
      filters.fechaFin = fechaFin;
    }
    
    if (estadoPedido) {
      filters.estadoPedido = estadoPedido;
    }
    
    fetchPedidos(usuario.idUsuario, filters);
    setShowFilters(false); // Opcional: cerrar el panel de filtros al aplicar
  };

  const handleClearFilters = () => {
    setEstadoEntrega('');
    setFechaInicio(null);
    setFechaFin(null);
    setEstadoPedido('');
    
    fetchPedidos(usuario.idUsuario);
  };

  const handleLogout = () => {
    localStorage.removeItem('idUsuario');
    localStorage.removeItem('nombreUsuario');
    localStorage.removeItem('correoUsuario');
    localStorage.removeItem('nombreRol');
    localStorage.removeItem('token');
    window.location.href = '/';
  };
  
  const handleCancelarPedido = async (idPedido) => {
    try {
      const result = await Swal.fire({
        title: '¿Está seguro?',
        text: "¿Desea cancelar este pedido?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Sí, cancelar',
        cancelButtonText: 'No, mantener'
      });
      
      if (result.isConfirmed) {
        // Actualiza el estado del pedido a "Cancelado" usando el endpoint correcto
        await axios.put(
          `http://localhost:8080/pedido/actualizarEstadoPedido/${idPedido}?estado=Cancelado`
        );
        
        Swal.fire(
          'Cancelado',
          'Tu pedido ha sido cancelado correctamente.',
          'success'
        );
        
        // Recargar pedidos después de cancelar
        fetchPedidos(usuario.idUsuario);
      }
    } catch (error) {
      console.error("Error cancelando pedido:", error);
      Swal.fire(
        'Error',
        'No se pudo cancelar el pedido. Intente nuevamente.',
        'error'
      );
    }
  };
  
  const handleEditarPedido = async (idPedido) => {
    try {
      const result = await Swal.fire({
        title: 'Editar pedido',
        text: "¿Desea modificar este pedido?",
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Sí, editar',
        cancelButtonText: 'Cancelar'
      });
      
      if (result.isConfirmed) {
        // Aquí iría la navegación o lógica para editar el pedido
        Swal.fire(
          'Función en desarrollo',
          'La función para editar pedidos estará disponible próximamente.',
          'info'
        );
      }
    } catch (error) {
      Swal.fire(
        'Error',
        'No se pudo procesar la solicitud. Intente nuevamente.',
        'error'
      );
    }
  };
  
  // Actualizada para manejar los estados como strings que vienen del backend
  const getEstadoEntregaTexto = (estado) => {
    // Como ahora el estado viene como string directamente del backend, lo devolvemos tal cual si existe
    if (estado && typeof estado === 'string') {
      return estado;
    }
    
    return "Desconocido";
  };
  
  // Actualizada para manejar los estados como strings
  const getEstadoEntregaIcon = (estado) => {
    switch(estado) {
      case "Pendiente":
        return <FaClock className="estado-icon pending" />;
      case "En Proceso":
        return <FaCog className="estado-icon processing" />;
      case "Entregado":
        return <FaCheck className="estado-icon delivered" />;
      case "Cancelado":
        return <FaTimes className="estado-icon cancelled" />;
      default:
        return <FaExclamationTriangle className="estado-icon unknown" />;
    }
  };

  // Verifica si un pedido está pendiente para permitir ediciones o cancelaciones
  const isPendiente = (estado) => {
    return estado === "Pendiente";
  };

  // Función para obtener la clase CSS según el estado
  const getEstadoClass = (estado) => {
    switch(estado) {
      case "Pendiente": return "status-pending";
      case "En Proceso": return "status-processing";
      case "Entregado": return "status-delivered";
      case "Cancelado": return "status-cancelled";
      default: return "status-unknown";
    }
  };

  return (
    <div className="orders-page">
      <NavbarApp />
      <Carrito />
      <div className="perfil-usuario-container">
        {/* Sidebar */}
        <div className="sidebar-container">
          <h3 className="sidebar-title">Bienvenido {localStorage.getItem('nombreUsuario') || "Usuario"}</h3>
          <nav className="sidebar-nav">
            <NavLink to="/dashboard" className="sidebar-link">
              <FaHome className="icon" /> Inicio
            </NavLink>
            <NavLink to="/Orders" className="sidebar-link">
              <FaFileAlt className="icon" /> Pedidos
            </NavLink>
            <NavLink to="/downloads" className="sidebar-link">
              <FaDownload className="icon" /> Comprobantes
            </NavLink>
            <NavLink to="/DireccionUsuario" className="sidebar-link">
              <FaMapMarkerAlt className="icon" /> Dirección
            </NavLink>
            <NavLink to="/PerfilUsuario" className="sidebar-link">
              <FaUser className="icon" /> Detalles de la cuenta
            </NavLink>
            <NavLink to="/" className="sidebar-link logout" onClick={handleLogout}>
              <FaSignOutAlt className="icon" /> Cerrar sesión
            </NavLink>
          </nav>
        </div>

        {/* Contenido principal */}
        <div className="orders-content">
          <div className="orders-header">
            <h2 className="orders-title">Mis Pedidos</h2>
            <button 
              className={`filter-button ${showFilters ? 'active' : ''}`}
              onClick={() => setShowFilters(!showFilters)}
            >
              <FaFilter /> {showFilters ? 'Ocultar filtros' : 'Mostrar filtros'}
            </button>
          </div>
          
          {/* Panel de filtros mejorado */}
          {showFilters && (
            <div className="filters-panel">
              <div className="filters-header">
                <h3>Filtrar pedidos</h3>
                <button 
                  className="close-filters"
                  onClick={() => setShowFilters(false)}
                >
                  <FaTimes />
                </button>
              </div>
              
              <div className="filters-grid">
                <div className="filter-group">
                  <label>Estado de entrega:</label>
                  <select 
                    value={estadoEntrega} 
                    onChange={(e) => setEstadoEntrega(e.target.value)}
                    className="filter-select"
                  >
                    <option value="">Todos</option>
                    <option value="Pendiente">Pendiente</option>
                    <option value="En Proceso">En Proceso</option>
                    <option value="Entregado">Entregado</option>
                    <option value="Cancelado">Cancelado</option>
                  </select>
                </div>
                
                <div className="filter-group">
                  <label>Estado del pedido:</label>
                  <select 
                    value={estadoPedido} 
                    onChange={(e) => setEstadoPedido(e.target.value)}
                    className="filter-select"
                  >
                    <option value="">Todos</option>
                    <option value="1">Activo</option>
                    <option value="0">Inactivo</option>
                  </select>
                </div>
                
                <div className="filter-group">
                  <label>Fecha desde:</label>
                  <DatePicker
                    selected={fechaInicio}
                    onChange={date => setFechaInicio(date)}
                    showTimeSelect
                    dateFormat="yyyy-MM-dd HH:mm"
                    placeholderText="Seleccione fecha inicial"
                    isClearable
                    className="date-picker"
                  />
                </div>
                
                <div className="filter-group">
                  <label>Fecha hasta:</label>
                  <DatePicker
                    selected={fechaFin}
                    onChange={date => setFechaFin(date)}
                    showTimeSelect
                    dateFormat="yyyy-MM-dd HH:mm"
                    placeholderText="Seleccione fecha final"
                    isClearable
                    className="date-picker"
                  />
                </div>
              </div>
              
              <div className="filter-actions">
                <button className="apply-filters" onClick={handleApplyFilters}>
                  <FaSearch /> Aplicar filtros
                </button>
                <button className="clear-filters" onClick={handleClearFilters}>
                  Limpiar filtros
                </button>
              </div>
            </div>
          )}
          
          {loading ? (
            <div className="loading-spinner">
              <FaSpinner className="spinner" />
              <p>Cargando pedidos...</p>
            </div>
          ) : error ? (
            <div className="error-message">
              <p>{error}</p>
              <div className="error-actions">
                <button onClick={() => fetchPedidos(usuario.idUsuario)} className="retry-button">
                  Intentar nuevamente
                </button>
                {error.includes("sesión") && (
                  <button onClick={() => window.location.href = '/login'} className="login-button">
                    Iniciar sesión
                  </button>
                )}
              </div>
            </div>
          ) : pedidos.length === 0 ? (
            <div className="no-orders">
              <p>No se encontraron pedidos con los criterios seleccionados</p>
              {showFilters ? (
                <button onClick={handleClearFilters} className="shop-now-button">
                  Quitar filtros
                </button>
              ) : (
                <NavLink to="/productos" className="shop-now-button">
                  Comprar ahora
                </NavLink>
              )}
            </div>
          ) : (
            <div className="orders-list">
              {pedidos.map(pedido => (
                <div key={pedido.idPedido} className="order-card">
                  <div className="order-header">
                    <div className="order-id">
                      Pedido #{pedido.idPedido}
                    </div>
                    <div className="order-date">
                      {pedido.fechaPedido}
                    </div>
                  </div>
                  
                  <div className="order-status">
                    <div className="status-indicator">
                      {getEstadoEntregaIcon(pedido.estadoEntregaPedido)}
                      <span className={`status-text ${getEstadoClass(pedido.estadoEntregaPedido)}`}>
                        {getEstadoEntregaTexto(pedido.estadoEntregaPedido)}
                      </span>
                    </div>
                    <div className="payment-method">
                      Método de pago: {pedido.descripcionTipoPago}
                    </div>
                  </div>
                  
                  <div className="order-products">
                    {pedido.productos && pedido.productos.map(producto => (
                      <div key={`${pedido.idPedido}-${producto.idProducto}`} className="product-item">
                       <div className="product-image">
                          <img src={producto.imgProducto || 'https://via.placeholder.com/50'} alt={producto.nombreProducto} />
                        </div>
                        <div className="product-details">
                          <div className="product-name">{producto.nombreProducto}</div>
                          <div className="product-quantity">
                            {producto.cantidadProducto} {producto.tipoPesoProducto === 'unidad' ? 'unidad(es)' : `${producto.tipoPesoProducto}(s)`}
                          </div>
                          <div className="product-price">
                            ₡{(producto.montoPrecioProducto * producto.cantidadProducto).toLocaleString()}
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                  
                  <div className="order-footer">
                    <div className="order-total">
                      Total: ₡{pedido.montoTotalPedido.toLocaleString()}
                    </div>
                    
                    <div className="order-actions">
                      {isPendiente(pedido.estadoEntregaPedido) && (
                        <>
                          <button 
                            className="edit-button" 
                            onClick={() => handleEditarPedido(pedido.idPedido)}
                          >
                            <FaEdit /> Editar
                          </button>
                          <button 
                            className="cancel-button" 
                            onClick={() => handleCancelarPedido(pedido.idPedido)}
                          >
                            Cancelar
                          </button>
                        </>
                      )}
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
      <FooterApp />
    </div>
  );
};

export default Orders;
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
import PaginacionApp from '../Paginacion/PaginacionApp';
import { ToastContainer, toast } from 'react-toastify';
import './Orders.css';

const Orders = () => {
  const [pedidos, setPedidos] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [usuario, setUsuario] = useState(null);
  const [showFilters, setShowFilters] = useState(false);
  const [estadoEntrega, setEstadoEntrega] = useState('');
  const [fechaInicio, setFechaInicio] = useState(null);
  const [fechaFin, setFechaFin] = useState(null);
  const [estadoPedido, setEstadoPedido] = useState('');
  const [currentPage, setCurrentPage] = useState(1);
  const [pedidosPaginados, setPedidosPaginados] = useState([]);
  const [totalPages, setTotalPages] = useState(1);
  const [filtrosAplicados, setFiltrosAplicados] = useState(false);
  const itemsPerPage = 5;
  
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
        await fetchPedidos(idUsuario);
        
      } catch (error) {
        setError("Error al cargar los datos. Por favor, inténtelo nuevamente.");
        setLoading(false);
      }
    };

    loadUserAndOrders();
  }, []);
  
  useEffect(() => {
    if (pedidos.length > 0) {
      setTotalPages(Math.ceil(pedidos.length / itemsPerPage));
      paginarPedidos(currentPage);
    } else {
      setPedidosPaginados([]);
      setTotalPages(1);
    }
  }, [pedidos, currentPage]);
  
  const paginarPedidos = (page) => {
    const startIndex = (page - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    const pedidosSlice = pedidos.slice(startIndex, endIndex);
    setPedidosPaginados(pedidosSlice);
  };
  
  const handlePageChange = (page) => {
    setCurrentPage(page);
  };
  
  const handleNextPage = () => {
    if (currentPage < totalPages) {
      setCurrentPage(currentPage + 1);
    }
  };
  
  const handlePreviousPage = () => {
    if (currentPage > 1) {
      setCurrentPage(currentPage - 1);
    }
  };
  
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
  
  const fetchPedidos = async (idUsuario, filters = {}) => {
    try {
      setLoading(true);
      
      let url = `http://localhost:8080/pedido/usuario/${idUsuario}`;
      
      if (Object.keys(filters).length > 0) {
        url = `http://localhost:8080/pedido/filtrar?idUsuario=${idUsuario}`;
        
        if (filters.estadoEntrega) {
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
        
        setFiltrosAplicados(true);
      } else {
        setFiltrosAplicados(false);
      }
      
      console.log("URL de búsqueda: ", url);
      
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
      setCurrentPage(1);
      setError(null);
      setLoading(false);
    } catch (error) {
      console.error("Error en fetchPedidos:", error);
      
      if (Object.keys(filters).length > 0) {
        setPedidos([]);
        setError(null);
      } else {
        setError("No se pudieron cargar los pedidos. Intente nuevamente más tarde.");
      }
      
      setLoading(false);
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
    setShowFilters(false);
  };

  const handleClearFilters = () => {
    setEstadoEntrega('');
    setFechaInicio(null);
    setFechaFin(null);
    setEstadoPedido('');
    setFiltrosAplicados(false);
    
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
    const { isConfirmed } = await Swal.fire({
      title: "¿Estás seguro que quieres cancelar el pedido?",
      text: "No podrás revertir esto.",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: '#d33',
      cancelButtonColor: '#3085d6',
      cancelButtonText: "No, cancelar",
      confirmButtonText: "Sí, eliminar",
    });

    if (!isConfirmed) return;

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
        await axios.put(
          `http://localhost:8080/pedido/actualizarEstadoPedido/${idPedido}?estado=Cancelado`
        );
        
        Swal.fire(
          'Cancelado',
          'Tu pedido ha sido cancelado correctamente.',
          'success'
        );
        
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

  const crearNotificacion = async (idUsuario) => {
    try {
      const response = await axios.post("http://localhost:8080/notificacion/agregar", {
        idUsuario: {
          idUsuario: idUsuario
        }
      }, {
        headers: {
          'Content-Type': 'application/json'
        }
      });

      toast.success("Notificación creada exitosamente.");
      console.log("Notificación creada:", response.data);
      return response.data;

    } catch (error) {
      const errorMsg = error.response?.data?.error || error.message;
      console.error("Error al crear notificación:", errorMsg);
      toast.error(errorMsg);
      throw new Error(errorMsg);
    }
  };

  const cancelarPedidoYNotificar = async (idPedido, idUsuario) => {
    const { isConfirmed } = await Swal.fire({
      title: "¿Estás seguro que quieres cancelar el pedido?",
      text: "No podrás revertir esto.",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: '#d33',
      cancelButtonColor: '#3085d6',
      cancelButtonText: "No, cancelar",
      confirmButtonText: "Sí, eliminar",
    });

    if (!isConfirmed) return;

    try {
      await axios.delete(`http://localhost:8080/pedido/eliminar/${idPedido}`);
      toast.success("Pedido cancelado con éxito.\nSe notificará a la carnicería.");

      await crearNotificacion(usuario.idUsuario);
      fetchPedidos(usuario.idUsuario);

    } catch (error) {
      console.error("Error al cancelar el pedido:", error);
      toast.error("Ocurrió un error al cancelar el pedido.");
    }
  };

  const getEstadoEntregaTexto = (estado) => {
    if (estado && typeof estado === 'string') {
      return estado;
    }
    
    return "Desconocido";
  };

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

  const isPendiente = (estado) => {
    return estado === "Pendiente";
  };

  const getEstadoClass = (estado) => {
    switch(estado) {
      case "Pendiente": return "status-pending";
      case "En Proceso": return "status-processing";
      case "Entregado": return "status-delivered";
      case "Cancelado": return "status-cancelled";
      default: return "status-unknown";
    }
  };

  const getMensajeNoResultados = () => {
    if (filtrosAplicados) {
      let mensaje = "No se encontraron pedidos";
      
      if (estadoEntrega) {
        mensaje += ` con estado "${estadoEntrega}"`;
      }
      
      if (fechaInicio || fechaFin) {
        mensaje += " en el rango de fechas seleccionado";
      }
      
      if (estadoPedido) {
        const estadoTexto = estadoPedido === "1" ? "activos" : "inactivos";
        mensaje += ` que estén ${estadoTexto}`;
      }
      
      return mensaje;
    }
    
    return "No se encontraron pedidos con los criterios seleccionados";
  };

  return (
    <div className="orders-page">
    <NavbarApp />
      <Carrito />
      <div className="perfil-usuario-container">
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
              <p>{getMensajeNoResultados()}</p>
              {filtrosAplicados ? (
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
            <>
              <div className="orders-list">
                {pedidosPaginados.map(pedido => (
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
                              onClick={() => cancelarPedidoYNotificar(pedido.idPedido, usuario.idUsuario)}
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
              
              {pedidos.length > 0 && (
                <PaginacionApp 
                  currentPage={currentPage}
                  totalPages={totalPages}
                  onPageChange={handlePageChange}
                  onNextPage={handleNextPage}
                  onPreviousPage={handlePreviousPage}
                />
              )}
            </>
          )}
        </div>
      </div>
      <FooterApp />
      <ToastContainer />
    </div>
  );
};

export default Orders;
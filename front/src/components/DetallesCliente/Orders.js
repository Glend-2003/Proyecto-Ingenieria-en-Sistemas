import React, { useState, useEffect } from 'react';
import { NavLink } from 'react-router-dom';
import { FaHome, FaFileAlt, FaDownload, FaMapMarkerAlt, FaUser, FaSignOutAlt, FaCheck, FaClock, FaFilter, FaSearch, FaTimes, FaCog, FaExclamationTriangle } from 'react-icons/fa';
import axios from 'axios';
import Swal from 'sweetalert2';
import DatePicker from 'react-datepicker';
import "react-datepicker/dist/react-datepicker.css";
import NavbarApp from "../Navbar/NavbarApp";
import FooterApp from '../Footer/FooterApp';
import PaginacionApp from '../Paginacion/PaginacionApp';
import { ToastContainer, toast } from 'react-toastify';
import './Orders.css';
import SideBarUsuario from '../DetallesCliente/SideBarUsuario';

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
  
  // Función para generar un código amigable para pedidos - DEBE SER IDÉNTICA en todos los componentes
  const generarCodigoPedido = (idPedido, fechaPedido) => {
    // Extraer el año y mes de la fecha del pedido
    const fecha = new Date(fechaPedido);
    const año = fecha.getFullYear().toString().substring(2); // Últimos dos dígitos del año
    const mes = (fecha.getMonth() + 1).toString().padStart(2, '0'); // Mes con 2 dígitos
    
    // Formatear el ID interno con ceros a la izquierda (5 dígitos)
    const idFormateado = idPedido.toString().padStart(5, '0');
    
    // Formato: PED-AAMM-XXXXX (Año-Mes-ID)
    return `PED-${año}${mes}-${idFormateado}`;
  };
  
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
  
  const formatearFechaCompleta = (fechaString) => {
    if (!fechaString) return 'Fecha no disponible';
    
    try {
      const fecha = new Date(fechaString);
      
      if (isNaN(fecha.getTime())) {
        return 'Fecha inválida';
      }
      
      const dia = fecha.getDate().toString().padStart(2, '0');
      const mes = (fecha.getMonth() + 1).toString().padStart(2, '0');
      const anio = fecha.getFullYear();
      const horas = fecha.getHours().toString().padStart(2, '0');
      const minutos = fecha.getMinutes().toString().padStart(2, '0');
      
      return `${dia}/${mes}/${anio} - Retiro: ${horas}:${minutos}`;
    } catch (error) {
      return 'Error de formato de fecha';
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
      
      const response = await axios.get(url);
      
      if (!response.data || response.data.length === 0) {
        setPedidos([]);
        setLoading(false);
        return;
      }

      const pedidosFormateados = response.data.map(pedido => ({
        idPedido: pedido.idPedido,
        codigoPedido: generarCodigoPedido(pedido.idPedido, pedido.fechaPedido),
        montoTotalPedido: pedido.montoTotalPedido || 0,
        fechaPedido: pedido.fechaPedido,
        fechaFormateada: formatearFechaCompleta(pedido.fechaPedido),
        estadoPedido: pedido.estadoPedido,
        estadoPedidoTexto: pedido.estadoPedidoTexto || 'Estado desconocido',
        estadoEntregaPedido: pedido.estadoEntregaPedido || "Pendiente",
        descripcionTipoPago: pedido.tipoPago?.descripcionTipoPago || 'Pago no especificado',
        productos: pedido.carrito?.productos?.map(producto => ({
          idProducto: producto.idProducto,
          nombreProducto: producto.nombreProducto || 'Producto sin nombre',
          imgProducto: producto.imgProducto || '',
          montoPrecioProducto: producto.montoPrecioProducto || 0,
          cantidadProducto: producto.cantidadProducto || 1,
          tipoPesoProducto: producto.tipoPesoProducto || 'unidad'
        })) || []
      }));

      setPedidos(pedidosFormateados);
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
      return response.data;

    } catch (error) {
      const errorMsg = error.response?.data?.error || error.message;
      console.error("Error al crear notificación:", errorMsg);
      toast.error(errorMsg);
      throw new Error(errorMsg);
    }
  };

  const cancelarPedidoYNotificar = async (idPedido) => {
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

  const getEstadoEntregaIcon = (estado) => {
    switch(estado) {
      case "Pendiente":
        return <FaClock className="estado-icon pending" />;
      case "En Proceso":
        return <FaCog className="estado-icon processing" />;
      case "Listo":
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
      case "Listo":
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
      <div className="perfil-usuario-container">
        <SideBarUsuario usuario={usuario} handleLogout={handleLogout} />

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
                    <option value="Listo">Listo</option>
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
            <div className="loading-container">
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
                        Pedido {pedido.codigoPedido}
                      </div>
                      <div className="order-date">
                        {pedido.fechaFormateada}
                      </div>
                    </div>
                    
                    <div className="order-status">
                      <div className="status-indicator">
                        {getEstadoEntregaIcon(pedido.estadoEntregaPedido)}
                        <span className={`status-text ${getEstadoClass(pedido.estadoEntregaPedido)}`}>
                          {pedido.estadoEntregaPedido}
                        </span>
                      </div>
                      <div className="payment-method">
                        Método de pago: {pedido.descripcionTipoPago}
                      </div>
                    </div>
                    
                    <div className="order-products">
                      {pedido.productos && pedido.productos.map(producto => (
                        <div key={`${pedido.idPedido}-${producto.idProducto}`} className="product-item">
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
                          <button 
                            className="cancel-button" 
                            onClick={() => cancelarPedidoYNotificar(pedido.idPedido)}
                          >
                            Cancelar
                          </button>
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
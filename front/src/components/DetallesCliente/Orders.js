import React, { useState, useEffect } from 'react';
import { NavLink } from 'react-router-dom';
import { FaHome, FaFileAlt, FaDownload, FaMapMarkerAlt, FaUser, FaSignOutAlt, FaSpinner, FaCheck, FaClock, FaEdit } from 'react-icons/fa';
import axios from 'axios';

import NavbarApp from "../Navbar/NavbarApp";
import Carrito from "../Carrito/CarritoApp";
import FooterApp from '../Footer/FooterApp';
import Swal from 'sweetalert2';
import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import './Orders.css';

const Orders = () => {
  const [pedidos, setPedidos] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [usuario, setUsuario] = useState(null);
 

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

        const response = await axios.get(`http://localhost:8080/pedido/usuario/${idUsuario}`);

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
              estadoEntregaPedido: item.estadoEntregaPedido || "0",
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
        setError("Error al cargar los datos. Por favor, inténtelo nuevamente.");
        setLoading(false);
      }
    };

    loadUserAndOrders();
  }, []);




  const fetchPedidos = async (idUsuario) => {
    try {
      setLoading(true);

      const response = await axios.get(`http://localhost:8080/pedido/usuario/${idUsuario}`);

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
            estadoEntregaPedido: item.estadoEntregaPedido || "0",
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
      setError("No se pudieron cargar los pedidos. Intente nuevamente más tarde.");
      setLoading(false);
    }
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
      await axios.delete(`http://localhost:8080/pedido/eliminar/${idPedido}`);
      toast.success("Pedido cancelado con éxito \n Se le enviara una notificacion a la carniceria para cancelar un pedido");
     
    } catch (error) {
      console.error("Error al cancelar el pedido:", error);
      toast.error("Ocurrió un error al cancelar el pedido");
    }
    fetchPedidos(usuario.idUsuario);
  };


  const getEstadoEntregaTexto = (estado) => {
    // Asegúrate de que estado sea tratado como string
    switch (String(estado)) {
      case "Pendiente": return "Pendiente";
      case "1": return "En preparación";
      case "2": return "En camino";
      case "3": return "Entregado";
      default: return "Desconocido";
    }
  };

  const getEstadoEntregaIcon = (estado) => {
    // Asegúrate de que estado sea tratado como string
    switch (String(estado)) {
      case "0": return <FaClock className="estado-icon pending" />;
      case "1": return <FaSpinner className="estado-icon processing" />;
      case "2": return <FaSpinner className="estado-icon shipping" />;
      case "3": return <FaCheck className="estado-icon delivered" />;
      default: return null;
    }
  };

  // Función para verificar si un pedido está en estado pendiente
  const isPendiente = (estado) => {
    return String(estado) === "0";
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
          <h2 className="orders-title">Mis Pedidos</h2>

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
              <p>No tienes pedidos realizados</p>
              <NavLink to="/productos" className="shop-now-button">
                Comprar ahora
              </NavLink>
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
                      <span className={`status-text status-${pedido.estadoEntregaPedido}`}>
                        {getEstadoEntregaTexto(pedido.estadoEntregaPedido)}
                      </span>
                    </div>
                    <div className="payment-method">
                      Método de pago: {pedido.descripcionTipoPago}
                    </div>
                  </div>

                  <div className="order-products">
                    {pedido.productos.map(producto => (
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
                      <span>Total: ₡{pedido.montoTotalPedido.toLocaleString()}</span>

                      <div className="order-buttons">
                    
                        <button
                          className="btn btn-danger btn-sm me-2"
                          onClick={() => handleCancelarPedido(pedido.idPedido)}
                        >
                          Cancelar
                        </button>

                      </div>
                    </div>
                  </div>

                </div>
              ))}
            </div>
          )}
        </div>
      </div>
      <FooterApp />
      <ToastContainer />
    </div>
  );
};

export default Orders;
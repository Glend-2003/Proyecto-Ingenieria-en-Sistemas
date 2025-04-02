import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './PedidosApp.css';

const PedidosApp = () => {
  const [pedidos, setPedidos] = useState([]);
  const [filteredPedidos, setFilteredPedidos] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [selectedPedido, setSelectedPedido] = useState(null);
  const [searchTerm, setSearchTerm] = useState('');
  const [filterStatus, setFilterStatus] = useState('todos');

  // Fetch pedidos from API
  useEffect(() => {
    const fetchPedidos = async () => {
      try {
        setLoading(true);
        const response = await axios.get('http://localhost:8080/pedido/');
        setPedidos(response.data);
        setFilteredPedidos(response.data);
        setLoading(false);
      } catch (err) {
        setError('Error al cargar los pedidos. Por favor, intente de nuevo más tarde.');
        setLoading(false);
        console.error('Error fetching pedidos:', err);
      }
    };

    fetchPedidos();
  }, []);

  // Filter pedidos based on search term and status
  useEffect(() => {
    let result = pedidos;

    // Filter by search term
    if (searchTerm) {
      result = result.filter(
        pedido =>
          pedido.idPedido.toString().includes(searchTerm) ||
          (pedido.carrito.usuario.nombreUsuario &&
            pedido.carrito.usuario.nombreUsuario.toLowerCase().includes(searchTerm.toLowerCase())) ||
          (pedido.carrito.usuario.primerApellido &&
            pedido.carrito.usuario.primerApellido.toLowerCase().includes(searchTerm.toLowerCase()))
      );
    }

    // Filter by status
    if (filterStatus !== 'todos') {
      if (filterStatus === 'activo') {
        result = result.filter(pedido => pedido.estadoPedido);
      } else if (filterStatus === 'inactivo') {
        result = result.filter(pedido => !pedido.estadoPedido);
      } else {
        result = result.filter(pedido => pedido.estadoEntregaPedido === filterStatus);
      }
    }

    setFilteredPedidos(result);
  }, [searchTerm, filterStatus, pedidos]);

  const [updatingStatus, setUpdatingStatus] = useState(null);

  const handleChangeEstadoEntrega = async (pedidoId, nuevoEstado) => {
    if (nuevoEstado === 'Cancelado' &&
      !window.confirm('¿Está seguro que desea cancelar este pedido?')) {
      return;
    }

    setUpdatingStatus(pedidoId);
    try {
      await axios.put(`http://localhost:8080/pedido/actualizarEstadoPedido/${pedidoId}?estado=${encodeURIComponent(nuevoEstado)}`);

      const updatedPedidos = pedidos.map(pedido => {
        if (pedido.idPedido === pedidoId) {
          return { ...pedido, estadoEntregaPedido: nuevoEstado };
        }
        return pedido;
      });

      setPedidos(updatedPedidos);

      if (selectedPedido && selectedPedido.idPedido === pedidoId) {
        setSelectedPedido({ ...selectedPedido, estadoEntregaPedido: nuevoEstado });
      }

      // Opcional: Mostrar notificación de éxito
      alert(`Estado actualizado a "${nuevoEstado}" correctamente`);
    } catch (err) {
      console.error('Error updating pedido status:', err);
      alert('Error al actualizar el estado del pedido: ' +
        (err.response?.data?.error || err.message));
    } finally {
      setUpdatingStatus(null);
    }
  };

  // Format date for display
  const formatDate = (dateString) => {
    if (!dateString) return '';
    const date = new Date(dateString);
    return date.toLocaleString('es-ES', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  // Get status badge color based on delivery status
  const getStatusBadgeColor = (status) => {
    switch (status) {
      case 'Pendiente':
        return 'status-badge-yellow';
      case 'En Proceso':
        return 'status-badge-blue';
      case 'Entregado':
        return 'status-badge-green';
      case 'Cancelado':
        return 'status-badge-red';
      default:
        return 'status-badge-gray';
    }
  };

  // Render status badge
  const renderStatusBadge = (status) => (
    <span className={`status-badge ${getStatusBadgeColor(status)}`}>
      {status}
    </span>
  );

  // Handle pedido selection for details view
  const handleSelectPedido = (pedido) => {
    setSelectedPedido(pedido);
  };

  // Close details view
  const handleCloseDetails = () => {
    setSelectedPedido(null);
  };

  if (loading) return <div className="loading">Cargando pedidos...</div>;
  if (error) return <div className="error">{error}</div>;

  return (
    <div className="pedidos-app">
      <h1>Gestión de Pedidos</h1>

      <div className="filters-container">
        <div className="search-container">
          <input
            type="text"
            placeholder="Buscar por ID o nombre de cliente..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="search-input"
          />
        </div>

        <div className="filter-select">
          <label htmlFor="status-filter">Filtrar por estado:</label>
          <select
            id="status-filter"
            value={filterStatus}
            onChange={(e) => setFilterStatus(e.target.value)}
          >
            <option value="todos">Todos</option>
            <option value="activo">Activo</option>
            <option value="inactivo">Inactivo</option>
            <option value="Pendiente">Pendiente</option>
            <option value="En Proceso">En Proceso</option>
            <option value="Entregado">Entregado</option>
            <option value="Cancelado">Cancelado</option>
          </select>
        </div>
      </div>

      <div className="pedidos-container">
        {filteredPedidos.length === 0 ? (
          <div className="no-results">No se encontraron pedidos con los filtros aplicados</div>
        ) : (
          <table className="pedidos-table">
            <thead>
              <tr>
                <th>ID</th>
                <th>Cliente</th>
                <th>Fecha</th>
                <th>Monto</th>
                <th>Estado Pedido</th>
                <th>Estado Entrega</th>
                <th>Acciones</th>
              </tr>
            </thead>
            <tbody>
              {filteredPedidos.map((pedido) => (
                <tr key={pedido.idPedido} className={pedido.estadoPedido ? '' : 'inactive-row'}>
                  <td>{pedido.idPedido}</td>
                  <td>
                    {pedido.carrito && pedido.carrito.usuario
                      ? `${pedido.carrito.usuario.nombreUsuario} ${pedido.carrito.usuario.primerApellido}`
                      : 'N/A'}
                  </td>
                  <td>{formatDate(pedido.fechaPedido)}</td>
                  <td>₡{pedido.montoTotalPedido ? pedido.montoTotalPedido.toLocaleString() : '0'}</td>
                  <td>
                    <span className={`active-status ${pedido.estadoPedido ? 'active' : 'inactive'}`}>
                      {pedido.estadoPedido ? 'Activo' : 'Inactivo'}
                    </span>
                  </td>
                  <td>
                    {renderStatusBadge(pedido.estadoEntregaPedido)}
                  </td>
                  <td>
                    <button
                      className="view-btn"
                      onClick={() => handleSelectPedido(pedido)}
                    >
                      Ver detalles
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}

        {/* Pedido Details Modal */}
        {selectedPedido && (
          <div className="pedido-details-modal">
            <div className="pedido-details-content">
              <button className="close-btn" onClick={handleCloseDetails}>×</button>

              <h2>Detalles del Pedido #{selectedPedido.idPedido}</h2>

              <div className="pedido-info">
                <div className="info-section">
                  <h3>Información del Pedido</h3>
                  <p><strong>Fecha:</strong> {formatDate(selectedPedido.fechaPedido)}</p>
                  <p><strong>Monto Total:</strong> ₡{selectedPedido.montoTotalPedido ? selectedPedido.montoTotalPedido.toLocaleString() : '0'}</p>
                  <p>
                    <strong>Estado:</strong>
                    <span className={`active-status ${selectedPedido.estadoPedido ? 'active' : 'inactive'}`}>
                      {selectedPedido.estadoPedido ? 'Activo' : 'Inactivo'}
                    </span>
                  </p>
                  <p>
                    <strong>Estado de Entrega:</strong>
                    {renderStatusBadge(selectedPedido.estadoEntregaPedido)}
                  </p>
                  <p>
                    <strong>Método de Pago:</strong>
                    {selectedPedido.tipoPago ? selectedPedido.tipoPago.descripcionTipoPago : 'N/A'}
                  </p>
                </div>

                {selectedPedido.carrito && selectedPedido.carrito.usuario && (
                  <div className="info-section">
                    <h3>Información del Cliente</h3>
                    <p><strong>Nombre:</strong> {selectedPedido.carrito.usuario.nombreUsuario} {selectedPedido.carrito.usuario.primerApellido} {selectedPedido.carrito.usuario.segundoApellido}</p>
                    <p><strong>Cédula:</strong> {selectedPedido.carrito.usuario.cedulaUsuario}</p>
                    <p><strong>Correo:</strong> {selectedPedido.carrito.usuario.correoUsuario}</p>
                    <p><strong>Teléfono:</strong> {selectedPedido.carrito.usuario.telefonoUsuario}</p>
                    {selectedPedido.carrito.usuario.direccion && (
                      <p><strong>Dirección:</strong> {selectedPedido.carrito.usuario.direccion.detalleExactoDireccion}</p>
                    )}
                  </div>
                )}
              </div>

              {selectedPedido.carrito && selectedPedido.carrito.producto && (
                <div className="info-section">
                  <h3>Productos</h3>
                  <div className="product-item">
                    <div className="product-info">
                      <p><strong>Nombre:</strong> {selectedPedido.carrito.producto.nombreProducto}</p>
                      <p><strong>Cantidad:</strong> {selectedPedido.carrito.cantidadCarrito}</p>
                      <p><strong>Precio Unitario:</strong> ₡{selectedPedido.carrito.producto.montoPrecioProducto ? selectedPedido.carrito.producto.montoPrecioProducto.toLocaleString() : '0'}</p>
                      <p><strong>Peso/Cantidad:</strong> {selectedPedido.carrito.producto.cantidadProducto} {selectedPedido.carrito.producto.tipoPesoProducto}</p>
                    </div>
                    {selectedPedido.carrito.producto.imgProducto && (
                      <div className="product-image">
                        <img src={selectedPedido.carrito.producto.imgProducto} alt={selectedPedido.carrito.producto.nombreProducto} />
                      </div>
                    )}
                  </div>
                </div>
              )}

              <div className="actions-section">
                <h3>Actualizar Estado de Entrega</h3>
                <div className="status-buttons">
                  <button
                    className={`status-btn ${selectedPedido.estadoEntregaPedido === 'Pendiente' ? 'selected' : ''}`}
                    onClick={() => handleChangeEstadoEntrega(selectedPedido.idPedido, 'Pendiente')}
                    disabled={updatingStatus === selectedPedido.idPedido}
                  >
                    {updatingStatus === selectedPedido.idPedido ? (
                      <span className="loading-spinner"></span>
                    ) : 'Pendiente'}
                  </button>

                  {/* Botón En Proceso */}
                  <button
                    className={`status-btn ${selectedPedido.estadoEntregaPedido === 'En Proceso' ? 'selected' : ''}`}
                    onClick={() => handleChangeEstadoEntrega(selectedPedido.idPedido, 'En Proceso')}
                    disabled={updatingStatus === selectedPedido.idPedido}
                  >
                    {updatingStatus === selectedPedido.idPedido ? (
                      <span className="loading-spinner"></span>
                    ) : 'En Proceso'}
                  </button>

                  {/* Botón Entregado */}
                  <button
                    className={`status-btn ${selectedPedido.estadoEntregaPedido === 'Entregado' ? 'selected' : ''}`}
                    onClick={() => handleChangeEstadoEntrega(selectedPedido.idPedido, 'Entregado')}
                    disabled={updatingStatus === selectedPedido.idPedido}
                  >
                    {updatingStatus === selectedPedido.idPedido ? (
                      <span className="loading-spinner"></span>
                    ) : 'Entregado'}
                  </button>

                  {/* Botón Cancelado */}
                  <button
                    className={`status-btn cancel-btn ${selectedPedido.estadoEntregaPedido === 'Cancelado' ? 'selected' : ''}`}
                    onClick={() => handleChangeEstadoEntrega(selectedPedido.idPedido, 'Cancelado')}
                    disabled={updatingStatus === selectedPedido.idPedido}
                  >
                    {updatingStatus === selectedPedido.idPedido ? (
                      <span className="loading-spinner"></span>
                    ) : 'Cancelado'}
                  </button>
                </div>
              </div>
            </div>
          </div>
        )}
      </div>

      <div className="pedidos-summary">
        <div className="summary-item">
          <span className="summary-label">Total de Pedidos:</span>
          <span className="summary-value">{pedidos.length}</span>
        </div>
        <div className="summary-item">
          <span className="summary-label">Pedidos Activos:</span>
          <span className="summary-value">{pedidos.filter(p => p.estadoPedido).length}</span>
        </div>
        <div className="summary-item">
          <span className="summary-label">Pendientes:</span>
          <span className="summary-value">{pedidos.filter(p => p.estadoEntregaPedido === 'Pendiente').length}</span>
        </div>
        <div className="summary-item">
          <span className="summary-label">En Proceso:</span>
          <span className="summary-value">{pedidos.filter(p => p.estadoEntregaPedido === 'En Proceso').length}</span>
        </div>
        <div className="summary-item">
          <span className="summary-label">Entregados:</span>
          <span className="summary-value">{pedidos.filter(p => p.estadoEntregaPedido === 'Entregado').length}</span>
        </div>
      </div>
    </div>
  );
};

export default PedidosApp;
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
  const [editMode, setEditMode] = useState(false);
  const [editFormData, setEditFormData] = useState(null);
  const [tiposPago, setTiposPago] = useState([]);

  // Fetch pedidos from API
  useEffect(() => {
    const fetchPedidos = async () => {
      try {
        setLoading(true);
        const response = await axios.get('http://localhost:8080/pedido/');
        console.log('Fetched pedidos:', response.data);
        setPedidos(response.data);
        setFilteredPedidos(response.data);
        setLoading(false);
      } catch (err) {
        setError('Error al cargar los pedidos. Por favor, intente de nuevo más tarde.');
        setLoading(false);
        console.error('Error fetching pedidos:', err);
      }
    };

    const fetchTiposPago = async () => {
      try {
        const response = await axios.get('http://localhost:8080/tipopago/');
        setTiposPago(response.data);
      } catch (err) {
        console.error('Error fetching tipos de pago:', err);
      }
    };

    fetchPedidos();
    fetchTiposPago();
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

  // Handle change in edit form
  const handleEditFormChange = (e) => {
    const { name, value, type, checked } = e.target;
    
    // Handle different input types
    const newValue = type === 'checkbox' ? checked : 
                   name === 'montoTotalPedido' ? parseFloat(value) : 
                   name === 'idTipoPago' ? parseInt(value, 10) : 
                   value;
    
    setEditFormData({
      ...editFormData,
      [name]: newValue
    });
  };

  // Initialize edit mode
  const handleEditPedido = () => {
    if (!selectedPedido) return;
    
    setEditFormData({
      idPedido: selectedPedido.idPedido,
      montoTotalPedido: selectedPedido.montoTotalPedido,
      fechaPedido: formatDateForInput(selectedPedido.fechaPedido),
      estadoPedido: selectedPedido.estadoPedido,
      estadoEntregaPedido: selectedPedido.estadoEntregaPedido,
      idCarrito: selectedPedido.carrito.idCarrito,
      idTipoPago: selectedPedido.tipoPago ? selectedPedido.tipoPago.idTipoPago : ''
    });
    
    setEditMode(true);
  };

  // Cancel edit mode
  const handleCancelEdit = () => {
    setEditMode(false);
    setEditFormData(null);
  };

  // Format date for datetime-local input
  const formatDateForInput = (dateString) => {
    if (!dateString) return '';
    const date = new Date(dateString);
    return date.toISOString().slice(0, 16); // Format YYYY-MM-DDTHH:MM
  };

  // Submit updated pedido
  const handleSubmitEdit = async (e) => {
    e.preventDefault();
    
    try {
      const response = await axios.put(
        `http://localhost:8080/pedido/${editFormData.idPedido}`, 
        editFormData
      );
      
      console.log('Update response:', response.data);
      
      // Update local state
      const updatedPedidos = pedidos.map(pedido => {
        if (pedido.idPedido === editFormData.idPedido) {
          // Create updated pedido, maintaining nested objects
          const updatedPedido = { 
            ...pedido,
            montoTotalPedido: editFormData.montoTotalPedido,
            fechaPedido: new Date(editFormData.fechaPedido).toISOString(),
            estadoPedido: editFormData.estadoPedido,
            estadoEntregaPedido: editFormData.estadoEntregaPedido
          };
          
          // Update tipoPago if changed
          if (pedido.tipoPago?.idTipoPago !== editFormData.idTipoPago) {
            const newTipoPago = tiposPago.find(tp => tp.idTipoPago === parseInt(editFormData.idTipoPago));
            updatedPedido.tipoPago = newTipoPago;
          }
          
          return updatedPedido;
        }
        return pedido;
      });
      
      setPedidos(updatedPedidos);
      setSelectedPedido(updatedPedidos.find(p => p.idPedido === editFormData.idPedido));
      setEditMode(false);
      setEditFormData(null);
      
      alert('Pedido actualizado exitosamente');
    } catch (err) {
      console.error('Error updating pedido:', err);
      alert('Error al actualizar el pedido');
    }
  };

  // Handle state changes for delivery status
  const handleChangeEstadoEntrega = async (pedidoId, nuevoEstado) => {
    try {
      await axios.put(`http://localhost:8080/pedido/actualizarEstadoEntrega/${pedidoId}`, {
        estadoEntregaPedido: nuevoEstado
      });
      
      // Update local state
      const updatedPedidos = pedidos.map(pedido => {
        if (pedido.idPedido === pedidoId) {
          return { ...pedido, estadoEntregaPedido: nuevoEstado };
        }
        return pedido;
      });
      
      setPedidos(updatedPedidos);
      
      // If a pedido is selected, update it too
      if (selectedPedido && selectedPedido.idPedido === pedidoId) {
        setSelectedPedido({ ...selectedPedido, estadoEntregaPedido: nuevoEstado });
      }

    } catch (err) {
      console.error('Error updating pedido status:', err);
      alert('Error al actualizar el estado del pedido');
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
      case 'Enviado':
        return 'status-badge-purple';
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
    setEditMode(false);
    setEditFormData(null);
  };

  // Close details view
  const handleCloseDetails = () => {
    setSelectedPedido(null);
    setEditMode(false);
    setEditFormData(null);
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
            <option value="Enviado">Enviado</option>
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
              
              {!editMode ? (
                // VIEW MODE
                <>
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
                      >
                        Pendiente
                      </button>
                      <button 
                        className={`status-btn ${selectedPedido.estadoEntregaPedido === 'En Proceso' ? 'selected' : ''}`}
                        onClick={() => handleChangeEstadoEntrega(selectedPedido.idPedido, 'En Proceso')}
                      >
                        En Proceso
                      </button>
                      <button 
                        className={`status-btn ${selectedPedido.estadoEntregaPedido === 'Enviado' ? 'selected' : ''}`}
                        onClick={() => handleChangeEstadoEntrega(selectedPedido.idPedido, 'Enviado')}
                      >
                        Enviado
                      </button>
                      <button 
                        className={`status-btn ${selectedPedido.estadoEntregaPedido === 'Entregado' ? 'selected' : ''}`}
                        onClick={() => handleChangeEstadoEntrega(selectedPedido.idPedido, 'Entregado')}
                      >
                        Entregado
                      </button>
                      <button 
                        className={`status-btn cancel-btn ${selectedPedido.estadoEntregaPedido === 'Cancelado' ? 'selected' : ''}`}
                        onClick={() => handleChangeEstadoEntrega(selectedPedido.idPedido, 'Cancelado')}
                      >
                        Cancelado
                      </button>
                    </div>
                  </div>
                  
                  <div className="edit-button-container">
                    <button 
                      className="edit-pedido-btn"
                      onClick={handleEditPedido}
                    >
                      Editar Pedido
                    </button>
                  </div>
                </>
              ) : (
                // EDIT MODE
                <form onSubmit={handleSubmitEdit} className="edit-form">
                  <div className="form-group">
                    <label>Monto Total</label>
                    <input 
                      type="number" 
                      name="montoTotalPedido" 
                      value={editFormData.montoTotalPedido} 
                      onChange={handleEditFormChange}
                      required
                      step="0.01"
                    />
                  </div>
                  
                  <div className="form-group">
                    <label>Fecha del Pedido</label>
                    <input 
                      type="datetime-local" 
                      name="fechaPedido" 
                      value={editFormData.fechaPedido} 
                      onChange={handleEditFormChange}
                      required
                    />
                  </div>
                  
                  <div className="form-group checkbox-group">
                    <label>
                      <input 
                        type="checkbox" 
                        name="estadoPedido" 
                        checked={editFormData.estadoPedido} 
                        onChange={handleEditFormChange}
                      />
                      Pedido Activo
                    </label>
                  </div>
                  
                  <div className="form-group">
                    <label>Estado de Entrega</label>
                    <select 
                      name="estadoEntregaPedido" 
                      value={editFormData.estadoEntregaPedido} 
                      onChange={handleEditFormChange}
                      required
                    >
                      <option value="Pendiente">Pendiente</option>
                      <option value="En Proceso">En Proceso</option>
                      <option value="Enviado">Enviado</option>
                      <option value="Entregado">Entregado</option>
                      <option value="Cancelado">Cancelado</option>
                    </select>
                  </div>
                  
                  <div className="form-group">
                    <label>Método de Pago</label>
                    <select 
                      name="idTipoPago" 
                      value={editFormData.idTipoPago} 
                      onChange={handleEditFormChange}
                      required
                    >
                      <option value="">Seleccione un método de pago</option>
                      {tiposPago.map(tipo => (
                        <option key={tipo.idTipoPago} value={tipo.idTipoPago}>
                          {tipo.descripcionTipoPago}
                        </option>
                      ))}
                    </select>
                  </div>
                  
                  <div className="form-actions">
                    <button type="submit" className="save-btn">Guardar Cambios</button>
                    <button type="button" className="cancel-btn" onClick={handleCancelEdit}>Cancelar</button>
                  </div>
                </form>
              )}
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
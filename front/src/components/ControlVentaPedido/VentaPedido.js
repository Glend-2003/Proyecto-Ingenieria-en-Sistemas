import React, { useState, useEffect } from "react";
import axios from "axios";
import { Bar, Pie } from "react-chartjs-2";
import { Chart, ArcElement, CategoryScale, LinearScale, BarElement, PointElement, LineElement, Legend, Tooltip } from 'chart.js';
import { Snackbar, Alert as MuiAlert } from "@mui/material";
import "./VentaPedido.css";
import SideBar from "../SideBar/SideBar";
import FooterApp from "../Footer/FooterApp";
import useAuth from "../../hooks/useAuth";

// Registrar componentes necesarios de Chart.js
Chart.register(
  ArcElement,
  CategoryScale,
  LinearScale,
  BarElement,
  PointElement,
  LineElement,
  Legend,
  Tooltip
);

const Alert = React.forwardRef(function Alert(props, ref) {
  return <MuiAlert elevation={6} ref={ref} variant="filled" {...props} />;
});

const PedidosCanceladosApp = () => {
  const [pedidos, setPedidos] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [selectedPedido, setSelectedPedido] = useState(null);
  const [ventasData, setVentasData] = useState(null);
  const [ventasLoading, setVentasLoading] = useState(false);
  const [chartType, setChartType] = useState("bar");
  const { usuario } = useAuth();

  // Estado para paginación
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage] = useState(10);

  // Fetch pedidos cancelados y datos de ventas
  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);

        const pedidosResponse = await axios.get("http://localhost:8080/pedido/cancelado");
        setPedidos(pedidosResponse.data);

        setVentasLoading(true);
        const ventasResponse = await axios.get("http://localhost:8080/pedido/reporteVentas");
        setVentasData(ventasResponse.data);

        setLoading(false);
        setVentasLoading(false);
      } catch (err) {
        setError("Error al cargar los datos. Por favor, intente de nuevo más tarde.");
        setLoading(false);
        setVentasLoading(false);
        console.error("Error fetching data:", err);
      }
    };

    fetchData();
  }, []);

  // Lógica de paginación
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentItems = pedidos.slice(indexOfFirstItem, indexOfLastItem);
  const totalPages = Math.ceil(pedidos.length / itemsPerPage);


  const paginate = (pageNumber) => setCurrentPage(pageNumber);

  const formatDate = (dateString) => {
    if (!dateString) return "";
    const date = new Date(dateString);
    return date.toLocaleString("es-ES", {
      day: "2-digit",
      month: "2-digit",
      year: "numeric",
      hour: "2-digit",
      minute: "2-digit",
    });
  };

  const getStatusBadgeColor = (status) => {
    switch (status) {
      case "Cancelado":
        return "status-badge-red";
      default:
        return "status-badge-gray";
    }
  };

  const renderStatusBadge = (status) => (
    <span className={`status-badge ${getStatusBadgeColor(status)}`}>
      {status}
    </span>
  );

  const handleSelectPedido = (pedido) => {
    setSelectedPedido(pedido);
  };

  const handleCloseDetails = () => {
    setSelectedPedido(null);
  };


  const formatCurrency = (value) => {
    return new Intl.NumberFormat("es-CR", {
      style: "currency",
      currency: "CRC",
      minimumFractionDigits: 2,
    }).format(value || 0);
  };

  // Preparar datos para los gráficos
  const prepareChartData = () => {
    if (!ventasData) return { barData: null, pieData: null };

    const labels = ["Diario", "Semanal", "Mensual", "Anual", "Total"];
    const ventasValues = [
      ventasData.diario?.totalVentas || 0,
      ventasData.semanal?.totalVentas || 0,
      ventasData.mensual?.totalVentas || 0,
      ventasData.anual?.totalVentas || 0,
      ventasData.total?.totalVentas || 0,
    ];

    // Datos para gráfico de barras
    const barData = {
      labels,
      datasets: [
        {
          label: "Ventas Totales (₡)",
          data: ventasValues,
          backgroundColor: "rgba(54, 162, 235, 0.7)",
          borderColor: "rgba(54, 162, 235, 1)",
          borderWidth: 1,
        },
        {
          label: "Cantidad de Pedidos",
          data: [
            ventasData.diario?.cantidadPedidos || 0,
            ventasData.semanal?.cantidadPedidos || 0,
            ventasData.mensual?.cantidadPedidos || 0,
            ventasData.anual?.cantidadPedidos || 0,
            ventasData.total?.cantidadPedidos || 0,
          ],
          backgroundColor: "rgba(255, 99, 132, 0.7)",
          borderColor: "rgba(255, 99, 132, 1)",
          borderWidth: 1,
          type: "bar",
        },
      ],
    };

    // Datos para gráfico circular
    const pieData = {
      labels,
      datasets: [
        {
          data: ventasValues,
          backgroundColor: [
            "rgba(255, 99, 132, 0.7)",
            "rgba(54, 162, 235, 0.7)",
            "rgba(255, 206, 86, 0.7)",
            "rgba(75, 192, 192, 0.7)",
            "rgba(153, 102, 255, 0.7)",
          ],
          borderColor: "#fff",
          borderWidth: 1,
        },
      ],
    };

    return { barData, pieData };
  };

  const { barData, pieData } = prepareChartData();

  // Opciones para gráfico de barras
  const barOptions = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        position: "top",
      },
      tooltip: {
        callbacks: {
          label: function (context) {
            let label = context.dataset.label || "";
            if (label) {
              label += ": ";
            }
            if (context.datasetIndex === 0) {
              label += formatCurrency(context.raw);
            } else {
              label += context.raw;
            }
            return label;
          },
        },
      },
    },
    scales: {
      y: {
        beginAtZero: true,
        title: {
          display: true,
          text: "Ventas Totales (₡)",
        },
      },
    },
  };

  // Opciones para gráfico circular
  const pieOptions = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        position: "top",
      },
      tooltip: {
        callbacks: {
          label: function (context) {
            const label = context.label || '';
            const value = context.raw || 0;
            return `${label}: ${formatCurrency(value)}`;
          },
        },
      },
    },
  };

  if (loading) return (
    <div className="content-container">
      <SideBar usuario={usuario} />
      <div className="loading">Cargando datos...</div>
    </div>
  );

  if (error) return (
    <div className="content-container">
      <SideBar usuario={usuario} />
      <div className="error">{error}</div>
    </div>
  );

  return (
    <div className="pedidos-app">
      <div className="content-container">
        <SideBar usuario={usuario} />

        <div className="main-content">
          <h1>Pedidos completados</h1>

          <div className="pedidos-container">
            {pedidos.length === 0 ? (
              <div className="no-results">No se encontraron pedidos completados</div>
            ) : (
              <>
                <table className="pedidos-table">
                  <thead>
                    <tr>

                      <th>Cliente</th>
                      <th>Fecha</th>
                      <th>Monto</th>
                      <th>Estado Entrega</th>
                      <th>Acciones</th>
                    </tr>
                  </thead>
                  <tbody>
                    {currentItems.map((pedido) => (
                      <tr key={pedido.idPedido}>

                        <td>
                          {pedido.carrito && pedido.carrito.usuario
                            ? `${pedido.carrito.usuario.nombreUsuario} ${pedido.carrito.usuario.primerApellido}`
                            : 'N/A'}
                        </td>
                        <td>{formatDate(pedido.fechaPedido)}</td>
                        <td>₡{pedido.montoTotalPedido ? pedido.montoTotalPedido.toLocaleString() : '0'}</td>

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

                {/* Paginación */}
                <div className="pagination">
                  <button
                    onClick={() => paginate(currentPage - 1)}
                    disabled={currentPage === 1}
                    className="page-btn"
                  >
                    Anterior
                  </button>

                  {Array.from({ length: totalPages }, (_, i) => i + 1).map(number => (
                    <button
                      key={number}
                      onClick={() => paginate(number)}
                      className={`page-btn ${currentPage === number ? 'active' : ''}`}
                    >
                      {number}
                    </button>
                  ))}

                  <button
                    onClick={() => paginate(currentPage + 1)}
                    disabled={currentPage === totalPages}
                    className="page-btn"
                  >
                    Siguiente
                  </button>
                </div>
              </>
            )}

            {/* Detalles del Pedido Modal */}
            {selectedPedido && (
              <div className="pedido-details-modal">
                <div className="pedido-details-content">
                  <button className="close-btn" onClick={handleCloseDetails}>×</button>

                  <h2>Detalles del Pedido </h2>

                  <div className="pedido-info">
                    <div className="info-section">
                      <h3>Información del Pedido</h3>
                      <p><strong>Fecha del pedido:</strong> {formatDate(selectedPedido.fechaPedido)}</p>
                      {selectedPedido.montoTotalPedido && (
                        <>
                          <p><strong>IVA (13%):</strong> ₡{(selectedPedido.montoTotalPedido * (13 / 113)).toFixed(2).toLocaleString()}</p>
                          <p><strong>Subtotal:</strong> ₡{(selectedPedido.montoTotalPedido / 1.13).toFixed(2).toLocaleString()}</p>
                        </>
                      )}
                      <p><strong>Monto Total:</strong> ₡{selectedPedido.montoTotalPedido ? selectedPedido.montoTotalPedido.toLocaleString() : '0'}</p>

                      <p>
                        <strong>Estado de Entrega: </strong>
                        {renderStatusBadge(selectedPedido.estadoEntregaPedido)}
                      </p>
                    </div>

                    {selectedPedido.carrito && selectedPedido.carrito.usuario && (
                      <div className="info-section">
                        <h3>Información del Cliente</h3>
                        <p><strong>Nombre:</strong> {selectedPedido.carrito.usuario.nombreUsuario} {selectedPedido.carrito.usuario.primerApellido} {selectedPedido.carrito.usuario.segundoApellido}</p>
                        <p
                          style={{
                            color: selectedPedido.carrito.usuario.cedulaUsuario ? 'black' : '#aaa'

                          }}
                        >
                          <strong>Cédula:</strong> {selectedPedido.carrito.usuario.cedulaUsuario || 'Sin cédula'}
                        </p>
                        <p><strong>Correo:</strong> {selectedPedido.carrito.usuario.correoUsuario}</p>

                        <p
                          style={{
                            color: selectedPedido.carrito.usuario.telefonoUsuario ? 'black' : '#aaa'

                          }}
                        >
                          <strong>Teléfono:</strong> {selectedPedido.carrito.usuario.telefonoUsuario || 'Sin numero de celular registrado'}</p>
                        {selectedPedido.carrito.usuario.direccion && (
                          <p><strong>Dirección:</strong> {selectedPedido.carrito.usuario.direccion.detalleExactoDireccion}</p>
                        )}
                      </div>
                    )}
                  </div>

                  {selectedPedido.carrito && selectedPedido.carrito.productos && (
                    <div className="info-section">
                      <h3>Productos</h3>
                      <table className="productos-table">
                        <thead>
                          <tr>
                            <th>Producto</th>
                            <th>Cantidad</th>
                            <th>Precio Unitario</th>
                            <th>Subtotal</th>
                            <th>Código</th>
                          </tr>
                        </thead>
                        <tbody>
                          {selectedPedido.carrito.productos.map((producto, index) => {
                            const cantidad = producto.cantidadProducto || 1;
                            const precio = producto.montoPrecioProducto || 0;
                            const subtotal = cantidad * precio;

                            return (
                              <tr key={index}>
                                <td>
                                  <div className="product-info">
                                    {producto.imgProducto && (
                                      <img
                                        src={producto.imgProducto}
                                        alt={producto.nombreProducto}
                                        className="product-image-small"
                                      />
                                    )}
                                    <span>{producto.nombreProducto}</span>
                                  </div>
                                </td>
                                <td>{cantidad}</td>
                                <td>{formatCurrency(precio)}</td>
                                <td>{formatCurrency(subtotal)}</td>
                                <td>{producto.codigoProducto || 'N/A'}</td>
                              </tr>
                            );
                          })}
                        </tbody>
                        <tfoot>
                          <tr>
                            <td colSpan="3" className="text-right"><strong>Total:</strong></td>
                            <td>{formatCurrency(selectedPedido.montoTotalPedido)}</td>
                            <td></td>
                          </tr>
                        </tfoot>
                      </table>
                    </div>
                  )}
                </div>
              </div>
            )}
          </div>

          {/* Sección de gráficos */}
          <div className="graficos-section">
            <h2>Reporte de Ventas Completadas</h2>

            <div className="chart-type-selector">
              <button
                className={`chart-type-btn ${chartType === "bar" ? "active" : ""}`}
                onClick={() => setChartType("bar")}
              >
                Gráfico de Barras
              </button>
              <button
                className={`chart-type-btn ${chartType === "pie" ? "active" : ""}`}
                onClick={() => setChartType("pie")}
              >
                Gráfico Circular
              </button>
            </div>

            {ventasLoading ? (
              <div className="loading-chart">Cargando gráficos...</div>
            ) : (
              <>
                <div className="chart-container">
                  {chartType === "bar" && barData ? (
                    <Bar data={barData} options={barOptions} />
                  ) : pieData ? (
                    <Pie data={pieData} options={pieOptions} />
                  ) : null}
                </div>

                <div className="ventas-resumen">
                  <div className="resumen-card">
                    <h3>Ventas Diarias</h3>
                    <p className="ventas-total">{formatCurrency(ventasData?.diario?.totalVentas)}</p>
                    <p>{ventasData?.diario?.cantidadPedidos || 0} pedidos</p>
                    <p>Promedio: {formatCurrency(ventasData?.diario?.promedio)}</p>
                  </div>

                  <div className="resumen-card">
                    <h3>Ventas Semanales</h3>
                    <p className="ventas-total">{formatCurrency(ventasData?.semanal?.totalVentas)}</p>
                    <p>{ventasData?.semanal?.cantidadPedidos || 0} pedidos</p>
                    <p>Promedio: {formatCurrency(ventasData?.semanal?.promedio)}</p>
                  </div>

                  <div className="resumen-card">
                    <h3>Ventas Mensuales</h3>
                    <p className="ventas-total">{formatCurrency(ventasData?.mensual?.totalVentas)}</p>
                    <p>{ventasData?.mensual?.cantidadPedidos || 0} pedidos</p>
                    <p>Promedio: {formatCurrency(ventasData?.mensual?.promedio)}</p>
                  </div>

                  <div className="resumen-card">
                    <h3>Ventas Anuales</h3>
                    <p className="ventas-total">{formatCurrency(ventasData?.anual?.totalVentas)}</p>
                    <p>{ventasData?.anual?.cantidadPedidos || 0} pedidos</p>
                    <p>Promedio: {formatCurrency(ventasData?.anual?.promedio)}</p>
                  </div>

                  <div className="resumen-card total">
                    <h3>Total General</h3>
                    <p className="ventas-total">{formatCurrency(ventasData?.total?.totalVentas)}</p>
                    <p>{ventasData?.total?.cantidadPedidos || 0} pedidos</p>
                    <p>Promedio: {formatCurrency(ventasData?.total?.promedio)}</p>
                  </div>
                </div>
              </>
            )}
          </div>
        </div>
      </div>

      <FooterApp />
    </div>
  );
};

export default PedidosCanceladosApp;
import React, { useState, useEffect } from 'react';
import { toast, ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import SideBar from '../SideBar/SideBar';
import useAuth from '../../hooks/useAuth';
import './VentaPedido.css';
import FooterApp from '../Footer/FooterApp';
import { Card, CardGroup, Badge, Table } from 'react-bootstrap';

const VentaPedido = () => {
  const [reporte, setReporte] = useState({
    diario: {},
    semanal: {},
    mensual: {},
    anual: {},
    total: {}
  });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const { usuario } = useAuth();

  const obtenerReporteVentas = async () => {
    setLoading(true);
    setError(null);
    
    try {
      const response = await fetch('http://localhost:8080/pedido/reporteVentas');
      if (!response.ok) {
        throw new Error('Error al obtener el reporte');
      }
      const data = await response.json();
      
      setReporte({
        diario: data.diario || {},
        semanal: data.semanal || {},
        mensual: data.mensual || {},
        anual: data.anual || {},
        total: data.total || {}
      });
    } catch (err) {
      setError(err.message);
      toast.error('Error al cargar el reporte de ventas');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    obtenerReporteVentas();
  }, []);

  const formatearMoneda = (valor) => {
    if (!valor) return '₡0.00';
    const num = typeof valor === 'string' ? parseFloat(valor.replace(/[^0-9.]/g, '')) : valor;
    return new Intl.NumberFormat('es-CR', { 
      style: 'currency', 
      currency: 'CRC',
      minimumFractionDigits: 2
    }).format(num);
  };

  if (loading) return (
    <div className="content-container">
      <SideBar usuario={usuario} />
      <div className="container mt-5 text-center">
        <div className="spinner-border text-primary" role="status">
          <span className="visually-hidden">Cargando...</span>
        </div>
        <p>Cargando reporte de ventas...</p>
      </div>
    </div>
  );

  if (error) return (
    <div className="content-container">
      <SideBar usuario={usuario} />
      <div className="container mt-5">
        <div className="alert alert-danger" role="alert">
          Error: {error}
        </div>
      </div>
    </div>
  );

  return (
    <div className="content-container">
      <SideBar usuario={usuario} />
      
      <div className="venta-pedido-container">
        <h1 className="mb-4">Reporte de Ventas</h1>
        
        <div className="admin-content">
          <CardGroup className="mb-4">
            <Card className="text-center">
              <Card.Body>
                <Card.Title>Ventas Diarias</Card.Title>
                <Card.Text className="display-6">
                  {formatearMoneda(reporte.diario.totalVentas || reporte.diario.totalventas)}
                </Card.Text>
                <Badge bg="info">{reporte.diario.cantidadPedidos || 0} pedidos</Badge>
              </Card.Body>
            </Card>
            
            <Card className="text-center">
              <Card.Body>
                <Card.Title>Ventas Semanales</Card.Title>
                <Card.Text className="display-6">
                  {formatearMoneda(reporte.semanal.totalVentas || reporte.semanal.totalventas)}
                </Card.Text>
                <Badge bg="info">{reporte.semanal.cantidadPedidos || 0} pedidos</Badge>
              </Card.Body>
            </Card>
            
            <Card className="text-center">
              <Card.Body>
                <Card.Title>Ventas Mensuales</Card.Title>
                <Card.Text className="display-6">
                  {formatearMoneda(reporte.mensual.totalVentas || reporte.mensual.totalventas)}
                </Card.Text>
                <Badge bg="info">{reporte.mensual.cantidadPedidos || 0} pedidos</Badge>
              </Card.Body>
            </Card>
          </CardGroup>
          
          <CardGroup className="mb-4">
            <Card className="text-center">
              <Card.Body>
                <Card.Title>Ventas Anuales</Card.Title>
                <Card.Text className="display-6">
                  {formatearMoneda(reporte.anual.totalVentas || reporte.anual.totalventas)}
                </Card.Text>
                <Badge bg="info">{reporte.anual.cantidadPedidos || 0} pedidos</Badge>
              </Card.Body>
            </Card>
            
            <Card className="text-center bg-primary text-white">
              <Card.Body>
                <Card.Title>Total General</Card.Title>
                <Card.Text className="display-6">
                  {formatearMoneda(reporte.total.totalVentas || reporte.total.totalventas)}
                </Card.Text>
                <Badge bg="light" text="dark">{reporte.total.cantidadPedidos || 0} pedidos</Badge>
              </Card.Body>
            </Card>
          </CardGroup>
        </div>
        
        <ToastContainer position="top-right" autoClose={5000} />
      </div>
      
      <FooterApp />
    </div>
  );
};

export default VentaPedido;
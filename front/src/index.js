import React from "react";
import ReactDOM from "react-dom/client";
import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import { AppProvider } from "./components/Navbar/AppContext";
import "./index.css";
import LoginApp from "./components/Login/LoginApp";
import Principal from "./components/Principal/principal";
import 'bootstrap/dist/css/bootstrap.min.css';
import Registrar from './components/Usuarios/Registrar';
import Categoria from './components/Categoria/CategoriaApp';
import Usuarios from './components/Usuarios/GestionarUsuario';
import ProductoApp from './components/Productos/ProductoApp'; 
import ComentarioApp from './components/Comentario/ComentarioApp';
import PromocionApp from './components/Promocion/PromocionApp';
import TipoPagoApp from './components/TipoPago/TipoPagoApp';
import PedidosApp from './components/Pedido/PedidosApp';
import VentaPedido from './components/ControlVentaPedido/VentaPedido';
import ListaProductosApp from './components/Catalogo/ListaProductosApp';
import PerfilUsuario from './components/DetallesCliente/PerfilUsuario';
import Dashboard from './components/DetallesCliente/Dashboard';
import Orders from './components/DetallesCliente/Orders';
import SideBarUsuario from './components/DetallesCliente/SideBarUsuario';
import DireccionUsuario from './components/DetallesCliente/DireccionUsuario';
import ResetPassword from "./components/Login/ResetPasswod";
import { CartProvider } from './contexto/ContextoCarrito';
import ResPagina from './paginas/ResPagina';
import CerdoPagina from './paginas/CerdoPagina';
import PolloPagina from './paginas/PolloPagina';
import ProductosVariosPagina from './paginas/ProductosVariosPagina';
import ProductosDestacadosPagina from './paginas/ProductosDestacadosPagina';
import Historia from "./components/Home/Historia";


// Componente para proteger rutas
const PrivateRoute = ({ children }) => {
  const token = localStorage.getItem("token");
  return token ? <div className="main-content">{children}</div> : <Navigate to="/" />;
};

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <AppProvider>
    <CartProvider> 
      <Router>
        <Routes>
          <Route path="/" element={<LoginApp />} />
          <Route path="/pedido" element={<LoginApp initialPage="pedido" />} />
          <Route path="/historia" element={<Historia initialPage="historia" />} />
          <Route path="/register" element={<Registrar />} />
          <Route path="/ResetPassword" element={<ResetPassword/>} /> 
          <Route path="/principal" element={<PrivateRoute><Principal /></PrivateRoute>} />
          <Route path="/CategoriaApp" element={<PrivateRoute><Categoria /></PrivateRoute>} />
          <Route path="/GestionarUsuario" element={<PrivateRoute><Usuarios /></PrivateRoute>} />
          <Route path="/ComentarioApp" element={<PrivateRoute><ComentarioApp /></PrivateRoute>} />
          <Route path="/ProductoApp" element={<PrivateRoute><ProductoApp /></PrivateRoute>} />
          <Route path="/PromocionApp" element={<PrivateRoute><PromocionApp /></PrivateRoute>} />
          <Route path="/TipoPagoApp" element={<PrivateRoute><TipoPagoApp /></PrivateRoute>} />
          <Route path="/PedidosApp" element={<PrivateRoute><PedidosApp /></PrivateRoute>} />
          <Route path="/VentaPedido" element={<PrivateRoute><VentaPedido /></PrivateRoute>} />
          <Route path="/ListaProductosApp" element={<ListaProductosApp />} />
          <Route path="/PerfilUsuario" element={<PrivateRoute><PerfilUsuario /></PrivateRoute>} />
          <Route path="/Dashboard" element={<PrivateRoute><Dashboard /></PrivateRoute>} />
          <Route path="/SideBarUsuario" element={<PrivateRoute><SideBarUsuario /></PrivateRoute>} />
          <Route path="/DireccionUsuario" element={<PrivateRoute><DireccionUsuario /></PrivateRoute>} />
          <Route path= "/Orders" element={<PrivateRoute><Orders /></PrivateRoute>} />
          <Route path="/verOrden" element={<LoginApp initialPage="verOrden" />} />
          <Route path="/cortes-de-res" element={<ResPagina />} />
          <Route path="/cortes-de-cerdo" element={<CerdoPagina />} />
          <Route path="/cortes-de-pollo" element={<PolloPagina />} />
          <Route path="/productos-varios" element={<ProductosVariosPagina />} />
          <Route path="/productos-destacados" element={<ProductosDestacadosPagina />} />


        </Routes>
      </Router>
    </CartProvider>
  </AppProvider>
);

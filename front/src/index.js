import React from "react";
import ReactDOM from "react-dom/client";
import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import { AppProvider, useAppContext } from "./components/Navbar/AppContext";
import { CartProvider } from './contexto/ContextoCarrito'; // Solo CartProvider, useCart se usa en los componentes
import "./index.css"; // Estilos generales
import 'bootstrap/dist/css/bootstrap.min.css'; // Bootstrap
import "./components/styles.min.css"; // Tus estilos adicionales

// Componentes de Página y Globales
import LoginApp from "./components/Login/LoginApp";
import Historia from './components/Home/Historia';
import Registrar from './components/Usuarios/Registrar';
import ResetPassword from "./components/Login/ResetPasswod";
import AuthOffcanvas from './components/Auth/AuthOffcanvas';   // <--- IMPORTADO
import CarritoApp from './components/Carrito/CarritoApp';     // <--- IMPORTADO

// Tus otras páginas y componentes de rutas privadas/públicas
import Principal from "./components/Principal/principal";
import Categoria from './components/Categoria/CategoriaApp';
import Usuarios from './components/Usuarios/GestionarUsuario';
import ProductoApp from './components/Productos/ProductoApp';
import ComentarioApp from './components/Comentario/ComentarioApp';
import PromocionApp from './components/Promocion/PromocionApp';
import TipoPagoApp from './components/TipoPago/TipoPagoApp';
import PedidosApp from './components/Pedido/PedidosApp';
import VentaPedido from './components/ControlVentaPedido/VentaPedido';
import ListaProductosApp from './components/Catalogo/ListaProductosApp'; // Para rutas de catálogo si no van por LoginApp
import PerfilUsuario from './components/DetallesCliente/PerfilUsuario';
import Dashboard from './components/DetallesCliente/Dashboard';
import Orders from './components/DetallesCliente/Orders';
// import SideBarUsuario from './components/DetallesCliente/SideBarUsuario'; // Usualmente parte de Dashboard/Perfil
import DireccionUsuario from './components/DetallesCliente/DireccionUsuario';
import ResPagina from './paginas/ResPagina';
import CerdoPagina from './paginas/CerdoPagina';
import PolloPagina from './paginas/PolloPagina';
import ProductosVariosPagina from './paginas/ProductosVariosPagina';
import ProductosDestacadosPagina from './paginas/ProductosDestacadosPagina';
import { ToastContainer } from 'react-toastify'; // Para notificaciones globales
import 'react-toastify/dist/ReactToastify.css';


// Componente para proteger rutas
const PrivateRoute = ({ children }) => {
  const token = localStorage.getItem("token");
  // Podrías añadir una clase al div que envuelve children si es necesario para estilos de layout
  return token ? children : <Navigate to="/" />;
};

// Componente envoltorio para incluir los Offcanvas globales y ToastContainer
const AppLayout = ({ children }) => {
  // No es estrictamente necesario consumir contextos aquí si los Offcanvas los usan internamente.
  // Pero es un buen lugar para colocar elementos que deben estar en todas las páginas.
  return (
    <>
      {children} {/* Esto serán tus <Routes> */}
      <AuthOffcanvas /> {/* AuthOffcanvas usará useAppContext internamente */}
      <CarritoApp />  {/* CarritoApp usará useCart internamente */}
      <ToastContainer
        position="top-right"
        autoClose={3000}
        hideProgressBar={false}
        newestOnTop={false}
        closeOnClick
        rtl={false}
        pauseOnFocusLoss
        draggable
        pauseOnHover
        theme="light" // o "dark" o "colored"
      />
    </>
  );
};

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <React.StrictMode> {/* Es buena práctica usarlo en desarrollo */}
    <AppProvider>
      <CartProvider>
        <Router>
          <AppLayout> {/* AppLayout envuelve las rutas */}
            <Routes>
              {/* Rutas Públicas */}
              <Route path="/" element={<LoginApp />} /> {/* Contenido principal de la página de inicio */}
              <Route path="/historia" element={<Historia />} />
              <Route path="/register" element={<Registrar />} />
              <Route path="/ResetPassword" element={<ResetPassword />} />
              <Route path="/cortes-de-res" element={<ResPagina />} />
              <Route path="/cortes-de-cerdo" element={<CerdoPagina />} />
              <Route path="/cortes-de-pollo" element={<PolloPagina />} />
              <Route path="/productos-varios" element={<ProductosVariosPagina />} />
              <Route path="/productos-destacados" element={<ProductosDestacadosPagina />} />

              {/* Rutas que podrían estar en LoginApp o ser independientes */}
              <Route path="/pedido" element={<LoginApp initialPage="pedido" />} /> {/* Si PedidoCrud es parte de LoginApp */}
              <Route path="/verOrden" element={<LoginApp initialPage="verOrden" />} /> {/* Si MostrarOrdenApp es parte de LoginApp */}

              {/* Rutas Privadas */}
              <Route path="/principal" element={<PrivateRoute><Principal /></PrivateRoute>} />
              <Route path="/CategoriaApp" element={<PrivateRoute><Categoria /></PrivateRoute>} />
              <Route path="/GestionarUsuario" element={<PrivateRoute><Usuarios /></PrivateRoute>} />
              <Route path="/ComentarioApp" element={<PrivateRoute><ComentarioApp /></PrivateRoute>} />
              <Route path="/ProductoApp" element={<PrivateRoute><ProductoApp /></PrivateRoute>} />
              <Route path="/PromocionApp" element={<PrivateRoute><PromocionApp /></PrivateRoute>} />
              <Route path="/TipoPagoApp" element={<PrivateRoute><TipoPagoApp /></PrivateRoute>} />
              <Route path="/PedidosApp" element={<PrivateRoute><PedidosApp /></PrivateRoute>} />
              <Route path="/VentaPedido" element={<PrivateRoute><VentaPedido /></PrivateRoute>} />
              <Route path="/PerfilUsuario" element={<PrivateRoute><PerfilUsuario /></PrivateRoute>} />
              <Route path="/Dashboard" element={<PrivateRoute><Dashboard /></PrivateRoute>} />
              <Route path="/DireccionUsuario" element={<PrivateRoute><DireccionUsuario /></PrivateRoute>} />
              <Route path="/Orders" element={<PrivateRoute><Orders /></PrivateRoute>} />

              {/* Considera si ListaProductosApp debería ser una ruta específica o parte de LoginApp/Home */}
              {/* <Route path="/productos" element={<ListaProductosApp />} /> */}

              {/* Ruta por defecto o página 404 si es necesario */}
              {/* <Route path="*" element={<Navigate to="/" />} /> */}
            </Routes>
          </AppLayout>
        </Router>
      </CartProvider>
    </AppProvider>
  </React.StrictMode>
);
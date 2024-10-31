import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import './index.css';
import LoginApp from './components/Login/LoginApp';
import Principal from './components/principal';
import SideBar from './components/SideBar';
import 'bootstrap/dist/css/bootstrap.min.css';
import Registrar from './components/Usuarios/Registrar';
import Categoria from './components/Categoria/CategoriaApp';
import Usuarios from './components/Usuarios/GestionarUsuario';
import ProductoApp from './components/Productos/ProductoApp'; // Asegúrate de que esta ruta sea correcta

// Componente para proteger rutas y mostrar el sidebar si el usuario está autenticado
const PrivateRoute = ({ children }) => {
  const token = localStorage.getItem('token');
  return token ? (
    <div className="main-container">
      <SideBar /> {/* Sidebar solo visible si el usuario está autenticado */}
      <div className="main-content">
        {children}
      </div>
    </div>
  ) : (
    <Navigate to="/" />
  );
};

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <Router>
    <Routes>
      <Route path="/" element={<LoginApp />} />
      <Route path="/principal" element={<PrivateRoute><Principal /></PrivateRoute>} />
      <Route path="/register" element={<Registrar />} />
      <Route path="/CategoriaApp" element={<PrivateRoute><Categoria /></PrivateRoute>} />
      <Route path="/GestionarUsuario" element={<PrivateRoute><Usuarios /></PrivateRoute>} />
      <Route path="/ProductoApp" element={<PrivateRoute><ProductoApp /></PrivateRoute>} /> {/* Aquí es donde estaba el error */}
    </Routes>
  </Router>
);

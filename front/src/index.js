import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import './index.css';
import LoginApp from './components/Login/LoginApp';
import Principal from './components/principal';
import SideBar from './components/SideBar';
import 'bootstrap/dist/css/bootstrap.min.css';
import { Navigate } from 'react-router-dom';
import Registrar from './components/Usuarios/Registrar';
import Categoria from './components/Categoria/CategoriaApp';
import Usuarios from './components/Usuarios/GestionarUsuario';

// Componente para proteger rutas
const PrivateRoute = ({ children }) => {
  const token = localStorage.getItem('token');
  return token ? children : <Navigate to="/" />;
};

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <Router>
    <div className="main-container">
      <SideBar /> {/* Sidebar siempre visible */}
      <div className="main-content">
        <Routes>
          <Route path="/" element={<LoginApp />} />
          <Route path="/principal" element={<PrivateRoute><Principal /></PrivateRoute>} />
          <Route path="/register" element={<Registrar />} />
          <Route path="/CategoriaApp" element={<PrivateRoute><Categoria /></PrivateRoute>} />
          <Route path="/GestionarUsuario" element={<PrivateRoute><Usuarios /></PrivateRoute>} />
        </Routes>
      </div>
    </div>
  </Router>
);

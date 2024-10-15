import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import './index.css';
import LoginApp from './components/Login/LoginApp';
import Principal from './components/principal';
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
    <Routes>
      <Route path="/" element={<LoginApp />} />
      <Route path="/principal" element={
        <PrivateRoute>
          <Principal />
        </PrivateRoute>
      } />
      <Route path="/register" element={<Registrar />} />
      <Route path="/CategoriaApp" element={
        <PrivateRoute>
          <Categoria />
        </PrivateRoute>
      } />
      <Route path="/GestionarUsuario" element={
        <PrivateRoute>
          <Usuarios />
        </PrivateRoute>
      } />
    </Routes>
  </Router>
);

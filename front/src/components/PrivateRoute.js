// PrivateRoute.js

import React from 'react';
import { Route, Navigate } from 'react-router-dom';

const PrivateRoute = ({ element: Element, allowedRoles, ...rest }) => {
  const token = localStorage.getItem('token');
  const rol = localStorage.getItem('nombreRol'); 

  return (
    <Route
      {...rest}
      element={
        token && allowedRoles.includes(rol) ? <Element /> : <Navigate to="/" /> 
      }
    />
  );
};

export default PrivateRoute;

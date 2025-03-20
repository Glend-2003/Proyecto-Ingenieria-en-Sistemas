import React from 'react';
import ListaProductosApp from '../components/Catalogo/ListaProductosApp';

const ResPagina = () => {
  return (
    <div>
      <h1>Cortes de Res</h1>
      <ListaProductosApp categoria="Res" />
    </div>
  );
};

export default ResPagina;
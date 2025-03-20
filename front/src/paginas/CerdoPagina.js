import React from 'react';
import ListaProductosApp from '../components/Catalogo/ListaProductosApp';

const CerdoPagina = () => {
  return (
    <div>
      <h1>Cortes de Cerdo</h1>
      <ListaProductosApp categoria="Cerdo" />
    </div>
  );
};

export default CerdoPagina;
import React from 'react';
import ListaProductosApp from '../components/Catalogo/ListaProductosApp';

const PolloPagina = () => {
  return (
    <div>
      <h1>Cortes de Pollo</h1>
      <ListaProductosApp categoria="Pollo" />
    </div>
  );
};

export default PolloPagina;
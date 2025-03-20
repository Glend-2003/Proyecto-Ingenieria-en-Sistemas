import React from 'react';
import ListaProductosApp from '../components/Catalogo/ListaProductosApp';

const ProductosDestacadosPagina = () => {
  return (
    <div>
      <h1>Productos Destacados</h1>
      <ListaProductosApp categoria="Destacados" />
    </div>
  );
};

export default ProductosDestacadosPagina;
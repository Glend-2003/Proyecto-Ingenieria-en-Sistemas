import React from 'react';
import ListaProductosApp from '../components/Catalogo/ListaProductosApp';
import FooterApp from '../components/Footer/FooterApp';
import NavbarApp from '../components/Navbar/NavbarApp';

const ProductosVariosPagina = () => {
  return (
    <div>
      <NavbarApp />
      <h1>Productos Varios</h1>
      <ListaProductosApp categoria="Varios" />
      <FooterApp />
    </div>
  );
};

export default ProductosVariosPagina;
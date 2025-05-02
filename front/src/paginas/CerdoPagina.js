import React from 'react';
import ListaProductosApp from '../components/Catalogo/ListaProductosApp';
import FooterApp from '../components/Footer/FooterApp';
import NavbarApp from '../components/Navbar/NavbarApp';

const CerdoPagina = () => {
  return (
    <div>
      <NavbarApp />
      <h1>Cortes de Cerdo</h1>
      <ListaProductosApp categoria="Cerdo" />
      <FooterApp />
    </div>
  );
};

export default CerdoPagina;
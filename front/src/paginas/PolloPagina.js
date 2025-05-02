import React from 'react';
import ListaProductosApp from '../components/Catalogo/ListaProductosApp';
import FooterApp from '../components/Footer/FooterApp';
import NavbarApp from '../components/Navbar/NavbarApp';

const PolloPagina = () => {
  return (
    <div>
      <NavbarApp />
      <h1>Cortes de Pollo</h1>
      <ListaProductosApp categoria="Pollo" />
      <FooterApp />
    </div>
  );
};

export default PolloPagina;
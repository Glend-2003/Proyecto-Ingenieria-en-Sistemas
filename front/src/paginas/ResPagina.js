import React, { useEffect } from 'react';
import ListaProductosApp from '../components/Catalogo/ListaProductosApp';

const ResPagina = () => {
  useEffect(() => {
    console.log("Página de cortes de res cargada");
  }, []);

  return (
    <div>
      <h1 className="text-center my-4">Cortes de Res</h1>
      <ListaProductosApp categoria="Res" />
    </div>
  );
};

export default ResPagina;
// src/components/Login/LoginApp.js
import React, { useState, useEffect } from "react";
// ... (otros imports necesarios como NavbarApp, FooterApp, CarritoApp (si aún no es global), componentes de contenido)
import ListaProductosApp from "../Catalogo/ListaProductosApp.js";
import PedidoCrud from "../Pedido/PedidoCrud.js";
import Historia from "../Home/Historia.js";
import MostrarOrdenApp from "../Orden/MostrarOdenApp.js";
import ResPagina from "../../paginas/ResPagina.js";
import CerdoPagina from "../../paginas/CerdoPagina.js";
import PolloPagina from "../../paginas/PolloPagina.js";
import ProductosVariosPagina from "../../paginas/ProductosVariosPagina.js";
import ProductosDestacadosPagina from "../../paginas/ProductosDestacadosPagina.js";
import NavbarApp from "../Navbar/NavbarApp.js";
import FooterApp from "../Footer/FooterApp.js";
import { useAppContext } from "../Navbar/AppContext";
import { useLocation } from "react-router-dom";
// Remueve los imports de Offcanvas, FaEye, FaEyeSlash, etc., si solo se usaban para el Offcanvas de login

function LoginApp({ initialPage = "home" }) {
  const [currentPage, setCurrentPage] = useState(initialPage);
  const location = useLocation();
  const { addToCart } = useAppContext(); // O useCart si es para el carrito

  // Sincronizar currentPage con la ruta actual
  useEffect(() => {
    const pathToPage = {
      "/pedido": "pedido",
      "/historia": "historia", // Si /historia es pública, no necesitaría pasar por LoginApp
      "/verOrden": "verOrden",
      "/cortes-de-res": "res",
      "/cortes-de-cerdo": "cerdo",
      "/cortes-de-pollo": "pollo",
      "/productos-varios": "varios",
      "/productos-destacados": "destacados",
      "/": "home",
    };
    const page = pathToPage[location.pathname] || initialPage;
    setCurrentPage(page);
  }, [location.pathname, initialPage]);

  const renderMainContent = () => {
    switch (currentPage) {
      case "pedido":
        return <PedidoCrud />;
      // case "historia": ya no se maneja aquí si se hizo pública
      //   return <Historia />;
      case "verOrden":
        return <MostrarOrdenApp />;
      // Las siguientes rutas ya tienen sus propios componentes de página (ResPagina, CerdoPagina, etc.)
      // por lo que LoginApp solo debería manejar la ruta "/" o su contenido por defecto.
      // Si LoginApp es solo para la página de inicio, simplifica este switch.
      case "home":
      default:
        // Si ListaProductosApp es el contenido principal de "/"
        return <ListaProductosApp categoria={null} />; // Pasa null o un valor por defecto para la categoría
    }
  };

  return (
    <div className="page-container">
      {/* NavbarApp se renderiza aquí, y usará el AuthOffcanvas global */}
      <NavbarApp />

      {/* YA NO SE RENDERIZA EL OFFCANVAS DE LOGIN AQUÍ */}

      <main className="flex-grow-2" style={{ marginTop: "0px" }}> {/* Ajusta el marginTop si es necesario */}
        {renderMainContent()}
        {/* CarritoApp también será global, así que no se renderiza aquí tampoco */}
      </main>
      <FooterApp />
    </div>
  );
}

export default LoginApp;
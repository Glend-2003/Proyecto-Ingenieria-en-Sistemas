import React, { useState, useEffect } from "react"
import { Navbar as BootstrapNavbar, Container, Nav, Badge } from "react-bootstrap"
import DropDown from "../DropDown/DropDown"
import { useAppContext } from "../Navbar/AppContext"
import 'bootstrap/dist/css/bootstrap.min.css';
import '../styles.min.css';
import { Link } from 'react-router-dom';
import './Navbar.css';

const NavbarApp = () => {
  // Usar el contexto para obtener estados y funciones
  const { handleShowSidebar, handleShowCart, idUsuario, cart } = useAppContext()

   // Estado para controlar si estamos en la parte superior o no
   const [isScrolled, setIsScrolled] = useState(false)

   // Efecto para detectar el scroll
   useEffect(() => {
     const handleScroll = () => {
       // Consideramos "scrolled" cuando bajamos más de 50px
       if (window.scrollY > 50) {
         setIsScrolled(true)
       } else {
         setIsScrolled(false)
       }
     }
 
     // Añadir el event listener
     window.addEventListener("scroll", handleScroll)
 
     // Limpiar el event listener cuando el componente se desmonte
     return () => {
       window.removeEventListener("scroll", handleScroll)
     }
   }, [])
     // Clases dinámicas basadas en el estado de scroll
  const navbarClasses = `navbar-transition ${isScrolled ? "navbar-scrolled" : "navbar-top"}`

  return (
    <BootstrapNavbar
    expand="lg"
    variant="dark"
    style={{ backgroundColor: "#001f3f" }}
    className={navbarClasses}
    fixed="top"
  >
      <Container>
      
            
        <BootstrapNavbar.Brand> 
          <Link to="/Historia" style={{ color: 'white', textDecoration: 'none' }}>
          Carnicería La Bendición
          </Link>
        </BootstrapNavbar.Brand>

        {/* Navigation Links - Desktop */}
  <nav className="hidden md:flex items-center space-x-6">
         
          </nav>

        <BootstrapNavbar.Toggle aria-controls="basic-navbar-nav" />
        <Nav>
          <Nav.Link as={Link} to="/cortes-de-res" className="text-sm font-medium hover:underline">
              CORTES DE RES
              </Nav.Link>
              <Nav.Link as={Link} to="/cortes-de-cerdo" className="text-sm font-medium hover:underline">
                CORTES DE CERDO
              </Nav.Link>
              <Nav.Link as={Link} to="/cortes-de-pollo" className="text-sm font-medium hover:underline">
                CORTES DE POLLO
              </Nav.Link>
              <Nav.Link as={Link} to="/productos-varios" className="text-sm font-medium hover:underline">
                PRODUCTOS VARIOS
            </Nav.Link>
          <Nav.Link as={Link} to="/productos-destacados" className="text-sm font-medium hover:underline">
            PRODUCTOS DESTACADOS
          </Nav.Link>
        </Nav>
        <BootstrapNavbar.Collapse id="basic-navbar-nav">
          <Nav className="ms-auto">
        
          
            <div>
              <Nav.Link onClick={handleShowSidebar}>
                <DropDown
                  icon={
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="1.5em"
                      height="1.5em"
                      fill="currentColor"
                      className="bi bi-person"
                      viewBox="0 0 16 16"
                    >
                      <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664z" />
                    </svg>
                  }
                  idUsuario={idUsuario}
                />
              </Nav.Link>
            </div>
            <Nav.Link onClick={handleShowCart}>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="1.5em"
                height="1.5em"
                fill="currentColor"
                className="bi bi-cart"
                viewBox="0 0 16 16"
              >
                <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5M3.102 4l1.313 7h8.17l1.313-7zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4m7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4m-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2m7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2" />
              </svg>
              {cart.length > 0 && <Badge bg="danger">{cart.length}</Badge>}
            </Nav.Link>
          </Nav>
        </BootstrapNavbar.Collapse>
      </Container>
    </BootstrapNavbar>
  )
}

export default NavbarApp


import React, { useState } from "react";
import { useNavigate } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import { Dropdown, DropdownToggle, DropdownMenu, DropdownItem } from "reactstrap";

const DropDown = ({ icon, idUsuario }) => {
    const [isOpen, setIsOpen] = useState(false);
    const navigate = useNavigate();
    
    const toggle = () => setIsOpen(!isOpen);

    const handleShowMenu = (idUsuario) => {
        if(!idUsuario){
            setIsOpen(false);
        }else{
            setIsOpen(true);
        }
    }

    const handleLogout = () => {
        localStorage.removeItem('token');
        localStorage.removeItem('correoUsuario');
        localStorage.removeItem('nombreUsuario');
        localStorage.removeItem('nombreRol');
        localStorage.removeItem('idUsuario');
        navigate('/');
    };
    
    // Función para manejar la navegación
    const handleNavigation = (path) => {
        navigate(path);
        setIsOpen(false);
    };
    
    return (
        <Dropdown
            className="custom-dropdown"
            isOpen={isOpen}
            toggle={toggle}
            onMouseEnter={() => handleShowMenu(idUsuario)}
            onMouseLeave={() => setIsOpen(false)}
            direction="left"
        >
            <DropdownToggle tag="span" className="cursor-pointer">
                {icon} {/* Se usa el icono que viene de App */}
            </DropdownToggle>
            <DropdownMenu className="dropdown-menu">
                <DropdownItem header>perfil</DropdownItem>
                <DropdownItem onClick={() => handleNavigation('/Dashboard')} className="hover:bg-gray-700">
                    Panel
                </DropdownItem>
                <DropdownItem onClick={() => handleNavigation('/')} className="hover:bg-gray-700">
                    Pedidos
                </DropdownItem>
                <DropdownItem onClick={() => handleNavigation('/')} className="hover:bg-gray-700">
                    Comprobantes
                </DropdownItem>
                <DropdownItem onClick={() => handleNavigation('/')} className="hover:bg-gray-700">
                    Direccion
                </DropdownItem>
                <DropdownItem onClick={() => handleNavigation('/PerfilUsuario')} className="hover:bg-gray-700">
                    Detalles de la cuenta
                </DropdownItem>
                <DropdownItem onClick={handleLogout}>
                    Cerrar sesión
                </DropdownItem>
            </DropdownMenu>
        </Dropdown>
    );
};

export default DropDown;
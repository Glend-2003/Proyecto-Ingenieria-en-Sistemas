import React, { useState, useEffect } from "react";
import { useNavigate } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import { Dropdown, DropdownToggle, DropdownMenu, DropdownItem } from "reactstrap";
import './DropDown.css';

const DropDown = ({ icon, idUsuario }) => {
    const [isOpen, setIsOpen] = useState(false);
    const navigate = useNavigate();
    
    const toggle = () => {
        // Solo permite alternar si hay un usuario
        if (idUsuario) {
            setIsOpen(!isOpen);
        }
    };

    // Manejo del hover
    const handleMouseEnter = () => {
        if (idUsuario) {
            setIsOpen(true);
        }
    };

    const handleMouseLeave = () => {
        setIsOpen(false);
    };

    const handleLogout = () => {
        localStorage.removeItem('token');
        localStorage.removeItem('correoUsuario');
        localStorage.removeItem('nombreUsuario');
        localStorage.removeItem('nombreRol');
        localStorage.removeItem('idUsuario');
        localStorage.removeItem('rememberedEmail');
        localStorage.removeItem('rememberedPassword');
        navigate('/');
        setIsOpen(false);
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
            onMouseEnter={handleMouseEnter}
            onMouseLeave={handleMouseLeave}
        >
            <DropdownToggle tag="span" className="cursor-pointer">
                {icon}
            </DropdownToggle>
            <DropdownMenu className="dropdown-menu-custom" container="body">
                <DropdownItem header>PERFIL</DropdownItem>
                <DropdownItem onClick={() => handleNavigation('/Dashboard')} className="dropdown-item-custom">
                    Panel
                </DropdownItem>
                <DropdownItem onClick={() => handleNavigation('/')} className="dropdown-item-custom">
                    Pedidos
                </DropdownItem>
                <DropdownItem onClick={() => handleNavigation('/')} className="dropdown-item-custom">
                    Comprobantes
                </DropdownItem>
                <DropdownItem onClick={() => handleNavigation('/DireccionUsuario')} className="dropdown-item-custom">
                    Dirección
                </DropdownItem>
                <DropdownItem onClick={() => handleNavigation('/PerfilUsuario')} className="dropdown-item-custom">
                    Detalles de la cuenta
                </DropdownItem>
                <DropdownItem divider />
                <DropdownItem onClick={handleLogout} className="dropdown-item-logout">
                    Cerrar sesión
                </DropdownItem>
            </DropdownMenu>
        </Dropdown>
    );
};

export default DropDown;
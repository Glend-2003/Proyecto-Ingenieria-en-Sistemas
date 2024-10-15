import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import { toast, ToastContainer } from 'react-toastify'; // Importar toast y ToastContainer
import 'react-toastify/dist/ReactToastify.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import '../styles.min.css';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faCheck, faTrash, faExclamationTriangle } from '@fortawesome/free-solid-svg-icons';

const Registrar = () => {
    const [correoUsuario, setEmail] = useState('');
    const [nombreUsuario, setName] = useState('');
    const [primerApellido, setFirstSurname] = useState('');
    const [segundoApellido, setSecondSurname] = useState('');
    const [contraseniaUsuario, setPassword] = useState('');
    const [verifyPassword, setVerifyPassword] = useState('');
    const [emailErrorMsg, setEmailErrorMsg] = useState('');
    const [passwordErrorMsg, setPasswordErrorMsg] = useState('');
    const navigate = useNavigate();

    const validateEmail = (correoUsuario) => {
        const regex = /^[^@]+@[^@]+\.[^@]+$/;
        return regex.test(correoUsuario);
    };

    const handleEmailChange = (e) => {
        setEmail(e.target.value);
        if (validateEmail(e.target.value)) {
            setEmailErrorMsg('');
        } else {
            setEmailErrorMsg('Correo inválido');
           
        }
    };

    const handleNameChange = (e) => {
        setName(e.target.value);
    };

    const handleFirstSurnameChange = (e) => {
        setFirstSurname(e.target.value);
    };

    const handleSecondSurnameChange = (e) => {
        setSecondSurname(e.target.value);
    };

    const handlePasswordChange = (e) => {
        setPassword(e.target.value);
        if (e.target.value === verifyPassword) {
            if (e.target.value.length >= 8) {
                setPasswordErrorMsg('');
            } else {
                setPasswordErrorMsg('La contraseña debe tener al menos 8 caracteres');
                toast.error('La contraseña debe tener al menos 8 caracteres');
            }
        } else {
            setPasswordErrorMsg('Las contraseñas no coinciden');
           
        }
    };

    const handleVerifyPasswordChange = (e) => {
        setVerifyPassword(e.target.value);
        if (e.target.value === contraseniaUsuario) {
            if (e.target.value.length >= 8) {
                setPasswordErrorMsg('');
            } else {
                setPasswordErrorMsg('La contraseña debe tener al menos 8 caracteres');
                toast.error('La contraseña debe tener al menos 8 caracteres');
            }
        } else {
            setPasswordErrorMsg('Las contraseñas no coinciden');
            
        }
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        if (correoUsuario && nombreUsuario && primerApellido && segundoApellido && contraseniaUsuario) {
            if (emailErrorMsg === '' && passwordErrorMsg === '') {
                // Handle form submission
                axios.post('http://localhost:8080/usuario/registrar', {
                    correoUsuario: correoUsuario,
                    nombreUsuario: nombreUsuario,
                    primerApellido: primerApellido,
                    segundoApellido: segundoApellido,
                    contraseniaUsuario: contraseniaUsuario
                })
                .then(response => {
                    console.log('Usuario registrado con éxito:', response.data);
                    toast.success('Usuario registrado con éxito', {
                        autoClose: 1500,
                        onClose: () => {
                            navigate('../');
                        }
                    });
                })
                .catch(error => {
                    if (error.response) {
                        console.error('Error de respuesta del servidor:', error.response.data);
                        toast.error('Error de respuesta del servidor');
                    } else if (error.request) {
                        console.error('No hubo respuesta del servidor:', error.request);
                        toast.error('No hubo respuesta del servidor');
                    } else {
                        console.error('Error en la solicitud:', error.message);
                        toast.error('Error en la solicitud');
                    }
                });
            }
        } else {
            console.error('Error: Todos los campos son obligatorios');
            toast.error('Todos los campos son obligatorios');
        }
    };

    const handleNoAccountClick = () => {
        navigate('../');
    };
    return (
        <div className="container" style={{ position: 'absolute', left: 0, right: 0, top: '50%', transform: 'translateY(-50%)' }}>
            <div className="row d-flex justify-content-center">
                <div className="col-sm-12 col-lg-10 col-xl-9 col-xxl-7 bg-white shadow-lg" style={{ borderRadius: '5px' }}>
                    <div className="p-5">
                        <div className="text-center">
                            <h4 className="text-dark mb-4">Crear una cuenta</h4>
                        </div>
                        <form className="user" onSubmit={handleSubmit}>
                            <div className="mb-3">
                                <input
                                    className="form-control form-control-user"
                                    type="email"
                                    id="email"
                                    placeholder="Correo Electrónico"
                                    required
                                    value={correoUsuario}
                                    onChange={handleEmailChange}
                                    style={{ borderColor: '#d7d7d7', color: '#212529' }}
                                />
                                {emailErrorMsg && <p className="text-danger">{emailErrorMsg}</p>}
                            </div>
                            <div className="row mb-3">
                                <div className="col-sm-6 col-md-4 mb-3 mb-sm-0">
                                    <input
                                        className="form-control form-control-user"
                                        type="text"
                                        placeholder="Nombre"
                                        required
                                        value={nombreUsuario}
                                        onChange={handleNameChange}
                                    />
                                </div>
                                <div className="col-sm-6 col-md-4">
                                    <input
                                        className="form-control form-control-user"
                                        type="text"
                                        placeholder="Primer apellido"
                                        required
                                        value={primerApellido}
                                        onChange={handleFirstSurnameChange}
                                    />
                                </div>
                                <div className="col-sm-6 col-md-4">
                                    <input
                                        className="form-control form-control-user"
                                        type="text"
                                        placeholder="Segundo apellido"
                                        required
                                        value={segundoApellido}
                                        onChange={handleSecondSurnameChange}
                                    />
                                </div>
                            </div>
                            <div className="row mb-3">
                                <div className="col-sm-6 mb-3 mb-sm-0">
                                    <input
                                        className="form-control form-control-user"
                                        type="password"
                                        id="password"
                                        placeholder="Contraseña"
                                        required
                                        value={contraseniaUsuario}
                                        onChange={handlePasswordChange}
                                    />
                                </div>
                                <div className="col-sm-6">
                                    <input
                                        className="form-control form-control-user"
                                        type="password"
                                        id="verifyPassword"
                                        placeholder="Confirmar contraseña"
                                        required
                                        value={verifyPassword}
                                        onChange={handleVerifyPasswordChange}
                                    />
                                </div>
                            </div>
                            {passwordErrorMsg && <p className="text-danger">{passwordErrorMsg}</p>}
                            <button className="btn btn-primary d-block btn-user w-100" id="submitBtn" type="submit" style={{ background: '#042440' }}>
                                Registrar cuenta
                            </button>
                            <hr />
                            <p className="text-center">
                                <span className="text-primary" style={{ cursor: 'pointer' }} onClick={handleNoAccountClick}>
                                   Regresar
                                </span>
                            </p>
                        </form>
                        <ToastContainer /> {/* Contenedor para mostrar los toasts */}
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Registrar;
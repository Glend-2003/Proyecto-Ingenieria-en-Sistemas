import React from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import '../styles.min.css';

const RegistrarForm = ({
    correoUsuario,
    nombreUsuario,
    primerApellido,
    segundoApellido,
    contraseniaUsuario,
    verifyPassword,
    emailErrorMsg,
    passwordErrorMsg,
    handleEmailChange,
    handleNameChange,
    handleFirstSurnameChange,
    handleSecondSurnameChange,
    handlePasswordChange,
    handleVerifyPasswordChange,
    handleSubmit,
}) => {
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
                                    id="correoUsuario"
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
                                        id="nombreUsuario"
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
                                        id="primerApellido"
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
                                        id="segundoApellido"
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
                                        id="contraseniaUsuario"
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
                        </form>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default RegistrarForm;
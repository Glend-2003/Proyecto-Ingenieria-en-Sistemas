import React, { useState, useEffect } from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';

const LoginForm = ({ loginData, setLoginData, login }) => {
  const [form, setForm] = useState({
    correoUsuario: '',
    contraseniaUsuario: '',
  });

  useEffect(() => {
    if (loginData) {
      setForm(loginData);
    }
  }, [loginData]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setForm({
      ...form,
      [name]: value,
    });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // Validaciones simples
    if (!form.correoUsuario || !form.contraseniaUsuario) {
      console.log('Por favor, rellene todos los campos');
      return;
    }

    // Llama a la función login con los datos ingresados
    login(form);
    // Limpiar el formulario
    setForm({
      correoUsuario: '',
      contraseniaUsuario: '',
    });
  };

  return (
    <form onSubmit={handleSubmit} className="text-center">
      <div className="mb-3">
        <input
          className="form-control"
          type="email"
          name="correoUsuario"
          placeholder="Correo"
          value={form.correoUsuario}
          onChange={handleChange}
          required
        />
      </div>
      <div className="mb-3">
        <input
          className="form-control"
          type="password"
          name="contraseniaUsuario"
          placeholder="Contraseña"
          value={form.contraseniaUsuario}
          onChange={handleChange}
          required
        />
      </div>
      <div className="mb-3">
        <button className="btn btn-primary d-block w-100" type="submit">
          Iniciar sesión
        </button>
      </div>
    </form>
  );
};

export default LoginForm;

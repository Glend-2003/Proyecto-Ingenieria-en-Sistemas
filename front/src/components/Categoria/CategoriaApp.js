// CategoriaApp.js
import React, { useState, useEffect } from 'react';
import CategoriaForm from './CategoriaForm';
import axios from 'axios';

const CategoriaApp = () => {
  const [categorias, setCategorias] = useState([]);
  const [categoriaEdit, setCategoriaEdit] = useState(null);

  useEffect(() => {
    cargarCategorias();
  }, []);

  const cargarCategorias = async () => {
    try {
      const response = await axios.get('http://localhost:8080/categoria/');
      setCategorias(response.data);
    } catch (error) {
      console.error('Error al cargar categorías:', error);
    }
  };

  const agregarCategoria = async (categoria) => {
    try {
      if (categoria.idCategoria) {
        await axios.put('http://localhost:8080/categoria/actualizar', categoria);
      } else {
        await axios.post('http://localhost:8080/categoria/agregar', categoria);
      }
      cargarCategorias();
      setCategoriaEdit(null);
    } catch (error) {
      console.error('Error al agregar/actualizar categoría:', error);
    }
  };

  const eliminarCategoria = async (id) => {
    try {
      await axios.delete(`http://localhost:8080/categoria/eliminar/${id}`);
      cargarCategorias();
    } catch (error) {
      console.error('Error al eliminar categoría:', error);
    }
  };

  const editarCategoria = (categoria) => {
    setCategoriaEdit(categoria);
  };

  const actualizarFila = async (categoria) => {
    try {
      await axios.put('http://localhost:8080/categoria/actualizar', categoria);
      cargarCategorias();
    } catch (error) {
      console.error('Error al actualizar categoría:', error);
    }
  };

  return (
    <div>
      <h1>Gestión de Categorías</h1>
      <CategoriaForm onSubmit={agregarCategoria} categoriaEdit={categoriaEdit} />
      <table className="table">
        <thead>
          <tr>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
          {categorias.map((categoria) => (
            <tr key={categoria.idCategoria}>
              <td>
                <input
                  type="text"
                  value={categoria.nombreCategoria}
                  onChange={(e) => setCategorias((prev) => prev.map((c) => c.idCategoria === categoria.idCategoria ? { ...c, nombreCategoria: e.target.value } : c))}
                />
              </td>
              <td>
                <input
                  type="text"
                  value={categoria.descripcionCategoria}
                  onChange={(e) => setCategorias((prev) => prev.map((c) => c.idCategoria === categoria.idCategoria ? { ...c, descripcionCategoria: e.target.value } : c))}
                />
              </td>
              <td>
                <button className="btn btn-danger" onClick={() => eliminarCategoria(categoria.idCategoria)}>Eliminar</button>
                <button className="btn btn-warning" onClick={() => actualizarFila(categoria)}>Guardar Cambios</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default CategoriaApp;
import React, { useState, useEffect } from "react";
import { Star, MessageCircle, Send, AlertCircle } from "lucide-react";
import "./Resena.css";

const Resena = () => {
  const [comentarios, setComentarios] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [usuarioActual, setUsuarioActual] = useState(null);
  const [loadingUsuario, setLoadingUsuario] = useState(false);
  const [newComentario, setNewComentario] = useState({
    nombre: "",
    email: "",
    numCalificacion: 5,
    descripcionComentario: "",
  });

  useEffect(() => {
    fetchComentarios();
    fetchUsuarioActual();
  }, []);

  // Obtener el usuario actual del localStorage
  const fetchUsuarioActual = async () => {
    try {
      setLoadingUsuario(true);
      // Obtener el ID de usuario del localStorage
      const userId = localStorage.getItem("idUsuario");
      
      if (!userId) {
        console.log("No hay usuario logueado");
        setLoadingUsuario(false);
        return;
      }
      
      // Llamar al endpoint para obtener el usuario por ID
      const response = await fetch(`http://localhost:8080/usuario/obtenerPorId/${userId}`);
      
      if (!response.ok) {
        throw new Error("Error al obtener datos del usuario");
      }
      
      const userData = await response.json();
      setUsuarioActual(userData);
      
      // Pre-rellenar el formulario con los datos del usuario
      if (userData) {
        setNewComentario({
          ...newComentario,
          nombre: userData.nombre || "",
          email: userData.correo || "",
        });
      }
      
    } catch (error) {
      console.error("Error al obtener usuario:", error);
    } finally {
      setLoadingUsuario(false);
    }
  };

  const fetchComentarios = async () => {
    try {
      setLoading(true);
      const response = await fetch("http://localhost:8080/comentario/usuario");
      if (!response.ok) {
        throw new Error("Error al cargar los comentarios");
      }
      const data = await response.json();
      setComentarios(data);
      setLoading(false);
    } catch (error) {
      console.error("Error:", error);
      setError("No pudimos cargar los comentarios. Por favor, intente más tarde.");
      setLoading(false);
    }
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setNewComentario({
      ...newComentario,
      [name]: value,
    });
  };

  const handleRatingChange = (rating) => {
    setNewComentario({
      ...newComentario,
      numCalificacion: rating,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      // Verificar si hay un usuario logueado
      const userId = localStorage.getItem("idUsuario");
      
      if (!userId && !usuarioActual) {
        alert("Debes iniciar sesión para dejar un comentario");
        return;
      }
      
      // Crear objeto de comentario para enviar al backend
      const comentarioData = {
        descripcionComentario: newComentario.descripcionComentario,
        numCalificacion: newComentario.numCalificacion,
        verificacion: false, // Por defecto no se muestra hasta que sea aprobado
        usuario: usuarioActual || { idUsuario: parseInt(userId) }
      };

      const response = await fetch("http://localhost:8080/comentario/agregar", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(comentarioData),
      });

      if (!response.ok) {
        throw new Error("Error al enviar el comentario");
      }

      // Resetear el formulario
      setNewComentario({
        nombre: "",
        email: "",
        numCalificacion: 5,
        descripcionComentario: "",
      });

      // Mostrar mensaje de éxito
      alert("¡Gracias por tu comentario! Será revisado antes de publicarse.");
    } catch (error) {
      console.error("Error:", error);
      alert("No pudimos enviar tu comentario. Por favor, intente más tarde.");
    }
  };

  // Función para renderizar estrellas según la calificación
  const renderStars = (rating) => {
    const stars = [];
    for (let i = 1; i <= 5; i++) {
      stars.push(
        <Star
          key={i}
          size={18}
          className={i <= rating ? "star-filled" : "star-empty"}
        />
      );
    }
    return stars;
  };

  // Función para formatear la fecha
  const formatDate = (dateString) => {
    if (!dateString) return "";
    const date = new Date(dateString);
    return date.toLocaleDateString("es-ES", {
      day: "numeric",
      month: "long",
      year: "numeric",
    });
  };

  return (
    <div className="resena-container">
      <h3 className="resena-title">Lo que dicen nuestros clientes</h3>

      {/* Comentarios existentes */}
      <div className="resena-list">
        {loading ? (
          <div className="resena-loading">Cargando comentarios...</div>
        ) : error ? (
          <div className="resena-error">{error}</div>
        ) : comentarios.length === 0 ? (
          <div className="resena-empty">
            No hay comentarios aún. ¡Sé el primero en dejarnos tu opinión!
          </div>
        ) : (
          comentarios.map((comentario) => (
            <div key={comentario.idComentario} className="resena-card">
              <div className="resena-header">
                <div className="resena-user">
                  <div className="resena-avatar">
                    {comentario.nombreUsuario ? comentario.nombreUsuario.charAt(0).toUpperCase() : "U"}
                  </div>
                  <div className="resena-user-info">
                    <h4 className="resena-name">{comentario.nombreUsuario}</h4>
                    <div className="resena-date">
                      {formatDate(comentario.fechaComentario)}
                    </div>
                  </div>
                </div>
                <div className="resena-rating">
                  {renderStars(comentario.numCalificacion)}
                </div>
              </div>
              <div className="resena-content">
                {comentario.descripcionComentario}
              </div>
            </div>
          ))
        )}
      </div>

      {/* Formulario para nuevo comentario */}
      <div className="resena-form-container">
        <h4 className="resena-form-title">
          <MessageCircle size={20} />
          Déjanos tu opinión
        </h4>
        
        {!localStorage.getItem("idUsuario") ? (
          <div className="resena-login-required">
            <AlertCircle size={24} />
            <p>Debes iniciar sesión para dejar un comentario</p>
            <a href="/login" className="resena-login-link">Iniciar sesión</a>
          </div>
        ) : (
          <form className="resena-form" onSubmit={handleSubmit}>
            {usuarioActual && (
              <div className="resena-usuario-info">
                <p>Comentando como: <strong>{usuarioActual.nombreUsuario}</strong></p>
              </div>
            )}
            <div className="resena-form-group">
              <label>Calificación</label>
              <div className="resena-rating-selector">
                {[1, 2, 3, 4, 5].map((star) => (
                  <Star
                    key={star}
                    size={24}
                    className={
                      star <= newComentario.numCalificacion
                        ? "star-selector filled"
                        : "star-selector"
                    }
                    onClick={() => handleRatingChange(star)}
                  />
                ))}
              </div>
            </div>
            <div className="resena-form-group">
              <label htmlFor="descripcionComentario">Tu comentario</label>
              <textarea
                id="descripcionComentario"
                name="descripcionComentario"
                value={newComentario.descripcionComentario}
                onChange={handleInputChange}
                placeholder="Cuéntanos tu experiencia con nuestros productos..."
                required
                rows={4}
              ></textarea>
            </div>
            <button type="submit" className="resena-submit-btn">
              <Send size={16} /> Enviar comentario
            </button>
          </form>
        )}
        <p className="resena-note">
          *Los comentarios son revisados antes de ser publicados
        </p>
      </div>
    </div>
  );
};

export default Resena;
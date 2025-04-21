import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { FaBell, FaTimes, FaCalendarAlt, FaClock, FaCheck, FaTrash } from 'react-icons/fa';
import './NotificacionPedido.css';
import { Toaster, toast } from 'react-hot-toast';

const NotificacionPedido = () => {
    const [noLeidas, setNoLeidas] = useState([]);
    const [leidas, setLeidas] = useState([]);
    const [mostrar, setMostrar] = useState(false);
    const [cargando, setCargando] = useState(true);

    useEffect(() => {
        cargarNotificaciones();
        const intervalo = setInterval(cargarNotificaciones, 30000);
        return () => clearInterval(intervalo);
    }, []);

    const cargarNotificaciones = async () => {
        setCargando(true);
        try {
            const [respNoLeidas, respLeidas] = await Promise.all([
                axios.get("http://localhost:8080/notificacion/", { params: { leidos: 1 } }),
                axios.get("http://localhost:8080/notificacion/", { params: { leidos: 0 } }),
            ]);
            
            // Ordenar por fecha descendente
            const ordenarPorFecha = (a, b) => new Date(b.fechaNotificacion) - new Date(a.fechaNotificacion);
            setNoLeidas([...respNoLeidas.data].sort(ordenarPorFecha));
            setLeidas([...respLeidas.data].sort(ordenarPorFecha));
        } catch (error) {
            console.error("Error al cargar notificaciones:", error);
        }
        setCargando(false);
    };

    const marcarComoLeida = async (id) => {
        try {
            await axios.put(`http://localhost:8080/notificacion/leer/${id}`);
            toast.success('Notificación marcada como leída', {
                icon: '✓',
                style: {
                    borderRadius: '10px',
                    background: '#333',
                    color: '#fff',
                },
            });
            cargarNotificaciones();
        } catch (error) {
            toast.error('Error al marcar como leída');
            console.error("Error al marcar como leída:", error);
        }
    };

    const eliminarNotificacion = async (id) => {
        try {
            await axios.delete(`http://localhost:8080/notificacion/eliminar/${id}`);
            toast.success('Notificación eliminada', {
                icon: '🗑️',
                style: {
                    borderRadius: '10px',
                    background: '#333',
                    color: '#fff',
                },
            });
            cargarNotificaciones();
        } catch (error) {
            toast.error('Error al eliminar notificación');
            console.error("Error al eliminar notificación:", error);
        }
    };

    const formatDateTime = (mysqlDate) => {
        if (!mysqlDate) return { date: 'Fecha no disponible', time: '' };
        try {
            const isoString = mysqlDate.toString().replace(' ', 'T');
            const date = new Date(isoString);
            if (isNaN(date.getTime())) return { date: 'Fecha inválida', time: '' };
            
            return {
                date: date.toLocaleDateString('es-ES', {
                    year: 'numeric',
                    month: 'short',
                    day: 'numeric'
                }),
                time: date.toLocaleTimeString('es-ES', {
                    hour: '2-digit',
                    minute: '2-digit',
                    hour12: true
                })
            };
        } catch (e) {
            console.error('Error al formatear fecha:', e);
            return { date: 'Error en fecha', time: '' };
        }
    };

    return (
        
        <>
        <Toaster 
            position="top-right"
            toastOptions={{
                duration: 3000,
                style: {
                    fontSize: '14px',
                },
            }}
        />
        <div className="notificaciones-contenedor">
            
            <button 
                className="icono-notificacion"
                onClick={() => setMostrar(!mostrar)}
                aria-label={`Notificaciones (${noLeidas.length} sin leer)`}
            >
                <FaBell size={20} />
                {noLeidas.length > 0 && (
                    <span className="contador-notificaciones">
                        {noLeidas.length}
                    </span>
                )}
            </button>

            {mostrar && (
                <div className="panel-notificaciones">
                    <div className="cabecera-panel">
                        <h3>Notificaciones</h3>
                        <button 
                            className="cerrar-panel" 
                            onClick={() => setMostrar(false)}
                            aria-label="Cerrar notificaciones"
                        >
                            <FaTimes />
                        </button>
                    </div>

                    <div className="lista-notificaciones">
                        {cargando ? (
                            <div className="cargando">Cargando notificaciones...</div>
                        ) : (
                            <>
                                {noLeidas.length > 0 && (
                                    <div className="seccion-notificaciones">
                                        <h4 className="titulo-seccion">No leídas ({noLeidas.length})</h4>
                                        {noLeidas.map(notificacion => {
                                            const { date, time } = formatDateTime(notificacion.fechaNotificacion);
                                            return (
                                                <div key={notificacion.idNotificacion} className="notificacion no-leida">
                                                    <div className="contenido-notificacion">
                                                        <div className="usuario-notificacion">
                                                            {notificacion.idUsuario?.correoUsuario || 'Usuario desconocido'}
                                                        </div>
                                                        <div className="mensaje-notificacion">
                                                            {notificacion.descripcionNotificacion}
                                                        </div>
                                                        <div className="fecha-hora-notificacion">
                                                            <span className="hora">{time}</span>
                                                            <span className="fecha">{date}</span>
                                                        </div>
                                                    </div>
                                                    <div className="acciones-notificacion">
                                                        <button
                                                            className="accion-btn marcar-leida"
                                                            onClick={() => marcarComoLeida(notificacion.idNotificacion)}
                                                            title="Marcar como leída"
                                                            aria-label="Marcar como leída"
                                                        >
                                                            <FaCheck />
                                                        </button>
                                                    </div>
                                                </div>
                                            );
                                        })}
                                    </div>
                                )}

                                {leidas.length > 0 && (
                                    <div className="seccion-notificaciones">
                                        <h4 className="titulo-seccion">Leídas ({leidas.length})</h4>
                                        {leidas.map(notificacion => {
                                            const { date, time } = formatDateTime(notificacion.fechaNotificacion);
                                            return (
                                                <div key={notificacion.idNotificacion} className="notificacion leida">
                                                    <div className="contenido-notificacion">
                                                        <div className="usuario-notificacion">
                                                            {notificacion.idUsuario?.correoUsuario || 'Usuario desconocido'}
                                                        </div>
                                                        <div className="mensaje-notificacion">
                                                            {notificacion.descripcionNotificacion}
                                                        </div>
                                                        <div className="fecha-hora-notificacion">
                                                            <span className="hora">{time}</span>
                                                            <span className="fecha">{date}</span>
                                                        </div>
                                                    </div>
                                                    <div className="acciones-notificacion">
                                                        <button
                                                            className="accion-btn eliminar"
                                                            onClick={() => eliminarNotificacion(notificacion.idNotificacion)}
                                                            title="Eliminar notificación"
                                                            aria-label="Eliminar notificación"
                                                        >
                                                            <FaTrash />
                                                        </button>
                                                    </div>
                                                </div>
                                            );
                                        })}
                                    </div>
                                )}

                                {noLeidas.length === 0 && leidas.length === 0 && (
                                    <div className="sin-notificaciones">
                                        <p>No hay notificaciones</p>
                                    </div>
                                )}
                            </>
                        )}
                    </div>
                </div>
            )}
        </div>
        </>
    );
};

export default NotificacionPedido;
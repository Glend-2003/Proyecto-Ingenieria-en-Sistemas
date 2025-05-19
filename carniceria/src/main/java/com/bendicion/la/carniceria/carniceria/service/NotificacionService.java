/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.bendicion.la.carniceria.carniceria.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.bendicion.la.carniceria.carniceria.domain.Notificacion;
import com.bendicion.la.carniceria.carniceria.jpa.NotificacionRepository;
import com.bendicion.la.carniceria.carniceria.jpa.UsuarioRepository;

import jakarta.transaction.Transactional;

@Service
@Primary
public class NotificacionService implements INotificacionService {

    @Autowired
    private NotificacionRepository notificacionRep;
    private UsuarioRepository usuarioRep;

    @Override
    @Transactional
    public List<Notificacion> getNotificacion(Boolean leidos) {
        return notificacionRep.listProcedureNotificacion(leidos);
    }

    @Override
    @Transactional
    public boolean leerNotificacion(int id) {
        try {

            if (!notificacionRep.existsById(id)) {
                System.err.println("La notificacion : " + id + " no existe.");
                return false;
            }

            System.out.println("leyendo notificacion con ID: " + id);
            notificacionRep.leerNotificacion(id);
            return true;
        } catch (Exception e) {
            System.err.println("Error al leer la notificacion con ID: " + id + ". Detalles: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean deleteNotificacion(int id) {
        try {
            System.out.println("Eliminando notificacion con ID: " + id);
            notificacionRep.deleteProcedureNotificacion(id);
            return true;
        } catch (Exception e) {
            System.err.println("Error al eliminar la notificacion con ID: " + id + ". Detalles: " + e.getMessage());
            return false;
        }
    }

    @Override
    public Notificacion addNotificacion(Notificacion notificacion) {
        System.out.println("Agregando notificación...");

        notificacion.setLeidos(true);
        LocalDate fechaActual = LocalDate.now();
        notificacion.setFechaNotificacion(fechaActual);

        String descripcionNotificacion = String.format(
                "El cliente ha cancelado su pedido por medio de la aplicación."
        );

        notificacionRep.saveProcedureNotificacion(
                descripcionNotificacion,
                notificacion.getIdUsuario().getIdUsuario(),
                fechaActual
        );

        return notificacion;
    }

}

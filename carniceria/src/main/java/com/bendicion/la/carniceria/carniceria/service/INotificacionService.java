package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;

import com.bendicion.la.carniceria.carniceria.domain.Notificacion;

import jakarta.transaction.Transactional;

public interface INotificacionService {

    public List<Notificacion> getNotificacion(Boolean leidos);

    @Transactional
    public boolean leerNotificacion(int id);

    @Transactional
    public boolean deleteNotificacion(int id);

    public Notificacion addNotificacion(Notificacion notificacion);
}

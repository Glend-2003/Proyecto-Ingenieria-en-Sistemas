/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.bendicion.la.carniceria.carniceria.service;

import com.bendicion.la.carniceria.carniceria.domain.Notificacion;
import jakarta.transaction.Transactional;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author Dilan
 */
public interface INotificacionService {
    
    public List<Notificacion> getNotificacion(Boolean leidos);
    
    @Transactional
    public boolean leerNotificacion(int id);
    
    @Transactional
    public boolean deleteNotificacion(int id);
    
    public Notificacion addNotificacion(Notificacion notificacion);
}

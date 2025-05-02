/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.bendicion.la.carniceria.carniceria.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Dilan Gutierrez
 */
@Entity
@Table(name = "tbnotificacion")
public class Notificacion {
     @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idNotificacion")
    private int idNotificacion;
    
    @Column(name = "descripcionNotificacion")
    private String descripcionNotificacion;
    
    @ManyToOne()
    @JoinColumn(name = "idUsuario")
    private Usuario idUsuario;
    
    @Column(name = "leidos")
    private boolean leidos;
    
    @Column(name = "fechaNotificacion")
    private LocalDate fechaNotificacion;

    public Notificacion() {
    }

    public Notificacion(int idNotificacion, String descripcionNotificacion, Usuario idUsuario, boolean leidos, LocalDate fechaNotificacion) {
        this.idNotificacion = idNotificacion;
        this.descripcionNotificacion = descripcionNotificacion;
        this.idUsuario = idUsuario;
        this.leidos = leidos;
        this.fechaNotificacion = fechaNotificacion;
    }

    

    /**
     * @return the idNotificacion
     */
    public int getIdNotificacion() {
        return idNotificacion;
    }

    /**
     * @param idNotificacion the idNotificacion to set
     */
    public void setIdNotificacion(int idNotificacion) {
        this.idNotificacion = idNotificacion;
    }

    /**
     * @return the descripcionNotificacion
     */
    public String getDescripcionNotificacion() {
        return descripcionNotificacion;
    }

    /**
     * @param descripcionNotificacion the descripcionNotificacion to set
     */
    public void setDescripcionNotificacion(String descripcionNotificacion) {
        this.descripcionNotificacion = descripcionNotificacion;
    }

    /**
     * @return the idUsuario
     */
    public Usuario getIdUsuario() {
        return idUsuario;
    }

    /**
     * @param idUsuario the idUsuario to set
     */
    public void setIdUsuario(Usuario idUsuario) {
        this.idUsuario = idUsuario;
    }

    /**
     * @return the leidos
     */
    public boolean isLeidos() {
        return leidos;
    }

    /**
     * @param leidos the leidos to set
     */
    public void setLeidos(boolean leidos) {
        this.leidos = leidos;
    }

    /**
     * @return the fechaNotificacion
     */
    public LocalDate getFechaNotificacion() {
        return fechaNotificacion;
    }

    /**
     * @param fechaNotificacion the fechaNotificacion to set
     */
    public void setFechaNotificacion(LocalDate fechaNotificacion) {
        this.fechaNotificacion = fechaNotificacion;
    }
    
    
    
}

package com.bendicion.la.carniceria.carniceria.domain;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

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

    public int getIdNotificacion() {
        return idNotificacion;
    }

    public void setIdNotificacion(int idNotificacion) {
        this.idNotificacion = idNotificacion;
    }

    public String getDescripcionNotificacion() {
        return descripcionNotificacion;
    }

    public void setDescripcionNotificacion(String descripcionNotificacion) {
        this.descripcionNotificacion = descripcionNotificacion;
    }

    public Usuario getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Usuario idUsuario) {
        this.idUsuario = idUsuario;
    }

    public boolean isLeidos() {
        return leidos;
    }

    public void setLeidos(boolean leidos) {
        this.leidos = leidos;
    }

    public LocalDate getFechaNotificacion() {
        return fechaNotificacion;
    }

    public void setFechaNotificacion(LocalDate fechaNotificacion) {
        this.fechaNotificacion = fechaNotificacion;
    }

}

package com.bendicion.la.carniceria.carniceria.domain;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity(name = "tbcomentario")
public class Comentario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idComentario")
    private int idComentario;

    @Column(name = "descripcionComentario")
    private String descripcionComentario;

    @Column(name = "fechaComentario")
    private LocalDateTime fechaComentario;

    @ManyToOne
    @JoinColumn(name = "idUsuario")
    @JsonBackReference
    private Usuario usuario;

    @Column(name = "numCalificacion")
    private int numCalificacion;

    @Column(name = "verificacion")
    private boolean verificacion;

    public Comentario() {

    }

    public Comentario(int idComentario, String descripcionComentario, LocalDateTime fechaComentario, Usuario usuario, int numCalificacion, boolean verificacion) {
        this.idComentario = idComentario;
        this.descripcionComentario = descripcionComentario;
        this.fechaComentario = fechaComentario;
        this.usuario = usuario;
        this.numCalificacion = numCalificacion;
        this.verificacion = verificacion;
    }

    // Getters y Setters
    public int getIdComentario() {
        return idComentario;
    }

    public void setIdComentario(int idComentario) {
        this.idComentario = idComentario;
    }

    public String getDescripcionComentario() {
        return descripcionComentario;
    }

    public void setDescripcionComentario(String descripcionComentario) {
        this.descripcionComentario = descripcionComentario;
    }

    public LocalDateTime getFechaComentario() {
        return fechaComentario;
    }

    public void setFechaComentario(LocalDateTime fechaComentario) {
        this.fechaComentario = fechaComentario;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario Usuario) {
        this.usuario = Usuario;
    }

    public int getNumCalificacion() {
        return numCalificacion;
    }

    public void setNumCalificacion(int numCalificacion) {
        this.numCalificacion = numCalificacion;
    }

    public boolean getVerificacion() {
        return verificacion;
    }

    public void setVerificacion(boolean verificacion) {
        this.verificacion = verificacion;
    }

    @Override
    public String toString() {
        return "Comentario{" + "idComentario=" + idComentario + ", descripcionComentario=" + descripcionComentario + ", fechaComentario=" + fechaComentario + ", usuario=" + usuario + ", numCalificacion=" + numCalificacion + ", verificacion=" + verificacion + '}';
    }

}

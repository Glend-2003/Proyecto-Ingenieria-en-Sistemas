/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.bendicion.la.carniceria.carniceria.domain;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 *
 * @author Dilan Gutierrez
 */
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
    @JoinColumn(name = "idUsuario", nullable = false)
    @JsonBackReference // Evita serialización bidireccional
    private Usuario usuario;

    @Column(name = "numCalificacion")
    private int numCalificacion;

    public Comentario() {

    }

    public Comentario(int idComentario, String descripcionComentario, LocalDateTime  fechaComentario, Usuario usuario, int numCalificacion) {
        this.idComentario = idComentario;
        this.descripcionComentario = descripcionComentario;
        this.fechaComentario = fechaComentario;
        this.usuario = usuario;
        this.numCalificacion = numCalificacion;
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

    public LocalDateTime  getFechaComentario() {
        return fechaComentario;
    }

    public void setFechaComentario(LocalDateTime  fechaComentario) {
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
}

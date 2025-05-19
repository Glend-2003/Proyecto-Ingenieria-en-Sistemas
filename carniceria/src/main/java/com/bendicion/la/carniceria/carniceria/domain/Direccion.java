package com.bendicion.la.carniceria.carniceria.domain;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "tbdireccion")
public class Direccion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idDireccion")
    private int idDireccion;

    @Column(name = "codigoPostalDireccion")
    private String codigoPostalDireccion;

    @Column(name = "descripcionDireccion")
    private String descripcionDireccion;

    @JsonBackReference
    @OneToMany(mappedBy = "direccion", fetch = FetchType.LAZY)
    private List<Usuario> usuario;

    @ManyToOne
    @JoinColumn(name = "idDistrito")
    private Distrito distrito;

    public Direccion() {
        usuario = new ArrayList<>();
    }

    public Direccion(int id, String codigoPostalDireccion, String descripcionDireccion, Distrito distrito) {
        this.idDireccion = id;
        this.codigoPostalDireccion = codigoPostalDireccion;
        this.descripcionDireccion = descripcionDireccion;
        this.distrito = distrito;
    }

    public int getIdDireccion() {
        return idDireccion;
    }

    public void setIdDireccion(int id) {
        this.idDireccion = id;
    }

    public String getCodigoPostal() {
        return codigoPostalDireccion;
    }

    public void setCodigoPostalDireccion(String codigoPostalDireccion) {
        this.codigoPostalDireccion = codigoPostalDireccion;
    }

    public String getDescripcionDireccion() {
        return descripcionDireccion;
    }

    public void setDescripcionDireccion(String descripcionDireccion) {
        this.descripcionDireccion = descripcionDireccion;
    }

    public Distrito getDistrito() {
        return distrito;
    }

    public void setDistrito(Distrito distrito) {
        this.distrito = distrito;
    }

    public List<Usuario> getUsuario() {
        return usuario;
    }

    public void setPersona(List<Usuario> usuario) {
        this.usuario = usuario;
    }
}

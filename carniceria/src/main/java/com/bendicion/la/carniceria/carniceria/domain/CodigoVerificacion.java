package com.bendicion.la.carniceria.carniceria.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

/**
 *
 * @author Jamel Sandí
 */

@Entity
@Table(name = "tbcodigoverificacion")
public class CodigoVerificacion {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idCodigo")
    private int idCodigo;
    
    @Column(name = "numCodigo")
    private String numCodigo;
    
    @OneToOne
    @JoinColumn(name = "idUsuario")
    private Usuario usuario;

    public CodigoVerificacion(int idCodigo, String numCodigo, Usuario usuario) {
        this.idCodigo = idCodigo;
        this.numCodigo = numCodigo;
        this.usuario = usuario;
    }

    public CodigoVerificacion() {
    }

    public void setIdCodigo(int idCodigo) {
        this.idCodigo = idCodigo;
    }

    public void setNumCodigo(String numCodigo) {
        this.numCodigo = numCodigo;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public int getIdCodigo() {
        return idCodigo;
    }

    public String getNumCodigo() {
        return numCodigo;
    }

    public Usuario getUsuario() {
        return usuario;
    }
        
}

package com.bendicion.la.carniceria.carniceria.domain;

import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "tbcarrito")
public class Carrito {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idCarrito")
    private int idCarrito;

    @Column(name = "cantidadCarrito")
    private int cantidadCarrito;

    @ManyToOne
    @JoinColumn(name = "idUsuario", nullable = false)
    private Usuario usuario;

    @Column(name = "montoTotalCarrito")
    private BigDecimal montoTotalCarrito;

    @Column(name = "estadoCarrito")
    private boolean estadoCarrito;

    public int getIdCarrito() {
        return idCarrito;
    }

    public void setIdCarrito(int idCarrito) {
        this.idCarrito = idCarrito;
    }

    public int getCantidadCarrito() {
        return cantidadCarrito;
    }

    public void setCantidadCarrito(int cantidadCarrito) {
        this.cantidadCarrito = cantidadCarrito;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public boolean isEstadoCarrito() {
        return estadoCarrito;
    }

    public void setEstadoCarrito(boolean estadoCarrito) {
        this.estadoCarrito = estadoCarrito;
    }

    public BigDecimal getMontoTotalCarrito() {
        return montoTotalCarrito;
    }

    public void setMontoTotalCarrito(BigDecimal montoTotalCarrito) {
        this.montoTotalCarrito = montoTotalCarrito;
    }

}

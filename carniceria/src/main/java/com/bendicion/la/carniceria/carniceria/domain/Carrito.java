/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.bendicion.la.carniceria.carniceria.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.math.BigDecimal;

/**
 *
 * @author jsand
 */

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
    @JoinColumn(name="idUsuario", nullable =false)
    private Usuario usuario;
    
    @Column(name = "montoTotalCarrito")
    private BigDecimal montoTotalCarrito;

    @Column(name = "estadoCarrito")
    private boolean estadoCarrito;

    public Carrito(){
    }

    public Carrito(int idCarrito, int cantidadCarrito, Usuario usuario, BigDecimal montoTotalCarrito,
        boolean estadoCarrito){
        this.idCarrito = idCarrito;
        this.cantidadCarrito = cantidadCarrito;
        this.usuario = usuario;
        this.montoTotalCarrito = montoTotalCarrito;
        this.estadoCarrito = estadoCarrito;
    }

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

    public BigDecimal getMontoTotalCarrito() {
        return montoTotalCarrito;
    }
    public void setMontoTotalCarrito(BigDecimal montoTotalCarrito) {
        this.montoTotalCarrito = montoTotalCarrito;
    }

    public boolean isEstadoCarrito() {
        return estadoCarrito;
    }
    public void setEstadoCarrito(boolean estadoCarrito) {
        this.estadoCarrito = estadoCarrito;
    }
}
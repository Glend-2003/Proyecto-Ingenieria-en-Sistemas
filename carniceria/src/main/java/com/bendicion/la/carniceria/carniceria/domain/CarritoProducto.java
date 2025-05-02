package com.bendicion.la.carniceria.carniceria.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "tbcarritoproducto")
public class CarritoProducto {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idCarritoProducto")
    private int idCarritoProducto;
    
    @ManyToOne
    @JoinColumn(name = "idCarrito", nullable = false)
    private Carrito carrito;
    
    @Column(name = "idProducto")
    private int idProducto;
    
    @Column(name = "cantidadProducto")
    private int cantidadProducto;

    public int getIdCarritoProducto() {
        return idCarritoProducto;
    }
    public void setIdCarritoProducto(int idCarritoProducto) {
        this.idCarritoProducto = idCarritoProducto;
    }

    public Carrito getCarrito() {
        return carrito;
    }
    public void setCarrito(Carrito carrito) {
        this.carrito = carrito;
    }

    public int getIdProducto() {
        return idProducto;
    }
    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public int getCantidadProducto() {
        return cantidadProducto;
    }
    public void setCantidadProducto(int cantidadProducto) {
        this.cantidadProducto = cantidadProducto;
    }
}

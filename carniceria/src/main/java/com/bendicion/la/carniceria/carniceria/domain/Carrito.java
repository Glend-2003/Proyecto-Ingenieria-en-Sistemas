/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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
    
}

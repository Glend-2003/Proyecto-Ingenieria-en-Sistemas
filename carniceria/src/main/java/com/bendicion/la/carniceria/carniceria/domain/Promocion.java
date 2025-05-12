/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.bendicion.la.carniceria.carniceria.domain;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

/**
 *
 * @author Dilan Gutierrez
 */

@Entity (name = "tbpromocion")
public class Promocion {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idPromocion")
    private int idPromocion;
    
    @Column(name = "descripcionPromocion")
    private String descripcionPromocion;
   
    @Column(name = "fechaInicioPromocion")
     @Temporal(TemporalType.DATE) 
    @JsonFormat(pattern="yyyy-MM-dd", timezone = "America/Costa_Rica")
    private Date fechaInicioPromocion;
     
    @Column(name = "fechaFinPromocion")
    @Temporal(TemporalType.DATE) 
    @JsonFormat(pattern="yyyy-MM-dd", timezone = "America/Costa_Rica")
    private Date fechaFinPromocion;
    
    @Column(name = "montoPromocion")
    private BigDecimal montoPromocion;
   
    @Column(name = "estadoPromocion")
    private boolean estadoPromocion;
    
     @ManyToOne
    @JoinColumn(name = "idProducto") 
     @JsonBackReference 
    private Producto producto;
     
 
    
    
    public Promocion(){
        
    }

    public Promocion(int idPromocion, String descripcionPromocion, Date fechaInicioPromocion, Date fechaFinPromocion, BigDecimal montoPromocion, boolean estadoPromocion, Producto producto) {
        this.idPromocion = idPromocion;
        this.descripcionPromocion = descripcionPromocion;
        this.fechaInicioPromocion = fechaInicioPromocion;
        this.fechaFinPromocion = fechaFinPromocion;
        this.montoPromocion = montoPromocion;
        this.estadoPromocion = estadoPromocion;
        this.producto = producto;
    }

    /**
     * @return 
     */
    public int getIdPromocion() {
        return idPromocion;
    }

    /**
     * @param idPromocion the idPromocion to set
     */
    public void setIdPromocion(int idPromocion) {
        this.idPromocion = idPromocion;
    }

    /**
     * @return the descripcionPromocion
     */
    public String getDescripcionPromocion() {
        return descripcionPromocion;
    }

    /**
     * @param descripcionPromocion the descripcionPromocion to set
     */
    public void setDescripcionPromocion(String descripcionPromocion) {
        this.descripcionPromocion = descripcionPromocion;
    }

    /**
     * @return the fechaInicioPromocion
     */
    public Date getFechaInicioPromocion() {
        return fechaInicioPromocion;
    }

    /**
     * @param fechaInicioPromocion the fechaInicioPromocion to set
     */
    public void setFechaInicioPromocion(Date fechaInicioPromocion) {
        this.fechaInicioPromocion = fechaInicioPromocion;
    }

    /**
     * @return the fechaFinPromocion
     */
    public Date getFechaFinPromocion() {
        return fechaFinPromocion;
    }

    /**
     * @param fechaFinPromocion the fechaFinPromocion to set
     */
    public void setFechaFinPromocion(Date fechaFinPromocion) {
        this.fechaFinPromocion = fechaFinPromocion;
    }

    /**
     * @return the montoPromocion
     */
    public BigDecimal getMontoPromocion() {
        return montoPromocion;
    }

    /**
     * @param montoPromocion the montoPromocion to set
     */
    public void setMontoPromocion(BigDecimal montoPromocion) {
        this.montoPromocion = montoPromocion;
    }

    /**
     * @return the estadoPromocion
     */
    public boolean isEstadoPromocion() {
        return estadoPromocion;
    }

    /**
     * @param estadoPromocion the estadoPromocion to set
     */
    public void setEstadoPromocion(boolean estadoPromocion) {
        this.estadoPromocion = estadoPromocion;
    }

    
    public Producto getProducto() {
        return producto;
    }

  
    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    @Override
    public String toString() {
        return "Promocion{" + "idPromocion=" + idPromocion + ", descripcionPromocion=" + descripcionPromocion + ", fechaInicioPromocion=" + fechaInicioPromocion + ", fechaFinPromocion=" + fechaFinPromocion + ", montoPromocion=" + montoPromocion + ", estadoPromocion=" + estadoPromocion + ", producto=" + producto + '}';
    }

}

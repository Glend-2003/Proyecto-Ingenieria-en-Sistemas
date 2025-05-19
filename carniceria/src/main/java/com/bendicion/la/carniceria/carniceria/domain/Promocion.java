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

@Entity(name = "tbpromocion")
public class Promocion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idPromocion")
    private int idPromocion;

    @Column(name = "descripcionPromocion")
    private String descripcionPromocion;

    @Column(name = "fechaInicioPromocion")
    @Temporal(TemporalType.DATE)
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "America/Costa_Rica")
    private Date fechaInicioPromocion;

    @Column(name = "fechaFinPromocion")
    @Temporal(TemporalType.DATE)
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "America/Costa_Rica")
    private Date fechaFinPromocion;

    @Column(name = "montoPromocion")
    private BigDecimal montoPromocion;

    @Column(name = "estadoPromocion")
    private boolean estadoPromocion;

    @ManyToOne
    @JoinColumn(name = "idProducto")
    @JsonBackReference
    private Producto producto;

    public Promocion() {

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

    public int getIdPromocion() {
        return idPromocion;
    }

    public void setIdPromocion(int idPromocion) {
        this.idPromocion = idPromocion;
    }

    public String getDescripcionPromocion() {
        return descripcionPromocion;
    }

    public void setDescripcionPromocion(String descripcionPromocion) {
        this.descripcionPromocion = descripcionPromocion;
    }

    public Date getFechaInicioPromocion() {
        return fechaInicioPromocion;
    }

    public void setFechaInicioPromocion(Date fechaInicioPromocion) {
        this.fechaInicioPromocion = fechaInicioPromocion;
    }

    public Date getFechaFinPromocion() {
        return fechaFinPromocion;
    }

    public void setFechaFinPromocion(Date fechaFinPromocion) {
        this.fechaFinPromocion = fechaFinPromocion;
    }

    public BigDecimal getMontoPromocion() {
        return montoPromocion;
    }

    public void setMontoPromocion(BigDecimal montoPromocion) {
        this.montoPromocion = montoPromocion;
    }

    public boolean isEstadoPromocion() {
        return estadoPromocion;
    }

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

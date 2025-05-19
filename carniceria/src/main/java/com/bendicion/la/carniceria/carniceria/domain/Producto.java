package com.bendicion.la.carniceria.carniceria.domain;

import java.math.BigDecimal;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;

@Entity(name = "tbproducto")
public class Producto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idProducto")
    private int idProducto;

    @Column(name = "nombreProducto")
    private String nombreProducto;

    @Column(name = "imgProducto")
    private String imgProducto;

    @Column(name = "montoPrecioProducto")
    private BigDecimal montoPrecioProducto;

    @Column(name = "descripcionProducto")
    private String descripcionProducto;

    @Column(name = "cantidadProducto")
    private double cantidadProducto;

    @Column(name = "tipoPesoProducto")
    private String tipoPesoProducto;

    @Column(name = "codigoProducto")
    private String codigoProducto;

    @Column(name = "stockProducto")
    private int stockProducto;

    @OneToOne
    @JoinColumn(name = "idCategoria")
    private Categoria categoria;

    @Column(name = "estadoProducto")
    private boolean estadoProducto;

    @OneToMany(mappedBy = "producto", fetch = FetchType.EAGER)
    private List<Promocion> promociones;

    public Producto(int idProducto, String nombreProducto, String imgProducto, BigDecimal montoPrecioProducto, String descripcionProducto,
            double cantidadProducto, String tipoPesoProducto, String codigoProducto, int stockProducto, Categoria categoria, boolean estadoProducto) {
        this.idProducto = idProducto;
        this.nombreProducto = nombreProducto;
        this.imgProducto = imgProducto;
        this.montoPrecioProducto = montoPrecioProducto;
        this.descripcionProducto = descripcionProducto;
        this.cantidadProducto = cantidadProducto;
        this.tipoPesoProducto = tipoPesoProducto;
        this.codigoProducto = codigoProducto;
        this.stockProducto = stockProducto;
        this.categoria = categoria;
        this.estadoProducto = estadoProducto;
    }

    public Producto() {
    }

    public int getIdProducto() {
        return idProducto;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public String getImgProducto() {
        return imgProducto;
    }

    public BigDecimal getMontoPrecioProducto() {
        return montoPrecioProducto;
    }

    public String getDescripcionProducto() {
        return descripcionProducto;
    }

    public Categoria getCategoria() {
        return categoria;
    }

    public boolean isEstadoProducto() {
        return estadoProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public void setImgProducto(String imgProducto) {
        this.imgProducto = imgProducto;
    }

    public void setMontoPrecioProducto(BigDecimal montoPrecioProducto) {
        this.montoPrecioProducto = montoPrecioProducto;
    }

    public void setDescripcionProducto(String descripcionProducto) {
        this.descripcionProducto = descripcionProducto;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }

    public void setEstadoProducto(boolean estadoProducto) {
        this.estadoProducto = estadoProducto;
    }

    @Override
    public String toString() {
        return "Producto{" + "idProducto=" + idProducto + ", nombreProducto=" + nombreProducto + ", imgProducto=" + imgProducto + ", montoPrecioProducto=" + montoPrecioProducto + ", descripcionProducto=" + descripcionProducto + ", categoria=" + categoria + ", estadoProducto=" + estadoProducto + '}';
    }

    public List<Promocion> getPromociones() {
        return promociones;
    }

    public void setPromociones(List<Promocion> promociones) {
        this.promociones = promociones;
    }

    public double getCantidadProducto() {
        return cantidadProducto;
    }

    public void setCantidadProducto(double cantidadProducto) {
        this.cantidadProducto = cantidadProducto;
    }

    public String getTipoPesoProducto() {
        return tipoPesoProducto;
    }

    public void setTipoPesoProducto(String tipoPesoProducto) {
        this.tipoPesoProducto = tipoPesoProducto;
    }

    public String getCodigoProducto() {
        return codigoProducto;
    }

    public void setCodigoProducto(String codigoProducto) {
        this.codigoProducto = codigoProducto;
    }

    public int getStockProducto() {
        return stockProducto;
    }

    public void setStockProducto(int stockProducto) {
        this.stockProducto = stockProducto;
    }
}

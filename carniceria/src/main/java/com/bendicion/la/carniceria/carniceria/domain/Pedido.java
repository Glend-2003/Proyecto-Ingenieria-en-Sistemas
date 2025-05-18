package com.bendicion.la.carniceria.carniceria.domain;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;

@Entity(name = "tbpedido")
public class Pedido {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idPedido")
    private int idPedido;

    @Column(name = "montoTotalPedido")
    private BigDecimal montoTotalPedido;

    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm", timezone = "GMT")
    @Column(name = "fechaPedido")
    private LocalDateTime fechaPedido;

    @Column(name = "estadoPedido")
    private boolean estadoPedido;

    @Column(name = "estadoEntregaPedido")
    private String estadoEntregaPedido;

    @OneToOne
    @JoinColumn(name = "idCarrito")
    private Carrito carrito;

    @OneToOne
    @JoinColumn(name = "idTipoPago")
    private TipoPago tipoPago;

    public Pedido(int idPedido, BigDecimal montoTotalPedido, LocalDateTime fechaPedido, boolean estadoPedido, String estadoEntregaPedido, TipoPago tipoPago, Carrito carrito) {
        this.idPedido = idPedido;
        this.montoTotalPedido = montoTotalPedido;
        this.fechaPedido = fechaPedido;
        this.estadoPedido = estadoPedido;
        this.estadoEntregaPedido = estadoEntregaPedido;
        this.carrito = carrito;
        this.tipoPago = tipoPago;
    }

    public Pedido() {
    }

    public int getIdPedido() {
        return idPedido;
    }

    public BigDecimal getMontoTotalPedido() {
        return montoTotalPedido;
    }

    public LocalDateTime getFechaPedido() {
        return fechaPedido;
    }

    public boolean isEstadoPedido() {
        return estadoPedido;
    }

    public String getEstadoEntregaPedido() {
        return estadoEntregaPedido;
    }

    public TipoPago getTipoPago() {
        return tipoPago;
    }

    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
    }

    public void setMontoTotalPedido(BigDecimal montoTotalPedido) {
        this.montoTotalPedido = montoTotalPedido;
    }

    public void setFechaPedido(LocalDateTime fechaPedido) {
        this.fechaPedido = fechaPedido;
    }

    public void setEstadoPedido(boolean estadoPedido) {
        this.estadoPedido = estadoPedido;
    }

    public void setEstadoEntregaPedido(String estadoEntregaPedido) {
        this.estadoEntregaPedido = estadoEntregaPedido;
    }

    public void setTipoPago(TipoPago tipoPago) {
        this.tipoPago = tipoPago;
    }

    public Carrito getCarrito() {
        return carrito;
    }

    public void setCarrito(Carrito carrito) {
        this.carrito = carrito;
    }

}

package com.bendicion.la.carniceria.carniceria.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "tbtipopago")
public class TipoPago {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idTipoPago ")
    private int idTipoPago;

    @Column(name = "descripcionTipoPago")
    private String descripcionTipoPago;

    @Column(name = "estadoTipoPago")
    private boolean estadoTipoPago;

    public TipoPago() {
    }

    public TipoPago(int idTipoPago, String descripcionTipoPago, boolean estadoTipoPago) {
        this.idTipoPago = idTipoPago;
        this.descripcionTipoPago = descripcionTipoPago;
        this.estadoTipoPago = estadoTipoPago;
    }

    public int getIdTipoPago() {
        return idTipoPago;
    }

    public String getDescripcionTipoPago() {
        return descripcionTipoPago;
    }

    public boolean isEstadoTipoPago() {
        return estadoTipoPago;
    }

    public void setIdTipoPago(int idTipoPago) {
        this.idTipoPago = idTipoPago;
    }

    public void setDescripcionTipoPago(String descripcionTipoPago) {
        this.descripcionTipoPago = descripcionTipoPago;
    }

    public void setEstadoTipoPago(boolean estadoTipoPago) {
        this.estadoTipoPago = estadoTipoPago;
    }

}

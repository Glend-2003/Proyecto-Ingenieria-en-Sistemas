package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;

import com.bendicion.la.carniceria.carniceria.domain.TipoPago;

import jakarta.transaction.Transactional;

public interface ITipoPagoService {

    public TipoPago addTipoPago(TipoPago tipoPago);

    @Transactional
    public TipoPago updateTipoPago(TipoPago tipoPago);

    public List<TipoPago> getTipoPago();

    public TipoPago getTipoPagoById(int id);

    @Transactional
    public boolean activarTipoPago(int id);
}

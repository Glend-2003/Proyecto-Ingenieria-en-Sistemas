package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.bendicion.la.carniceria.carniceria.domain.TipoPago;
import com.bendicion.la.carniceria.carniceria.jpa.TipoPagoRepository;

import jakarta.transaction.Transactional;

@Service
@Primary
public class TipoPagoService implements ITipoPagoService {

    @Autowired
    private TipoPagoRepository tipoPagoRep;

    @Override
    @Transactional
    public TipoPago addTipoPago(TipoPago tipoPago) {
        System.out.println("Agregando tipo de pago: " + tipoPago.getDescripcionTipoPago());
        tipoPago.setEstadoTipoPago(true);
        tipoPagoRep.saveProcedureTipoPago(tipoPago.getDescripcionTipoPago(), tipoPago.isEstadoTipoPago());
        return tipoPago;
    }

    @Override
    @Transactional
    public TipoPago updateTipoPago(TipoPago tipoPago) {
        System.out.println("Actualizando tipo de pago con ID: " + tipoPago.getIdTipoPago());
        tipoPago.setEstadoTipoPago(true);
        tipoPagoRep.updateProcedureTipoPago(tipoPago.getIdTipoPago(), tipoPago.getDescripcionTipoPago(), tipoPago.isEstadoTipoPago());
        return tipoPago;
    }

    @Override
    @Transactional
    public List<TipoPago> getTipoPago() {
        return tipoPagoRep.listProcedureTipoPago();
    }

    @Override
    @Transactional
    public TipoPago getTipoPagoById(int id) {
        return tipoPagoRep.listProcedureTipoPagoById(id);
    }

    @Override
    @Transactional
    public boolean activarTipoPago(int id) {
        try {

            if (!tipoPagoRep.existsById(id)) {
                System.err.println("El tipo pago con ID: " + id + " no existe.");
                return false;
            }

            System.out.println("activando tipo pago con ID: " + id);
            tipoPagoRep.activarTipoPago(id);
            return true;
        } catch (Exception e) {
            System.err.println("Error al activar el tipo pago con ID: " + id + ". Detalles: " + e.getMessage());
            return false;
        }
    }

}

package com.bendicion.la.carniceria.carniceria.service;

import com.bendicion.la.carniceria.carniceria.domain.TipoPago;
import com.bendicion.la.carniceria.carniceria.jpa.TipoPagoRepository;
import jakarta.transaction.Transactional;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

/**
 *
 * @author Jamel Sandí
 */

@Service
@Primary
public class TipoPagoService implements ITipoPagoService{
        
    @Autowired
    private TipoPagoRepository tipoPagoRep;
    
    @Override
    public TipoPago addTipoPago(TipoPago tipoPago) {
        System.out.println("Agregando tipo de pago: " + tipoPago.getDescripcionTipoPago());
        tipoPago.setEstadoTipoPago(true);
        tipoPagoRep.saveProcedureTipoPago(tipoPago.getDescripcionTipoPago(), tipoPago.isEstadoTipoPago());
        return tipoPago;
    }

    @Override
    @Transactional // Asegura que la actualización se maneje dentro de una transacción
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
    public TipoPago getTipoPagoById(int id) {
        return tipoPagoRep.listProcedureTipoPagoById(id);
    }

    @Override
    public boolean deleteTipoPago(int id) {
        try {
            System.out.println("Eliminando tipo de pago con ID: " + id);
            tipoPagoRep.deleteProcedureTipoPago(id);
            return true;
        } catch (Exception e) {
            System.err.println("Error al eliminar el tipo de pago con ID: " + id + ". Detalles: " + e.getMessage());
            return false;
        }
    }
    
}

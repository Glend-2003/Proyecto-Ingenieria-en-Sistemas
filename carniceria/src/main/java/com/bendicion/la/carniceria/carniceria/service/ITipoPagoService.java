package com.bendicion.la.carniceria.carniceria.service;
import com.bendicion.la.carniceria.carniceria.domain.TipoPago;
import jakarta.transaction.Transactional;
import java.util.List;

/**
 *
 * @author Jamel Sandí
 */

public interface ITipoPagoService {
    
    public TipoPago addTipoPago(TipoPago tipoPago);
    
    @Transactional // Asegúrate de que esté anotado
    public TipoPago updateTipoPago(TipoPago tipoPago);
    
    public List<TipoPago> getTipoPago();

    public TipoPago getTipoPagoById(int id);
    
    @Transactional
    public boolean deleteTipoPago(int id);
    
      @Transactional
    public boolean activarTipoPago(int id);
}

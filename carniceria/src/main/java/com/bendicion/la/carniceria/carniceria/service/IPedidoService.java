package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;

import com.bendicion.la.carniceria.carniceria.domain.Pedido;

import jakarta.transaction.Transactional;
import java.util.Map;

/**
 *
 * @author Jamel Sandí
 */

public interface IPedidoService {
    
    @Transactional
    public Pedido addPedido(Pedido pedido);
    
    @Transactional // Asegúrate de que esté anotado
    public Pedido updatePedido(Pedido pedido);
    
    @Transactional
    public List<Pedido> getPedido();
    /* 
    @Transactional
    public Pedido getPedidoById(int id);
    */
    @Transactional
    public boolean deletePedido(int id);
    
    @Transactional
    public boolean updateStatePedido(int id);
    
    @Transactional
    public void updateStateEntregaPedido(int idPedido, String nuevoEstado);
    
     @Transactional
    public Map<String, Object> getTotalVentas();
    
    @Transactional
    public Map<String, Map<String, Object>> getReporteVentasCompleto();
}

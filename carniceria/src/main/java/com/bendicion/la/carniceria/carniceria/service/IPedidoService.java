package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;
import java.util.Map;

import com.bendicion.la.carniceria.carniceria.domain.Pedido;

import jakarta.transaction.Transactional;

/**
 *
 * @author Jamel Sandí
 */

public interface IPedidoService {
    
    @Transactional
    public Pedido addPedido(Pedido pedido);
    
    @Transactional 
    public Pedido updatePedido(Pedido pedido);
    
    @Transactional
    public List<Map<String, Object>> getPedido();

    @Transactional
    public boolean deletePedido(int id);
}

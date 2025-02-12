package com.bendicion.la.carniceria.carniceria.service;

import com.bendicion.la.carniceria.carniceria.domain.Pedido;
import jakarta.transaction.Transactional;
import java.util.List;

/**
 *
 * @author Jamel Sandí
 */

public interface IPedidoService {
    
    public Pedido addPedido(Pedido pedido);
    
    @Transactional // Asegúrate de que esté anotado
    public Pedido updatePedido(Pedido pedido);
    
    public List<Pedido> getPedido();

    public Pedido getPedidoById(int id);
    
    @Transactional
    public boolean deletePedido(int id);
}

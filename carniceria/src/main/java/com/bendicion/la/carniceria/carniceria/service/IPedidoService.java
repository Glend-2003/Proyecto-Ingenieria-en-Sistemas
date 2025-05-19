package com.bendicion.la.carniceria.carniceria.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.bendicion.la.carniceria.carniceria.domain.Pedido;

import jakarta.transaction.Transactional;

public interface IPedidoService {

    @Transactional
    public Pedido addPedido(Pedido pedido);

    @Transactional
    public Pedido updatePedido(Pedido pedido);

    @Transactional
    public List<Map<String, Object>> getPedido();

    @Transactional
    public List<Map<String, Object>> getPedidoEntregado();

    @Transactional
    public List<Map<String, Object>> getPedidoByUsuario(int id);

    @Transactional
    List<Map<String, Object>> filtrarPedidos(
            int idUsuario,
            String estadoEntrega,
            Date fechaInicio,
            Date fechaFin,
            Integer estadoPedido
    );

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

    public void sendMail(String correo, String estado);
}

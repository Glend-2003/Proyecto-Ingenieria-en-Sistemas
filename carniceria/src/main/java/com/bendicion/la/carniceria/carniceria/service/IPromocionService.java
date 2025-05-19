package com.bendicion.la.carniceria.carniceria.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.bendicion.la.carniceria.carniceria.domain.Promocion;

import jakarta.transaction.Transactional;

public interface IPromocionService {

    public Promocion addPromocion(Promocion promocion);

    @Transactional
    public List<Map<String, Object>> getPromociones();

    @Transactional
    public Promocion updatePromocion(Promocion promocion);

    @Transactional
    public boolean deletePromocion(int id);

    @Transactional
    public void enviarMensaje(String destino, String sujeto, String mensaje);

    @Transactional
    public String mensajePredeterminado(String nombre, String descripcion, Date inicioPromocion, Date finPromocion, BigDecimal montoPromocion);

    @Transactional
    public boolean activarPromocion(int id);
}

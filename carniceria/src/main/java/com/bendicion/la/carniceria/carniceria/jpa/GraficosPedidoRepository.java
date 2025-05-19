package com.bendicion.la.carniceria.carniceria.jpa;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;

@Repository
public class GraficosPedidoRepository {

    @PersistenceContext
    private EntityManager entityManager;

    public Map<String, Object> obtenerVentasPorPeriodo(String periodo) {
        StoredProcedureQuery query = entityManager
                .createStoredProcedureQuery("spObtenerTotalVentas")
                .registerStoredProcedureParameter("p_periodo", String.class, ParameterMode.IN)
                .setParameter("p_periodo", periodo);

        query.execute();

        Object[] resultado = (Object[]) query.getSingleResult();

        Map<String, Object> ventas = new HashMap<>();
        ventas.put("totalVentas", resultado[0]);
        ventas.put("cantidadPedidos", resultado[1]);
        ventas.put("totalFormateado", resultado[2]);
        ventas.put("promedio", resultado[3]);
        ventas.put("promedioFormateado", resultado[4]);
        ventas.put("periodo", resultado[5]);

        return ventas;
    }
}

package com.bendicion.la.carniceria.carniceria.jpa;

import org.springframework.stereotype.Repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;

@Repository
public class UsuarioCodigoRepository {

    @PersistenceContext
    private EntityManager entityManager;

    public String obtenerCodigoUsuario(String correoUsuario) {

        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("spObtenerCodigoUsuario")
                .registerStoredProcedureParameter("p_correoUsuario", String.class, ParameterMode.IN)
                .registerStoredProcedureParameter("p_numCodigo", String.class, ParameterMode.OUT)
                .setParameter("p_correoUsuario", correoUsuario);

        query.execute();

        String numCodigo = (String) query.getOutputParameterValue("p_numCodigo");

        return numCodigo;
    }
}

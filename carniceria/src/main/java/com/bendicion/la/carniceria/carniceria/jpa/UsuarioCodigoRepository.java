package com.bendicion.la.carniceria.carniceria.jpa;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Jamel Sandí
 */

@Repository
public class UsuarioCodigoRepository {
    
    @PersistenceContext
    private EntityManager entityManager;

    public String obtenerCodigoUsuario(String correoUsuario) {
        // Crear la llamada al procedimiento almacenado
        StoredProcedureQuery query = entityManager.createStoredProcedureQuery("spObtenerCodigoUsuario")
            .registerStoredProcedureParameter("p_correoUsuario", String.class, ParameterMode.IN)
            .registerStoredProcedureParameter("p_numCodigo", String.class, ParameterMode.OUT)
            .setParameter("p_correoUsuario", correoUsuario);

        query.execute();

        String numCodigo = (String) query.getOutputParameterValue("p_numCodigo");

        return numCodigo;
    }
}

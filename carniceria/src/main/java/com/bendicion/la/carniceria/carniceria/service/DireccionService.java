package com.bendicion.la.carniceria.carniceria.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.bendicion.la.carniceria.carniceria.jpa.DireccionRepository;

import jakarta.transaction.Transactional;

/**
 *
 * @author Jamel Sandí
 */
@Service
@Primary
public class DireccionService implements IDireccionService {

    @Autowired
    private DireccionRepository direccionRep;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    @Transactional
    public int addDireccionUsuario(int idUsuario, String descripcion, String codigoPostal, int idDistrito) {
        return direccionRep.addDireccionUsuario(idUsuario, descripcion, codigoPostal, idDistrito);
    }

    @Override
    public Map<String, Object> buscarDireccionPorCorreo(String correoUsuario) {
        try {
            String sql = "CALL spBuscarDireccionUsuarioPorCorreo(?)";
            List<Map<String, Object>> resultados = jdbcTemplate.queryForList(sql, correoUsuario);

            if (resultados.isEmpty()) {
                return new HashMap<>();
            }

            return resultados.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return new HashMap<>();
        }
    }
}

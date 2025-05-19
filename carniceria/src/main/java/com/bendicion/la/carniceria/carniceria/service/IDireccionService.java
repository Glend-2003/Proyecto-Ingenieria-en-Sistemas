package com.bendicion.la.carniceria.carniceria.service;

import java.util.Map;

import jakarta.transaction.Transactional;

public interface IDireccionService {

    @Transactional
    int addDireccionUsuario(int idUsuario, String descripcion, String codigoPostal, int idDistrito);

    Map<String, Object> buscarDireccionPorCorreo(String correoUsuario);
}

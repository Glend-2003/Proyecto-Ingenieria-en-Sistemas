package com.bendicion.la.carniceria.carniceria.service;

import jakarta.transaction.Transactional;

/**
 *
 * @author Jamel Sandí
 */

public interface IDireccionService {
    
    @Transactional
    int addDireccionUsuario(int idUsuario, String descripcion, String codigoPostal, int idDistrito);
}

package com.bendicion.la.carniceria.carniceria.service;
import com.bendicion.la.carniceria.carniceria.jpa.DireccionRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

/**
 *
 * @author Jamel Sandí
 */

@Service
@Primary
public class DireccionService implements IDireccionService{
    
    @Autowired
    private DireccionRepository direccionRep;
    
    @Override
    @Transactional
    public int addDireccionUsuario(int idUsuario, String descripcion, String codigoPostal, int idDistrito) {
        return direccionRep.addDireccionUsuario(idUsuario, descripcion, codigoPostal, idDistrito);
    }
}


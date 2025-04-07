package com.bendicion.la.carniceria.carniceria.service;
import com.bendicion.la.carniceria.carniceria.domain.Canton;
import java.util.List;

/**
 *
 * @author Jamel Sandí
 */

public interface ICantonService {
    
    public List<Canton> getCanton(int idProvincia);
}

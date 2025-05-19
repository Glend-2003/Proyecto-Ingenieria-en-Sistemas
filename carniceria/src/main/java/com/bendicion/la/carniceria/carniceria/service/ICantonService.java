package com.bendicion.la.carniceria.carniceria.service;
import java.util.List;

import com.bendicion.la.carniceria.carniceria.domain.Canton;

public interface ICantonService {
    
    public List<Canton> getCanton(int idProvincia);
}

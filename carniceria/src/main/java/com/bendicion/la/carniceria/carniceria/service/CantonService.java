package com.bendicion.la.carniceria.carniceria.service;
import com.bendicion.la.carniceria.carniceria.domain.Canton;
import com.bendicion.la.carniceria.carniceria.jpa.CantonRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

/**
 *
 * @author Jamel Sandí
 */

@Service
@Primary
public class CantonService implements ICantonService{
    
    @Autowired
    private CantonRepository cantonRep;
    
    @Override
    public List<Canton> getCanton(int idProvincia) {
        return cantonRep.listProcedureCantonProvincia(idProvincia);
    }
}


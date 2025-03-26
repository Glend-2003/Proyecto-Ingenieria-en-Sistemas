package com.bendicion.la.carniceria.carniceria.service;
import com.bendicion.la.carniceria.carniceria.domain.Provincia;
import com.bendicion.la.carniceria.carniceria.jpa.ProvinciaRepository;
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
public class ProvinciaService implements IProvinciaService{

    @Autowired
    private ProvinciaRepository provinciaRep;
    
    @Override
    public List<Provincia> getProvincia() {
        return provinciaRep.listProcedureProvincia();
    }
}
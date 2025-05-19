package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.bendicion.la.carniceria.carniceria.domain.Provincia;
import com.bendicion.la.carniceria.carniceria.jpa.ProvinciaRepository;

@Service
@Primary
public class ProvinciaService implements IProvinciaService {

    @Autowired
    private ProvinciaRepository provinciaRep;

    @Override
    public List<Provincia> getProvincia() {
        return provinciaRep.listProcedureProvincia();
    }
}

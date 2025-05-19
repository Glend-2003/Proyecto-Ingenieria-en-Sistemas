package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.bendicion.la.carniceria.carniceria.domain.Distrito;
import com.bendicion.la.carniceria.carniceria.jpa.DistritoRepository;

@Service
@Primary
public class DistritoService implements IDistritoService {

    @Autowired
    private DistritoRepository distritoRep;

    @Override
    public List<Distrito> getDistrito() {
        return distritoRep.listProcedureDistrito();
    }

    @Override
    public List<Distrito> getDistritos(int idCanton) {
        return distritoRep.listProcedureDistritoCanton(idCanton);
    }
}

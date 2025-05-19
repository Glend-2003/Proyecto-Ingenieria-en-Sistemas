package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;

import com.bendicion.la.carniceria.carniceria.domain.Distrito;

public interface IDistritoService {

    public List<Distrito> getDistrito();

    public List<Distrito> getDistritos(int idCanton);
}

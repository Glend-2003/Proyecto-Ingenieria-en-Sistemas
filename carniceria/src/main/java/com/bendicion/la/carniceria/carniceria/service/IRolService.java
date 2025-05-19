package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;

import com.bendicion.la.carniceria.carniceria.domain.Rol;

import jakarta.transaction.Transactional;

public interface IRolService {

    public Rol addRol(Rol rol);

    public Rol updateRol(Rol rol);

    public List<Rol> getRol();

    @Transactional
    public boolean deleteRol(int id);
}

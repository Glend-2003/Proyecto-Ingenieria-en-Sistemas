package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.bendicion.la.carniceria.carniceria.domain.Rol;
import com.bendicion.la.carniceria.carniceria.jpa.RolRepository;

@Service
@Primary
public class RolService implements IRolService {

    @Autowired
    private RolRepository rolRepo;

    @Override
    public Rol addRol(Rol rol) {
        System.out.println("Agregando rol con nombre: " + rol.getNombreRol());
        rolRepo.saveProcedureRol(rol.getNombreRol(), rol.getDescripcionRol(), rol.isEstadoRol());
        return rol;
    }

    @Override
    public Rol updateRol(Rol rol) {
        System.out.println("Actualizando rol con ID: " + rol.getIdRol());
        rolRepo.updateProcedureRol(rol.getIdRol(), rol.getNombreRol(), rol.getDescripcionRol(), rol.isEstadoRol());
        return rol;
    }

    @Override
    public List<Rol> getRol() {
        return rolRepo.listProcedureRol();
    }

    @Override
    public boolean deleteRol(int id) {
        System.out.println("Eliminando rol con ID: " + id);
        rolRepo.deleteProcedureRol(id);
        return true;
    }
}

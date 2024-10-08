package com.bendicion.la.carniceria.carniceria.service;
import com.bendicion.la.carniceria.carniceria.domain.Rol;
import jakarta.transaction.Transactional;
import java.util.List;

/**
 *
 * @author Jamel Sandí
 */

public interface IRolService {
    
    public Rol addRol(Rol rol);
    
    public Rol updateRol(Rol rol);
    
    public List<Rol> getRol();
    
    @Transactional
    public boolean deleteRol(int id);
}

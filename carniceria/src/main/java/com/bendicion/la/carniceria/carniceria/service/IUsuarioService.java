package com.bendicion.la.carniceria.carniceria.service;
import com.bendicion.la.carniceria.carniceria.domain.Usuario;
import jakarta.transaction.Transactional;
import java.util.List;

/**
 *
 * @author Jamel Sandí
 */

public interface IUsuarioService {
    
    public Usuario addUsuario(Usuario usuario);
    
    public Usuario updateUsuario(Usuario usuario);
    
    public List<Usuario> getUsuario();
    
    @Transactional
    public boolean deleteUsuario(int id);
}

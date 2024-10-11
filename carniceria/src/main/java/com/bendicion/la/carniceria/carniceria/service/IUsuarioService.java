package com.bendicion.la.carniceria.carniceria.service;
import com.bendicion.la.carniceria.carniceria.domain.Usuario;
import jakarta.transaction.Transactional;
import java.util.List;

/**
 *
 * @author Jamel Sandí
 */

public interface IUsuarioService {
    
    // Agregar usuarios en vista Admin
    public Usuario addUsuario(Usuario usuario);
    
    // Actualizar usuarios 
    public Usuario updateUsuario(Usuario usuario);
    
    // Lista todos los usuarios para vista Admin
    public List<Usuario> getUsuario();   
    
    // Eliminar usuarios
    @Transactional
    public boolean deleteUsuario(int id);
        
    // Para validar en la Login y trae todos sus datos al loguearse
    public Usuario validateLogin(String correo, String contraseniaIngresada);
    
    // Registrarse como nuevo usuario 
    public Usuario registerUsuario(Usuario usuario);
}

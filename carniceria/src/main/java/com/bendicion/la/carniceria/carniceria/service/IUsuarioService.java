package com.bendicion.la.carniceria.carniceria.service;
import java.util.List;

import com.bendicion.la.carniceria.carniceria.domain.Usuario;

import jakarta.transaction.Transactional;

/**
 *
 * @author Jamel Sandí
 */

public interface IUsuarioService {
    
    // Agregar usuarios en vista Admin
    public Usuario addUsuario(Usuario usuario);
    
    // Actualizar usuarios 
    @Transactional // Asegúrate de que esté anotado
    public Usuario updateUsuario(Usuario usuario);
    
    // Lista todos los usuarios para vista Admin
    public List<Usuario> getUsuario();   
    
    // Eliminar usuarios
    @Transactional
    public boolean deleteUsuario(int id);
        
    // Para validar en la Login y trae todos sus datos al loguearse
    public Usuario validateLogin(String correo, String contraseniaIngresada);
    
    // Buscar usuario por correo
    public Usuario searchCorreoUsuario(String correo);
    
    // Registrarse como nuevo usuario 
    public Usuario registerUsuario(Usuario usuario);
    
     // Registrarse como nuevo usuario 
    public Usuario actualizarContrasena(Usuario usuario);
    
    // Obtener usuario por ID
    public Usuario getUsuarioById(int id);

}

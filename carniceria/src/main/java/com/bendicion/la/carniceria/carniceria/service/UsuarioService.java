package com.bendicion.la.carniceria.carniceria.service;

import com.bendicion.la.carniceria.carniceria.Logic.Seguridad;
import com.bendicion.la.carniceria.carniceria.domain.Usuario;
import com.bendicion.la.carniceria.carniceria.jpa.UsuarioRepository;
import java.sql.Date;
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
public class UsuarioService implements IUsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepo;

    @Autowired
    private Seguridad seguridad;
    
// -----------------------------------------------------------------------------
    
    @Override
    public Usuario addUsuario(Usuario usuario) {

        String encriptedPassword = seguridad.encriptPassword(usuario.getContraseniaUsuario());

        Date fechaNacimiento = null;
        if (usuario.getFechaNacimiento() != null) {
            fechaNacimiento = Date.valueOf(usuario.getFechaNacimiento());
        }
        usuarioRepo.saveProcedureUsuario(
                usuario.getCedulaUsuario(),
                usuario.getNombreUsuario(),
                usuario.getPrimerApellido(),
                usuario.getSegundoApellido(),
                usuario.getTelefonoUsuario(),
                usuario.getCorreoUsuario(),
                encriptedPassword,
                fechaNacimiento,
                usuario.getDireccion().getDescripcionDireccion(),
                usuario.getDireccion().getCodigoPostal(),
                usuario.getDireccion().getDistrito().getIdDistrito(),
                usuario.getRol().getIdRol()
        );
        return usuario;
    }
    
// ----------------------------------------------------------------------------- 
    
    @Override
    public Usuario registerUsuario(Usuario usuario) {
        int existe = usuarioRepo.verifyCorreoProcedureUsuario(usuario.getCorreoUsuario());
        String encriptedPassword = seguridad.encriptPassword(usuario.getContraseniaUsuario());
        if (existe > 0) {
            throw new RuntimeException("El correo ya está en uso.");
        }
        if (usuario.getCorreoUsuario().equals("")) {
            throw new RuntimeException("Debe ingresar un correo");
        }
        if (encriptedPassword == null || encriptedPassword.equals("")) {
            throw new RuntimeException("Debe ingresar una contrasena");
        }
       
        usuarioRepo.registerProcedureUsuario(usuario.getCorreoUsuario(), encriptedPassword);
    
        return usuario;
    }

// -----------------------------------------------------------------------------   
    
    @Override
    public Usuario updateUsuario(Usuario usuario) {

        String encriptedPassword = null;
        if (usuario.getContraseniaUsuario() != null && !usuario.getContraseniaUsuario().isEmpty()) {
            encriptedPassword = seguridad.encriptPassword(usuario.getContraseniaUsuario());
        } else {
            Usuario existingUsuario = usuarioRepo.findById(usuario.getIdUsuario()).orElse(null);
            if (existingUsuario != null) {
                encriptedPassword = existingUsuario.getContraseniaUsuario(); 
            }
        }

        Date fechaNacimiento = null;
        if (usuario.getFechaNacimiento() != null) {
            fechaNacimiento = Date.valueOf(usuario.getFechaNacimiento());
        }

        String descripcionDireccion = null;
        String codigoPostalDireccion = null;
        Integer idDistrito = null;

        if (usuario.getDireccion() != null) {
            descripcionDireccion = usuario.getDireccion().getDescripcionDireccion();
            codigoPostalDireccion = usuario.getDireccion().getCodigoPostal();
            idDistrito = usuario.getDireccion().getDistrito().getIdDistrito();
        } else {
            Usuario existingUsuario = usuarioRepo.findById(usuario.getIdUsuario()).orElse(null);
            if (existingUsuario != null && existingUsuario.getDireccion() != null) {
                descripcionDireccion = existingUsuario.getDireccion().getDescripcionDireccion();
                codigoPostalDireccion = existingUsuario.getDireccion().getCodigoPostal();
                idDistrito = existingUsuario.getDireccion().getDistrito().getIdDistrito();
            }
        }

        usuarioRepo.updateProcedureUsuario(
                usuario.getIdUsuario(),
                usuario.getCedulaUsuario(),
                usuario.getNombreUsuario(),
                usuario.getPrimerApellido(),
                usuario.getSegundoApellido(),
                usuario.getTelefonoUsuario(),
                usuario.getCorreoUsuario(),
                encriptedPassword, 
                fechaNacimiento,
                descripcionDireccion, 
                codigoPostalDireccion, 
                idDistrito 
        );

        return usuario;
    }

// -----------------------------------------------------------------------------    
    
    @Override
    public List<Usuario> getUsuario() {
        return usuarioRepo.listProcedureUsuario();
    }

// -----------------------------------------------------------------------------    
    
    @Override
    public boolean deleteUsuario(int id) {
        usuarioRepo.deleteProcedureUsuario(id);
        return true;
    }
    
// -----------------------------------------------------------------------------    

    @Override
    public Usuario validateLogin(String correo, String contraseniaIngresada) {
        Usuario usuario = usuarioRepo.searchUsuario(correo);
        
        if (usuario != null && seguridad.validatePassword(contraseniaIngresada, usuario.getContraseniaUsuario())) {
            return usuario;
        }
        return null;
    }
    
    
    // -----------------------------------------------------------------------------    
    
     
    public String getSalida(){
        return usuarioRepo.getSalida();
    }
}

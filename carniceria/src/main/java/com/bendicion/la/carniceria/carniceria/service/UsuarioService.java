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
public class UsuarioService implements IUsuarioService{
    
    @Autowired
    private UsuarioRepository usuarioRepo;
     
    @Autowired
    private Seguridad seguridad;

    @Override
    public Usuario addUsuario(Usuario usuario) {
        
        // Aquí se encripta la contra
        String encriptedPassword = seguridad.encriptPassword(usuario.getContraseniaUsuario());
        //usuario.setContraseniaUsuario(encriptedPassword);
        
        Date fechaNacimiento = Date.valueOf(usuario.getFechaNacimiento());
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


    @Override
    public Usuario updateUsuario(Usuario usuario) {
        
        // Aquí se encripta la contra
        String encriptedPassword = seguridad.encriptPassword(usuario.getContraseniaUsuario());
        //usuario.setContraseniaUsuario(encriptedPassword);
        
        // Aquí hacemos el formateo
        Date fechaNacimiento = Date.valueOf(usuario.getFechaNacimiento());

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
            usuario.getDireccion().getDescripcionDireccion(),
            usuario.getDireccion().getCodigoPostal(),
            usuario.getDireccion().getDistrito().getIdDistrito()
        );

        return usuario;
    }

    @Override
    public List<Usuario> getUsuario() {
        return usuarioRepo.listProcedureUsuario();
    }

    @Override
    public boolean deleteUsuario(int id) {
        usuarioRepo.deleteProcedureUsuario(id);
        return true;
    }
    
    @Override
    public Usuario validateLogin(String correo, String contraseniaIngresada) {
        Usuario usuario = usuarioRepo.searchUsuario(correo);

        if (usuario != null && seguridad.validatePassword(contraseniaIngresada, usuario.getContraseniaUsuario())) {           
            return usuario;
        }
        return null; 
    }
}

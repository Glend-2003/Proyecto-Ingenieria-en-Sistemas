package com.bendicion.la.carniceria.carniceria.service;
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

    @Override
    public Usuario addUsuario(Usuario usuario) {
        Date fechaNacimiento = Date.valueOf(usuario.getFechaNacimiento());
        usuarioRepo.saveProcedureUsuario(
            usuario.getCedulaUsuario(),
            usuario.getNombreUsuario(),
            usuario.getPrimerApellido(),
            usuario.getSegundoApellido(),
            usuario.getTelefonoUsuario(),
            usuario.getCorreoUsuario(),
            usuario.getContraseniaUsuario(),
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
        Date fechaNacimiento = Date.valueOf(usuario.getFechaNacimiento());
        usuarioRepo.updateProcedureUsuario(
            usuario.getIdUsuario(),
            usuario.getCedulaUsuario(),
            usuario.getNombreUsuario(),
            usuario.getPrimerApellido(),
            usuario.getSegundoApellido(),
            usuario.getTelefonoUsuario(),
            usuario.getCorreoUsuario(),
            usuario.getContraseniaUsuario(),
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
}

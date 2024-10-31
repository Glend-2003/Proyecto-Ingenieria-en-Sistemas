package com.bendicion.la.carniceria.carniceria.service;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.bendicion.la.carniceria.carniceria.Logic.JwtService;
import com.bendicion.la.carniceria.carniceria.Logic.Seguridad;
import com.bendicion.la.carniceria.carniceria.domain.Usuario;
import com.bendicion.la.carniceria.carniceria.jpa.UsuarioRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

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

    @Autowired
    private JwtService jwt;

    @PersistenceContext
    private EntityManager entityManager;

// -----------------------------------------------------------------------------
    @Override
    @Transactional // Asegúrate de que esté anotado
    public Usuario addUsuario(Usuario usuario) {

        if (usuario.getCedulaUsuario() == null || usuario.getCedulaUsuario().trim().isEmpty()) {
            throw new IllegalArgumentException("La cédula del usuario no puede estar vacía");
        }
        if (usuario.getNombreUsuario() == null || usuario.getNombreUsuario().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre del usuario no puede estar vacío");
        }
        if (usuario.getPrimerApellido() == null || usuario.getPrimerApellido().trim().isEmpty()) {
            throw new IllegalArgumentException("El primer apellido del usuario no puede estar vacío");
        }
        if (usuario.getSegundoApellido() == null || usuario.getSegundoApellido().trim().isEmpty()) {
            throw new IllegalArgumentException("El segundo apellido del usuario no puede estar vacío");
        }
        if (usuario.getTelefonoUsuario() == null || usuario.getTelefonoUsuario().trim().isEmpty()) {
            throw new IllegalArgumentException("El teléfono del usuario no puede estar vacío");
        }
        if (usuario.getCorreoUsuario() == null || usuario.getCorreoUsuario().trim().isEmpty()) {
            throw new IllegalArgumentException("El correo del usuario no puede estar vacío");
        }
        if (usuario.getContraseniaUsuario() == null || usuario.getContraseniaUsuario().trim().isEmpty()) {
            throw new IllegalArgumentException("La contraseña del usuario no puede estar vacía");
        }
        if (usuario.getDireccion() == null || usuario.getDireccion().getDescripcionDireccion().trim().isEmpty()) {
            throw new IllegalArgumentException("La dirección no puede estar vacía");
        }
        if (usuario.getDireccion().getCodigoPostal() == null || usuario.getDireccion().getCodigoPostal().trim().isEmpty()) {
            throw new IllegalArgumentException("El código postal no puede estar vacío");
        }
        if (usuario.getDireccion().getDistrito() == null || usuario.getDireccion().getDistrito().getIdDistrito() <= 0) {
            throw new IllegalArgumentException("El distrito es inválido");
        }
        if (usuario.getRol() == null || usuario.getRol().getIdRol() <= 0) {
            throw new IllegalArgumentException("El rol es inválido");
        }

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
    @Transactional // Asegúrate de que esté anotado
    public Usuario registerUsuario(Usuario usuario) {

        // Verificación de correo existente
        int existe = usuarioRepo.verifyCorreoProcedureUsuario(usuario.getCorreoUsuario());
        String encriptedPassword = seguridad.encriptPassword(usuario.getContraseniaUsuario());

        if (existe > 0) {
            throw new RuntimeException("El correo ya está en uso.");
        }

        // Validaciones básicas
        if (usuario.getCorreoUsuario().equals("")) {
            throw new RuntimeException("Debe ingresar un correo");
        }

        if (encriptedPassword == null || encriptedPassword.equals("")) {
            throw new RuntimeException("Debe ingresar una contraseña");
        }

        if (usuario.getNombreUsuario().equals("")) {
            throw new RuntimeException("Debe ingresar un nombre de usuario");
        }

        if (usuario.getPrimerApellido().equals("")) {
            throw new RuntimeException("Debe ingresar el primer apellido");
        }

        if (usuario.getSegundoApellido().equals("")) {
            throw new RuntimeException("Debe ingresar el segundo apellido");
        }
        //System.out.println("Usuario registrado: " + usuario.getNombreUsuario() + " " + usuario.getPrimerApellido() + " " + usuario.getSegundoApellido());
        usuario.setEstadoUsuario(true);

        usuarioRepo.registerProcedureUsuario(
                usuario.getCorreoUsuario(),
                encriptedPassword,
                usuario.getNombreUsuario(),
                usuario.getPrimerApellido(),
                usuario.getSegundoApellido(),
                usuario.isEstadoUsuario()
        );

        return usuario;
    }

// -----------------------------------------------------------------------------  
    @Override
    @Transactional // Asegúrate de que esté anotado
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
            if (usuario.getDireccion().getDescripcionDireccion() != null) {
                descripcionDireccion = usuario.getDireccion().getDescripcionDireccion();
            }
            if (usuario.getDireccion().getCodigoPostal() != null) {
                codigoPostalDireccion = usuario.getDireccion().getCodigoPostal();
            }
            if (usuario.getDireccion().getDistrito() != null) {
                idDistrito = usuario.getDireccion().getDistrito().getIdDistrito();
            }
        } else {
            Usuario existingUsuario = usuarioRepo.findById(usuario.getIdUsuario()).orElse(null);
            if (existingUsuario != null && existingUsuario.getDireccion() != null) {
                if (existingUsuario.getDireccion().getDescripcionDireccion() != null) {
                    descripcionDireccion = existingUsuario.getDireccion().getDescripcionDireccion();
                }
                if (existingUsuario.getDireccion().getCodigoPostal() != null) {
                    codigoPostalDireccion = existingUsuario.getDireccion().getCodigoPostal();
                }
                if (existingUsuario.getDireccion().getDistrito() != null) {
                    idDistrito = existingUsuario.getDireccion().getDistrito().getIdDistrito();
                }
            }
        }
        usuario.setEstadoUsuario(true);
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
                idDistrito,
                usuario.isEstadoUsuario()
        );

        return usuario;
    }

// -----------------------------------------------------------------------------    
    @Override
    @Transactional
    public List<Usuario> getUsuario() {
        return usuarioRepo.listProcedureUsuario();
    }

// -----------------------------------------------------------------------------    
    @Override
    public boolean deleteUsuario(int id) {
        try {
            usuarioRepo.deleteProcedureUsuario(id);
            return true;
        } catch (Exception e) {
            System.out.println("Error al eliminar el usuario con id: " + id);
            e.printStackTrace();
            return false;
        }
    }
// -----------------------------------------------------------------------------    

    @Override
    public Usuario validateLogin(String correo, String contraseniaIngresada) {
        Usuario usuario = usuarioRepo.searchUsuario(correo);

        if (usuario == null) {
            System.out.println("Usuario no encontrado para el correo: " + correo);
            return null;
        }

        System.out.println("Usuario encontrado: " + usuario.getNombreUsuario());

        if (contraseniaIngresada == null || contraseniaIngresada.isEmpty()) {
            System.out.println("La contraseña ingresada es nula o vacía para el correo: " + correo);
            return null;
        }

        boolean validPassword = seguridad.validatePassword(contraseniaIngresada, usuario.getContraseniaUsuario());
        if (!validPassword) {
            System.out.println("Contraseña incorrecta para el correo: " + correo);
            return null;
        }

        // Generar el token utilizando el jwtService
        String token = jwt.generateToken(usuario.getCorreoUsuario());

        usuario.setToken(token);

        return usuario; // Devuelve el objeto Usuario con el token
    }

// ----------------------------------------------------------------------------- 
    @Override
    public Usuario searchCorreoUsuario(String correo) {
        Usuario usuario = usuarioRepo.searchUsuario(correo);

        if (usuario == null) {
            System.out.println("Usuario no encontrado para el correo: " + correo);
            return null;
        }

        return usuario;
    }

    @Override
    public Usuario actualizarContrasena(Usuario usuario) {
        try {
            // Verificar si el comentario existe
            if (!usuarioRepo.existsById(usuario.getIdUsuario())) { // Verifica si el comentario existe
                System.err.println("El usuario con ID: " + usuario.getIdUsuario() + " no existe.");
                return usuario; // Retorna false si no existe
            }
            String encriptedPassword = seguridad.encriptPassword(usuario.getContraseniaUsuario());
            System.out.println("Actualizando usuario con ID: " + usuario.getIdUsuario());
            usuarioRepo.UpdateProcedureContrasena(usuario.getIdUsuario(), encriptedPassword);
            return usuario; // Retorna true si se eliminó exitosamente
        } catch (Exception e) {
            System.err.println("Error al actualizar el  usuario con ID: " + usuario.getIdUsuario() + ". Detalles: " + e.getMessage());
            return usuario; // Retorna false en caso de error
        }
    }

}

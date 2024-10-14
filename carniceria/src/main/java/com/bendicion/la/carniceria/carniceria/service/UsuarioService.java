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
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;

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

        // Ejecutar el procedimiento almacenado usando StoredProcedureQuery
        StoredProcedureQuery query = entityManager
            .createStoredProcedureQuery("spRegistrarUsuario")
            .registerStoredProcedureParameter("correoUsuario", String.class, ParameterMode.IN)
            .registerStoredProcedureParameter("contraseniaUsuario", String.class, ParameterMode.IN)
            .registerStoredProcedureParameter("nombreUsuario", String.class, ParameterMode.IN)
            .registerStoredProcedureParameter("primerApellido", String.class, ParameterMode.IN)
            .registerStoredProcedureParameter("SegundoApellido", String.class, ParameterMode.IN)
            .registerStoredProcedureParameter("salida", Integer.class, ParameterMode.OUT);

        // Asignar parámetros al procedimiento
        query.setParameter("correoUsuario", usuario.getCorreoUsuario());
        query.setParameter("contraseniaUsuario", encriptedPassword);
        query.setParameter("nombreUsuario", usuario.getNombreUsuario());
        query.setParameter("primerApellido", usuario.getPrimerApellido());
        query.setParameter("SegundoApellido", usuario.getSegundoApellido());

        // Ejecutar el procedimiento
        query.execute();

        // Obtener el valor del parámetro de salida (opcional, dependiendo del procedimiento)
        Integer salida = (Integer) query.getOutputParameterValue("salida");
        System.out.println("Resultado del procedimiento: " + salida);

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
    public Usuario searchCorreoUsuario(String correo){
        Usuario usuario = usuarioRepo.searchUsuario(correo);
        
        if (usuario == null) {
            System.out.println("Usuario no encontrado para el correo: " + correo);
            return null;
        }
        
        return usuario; 
    }
    
// -----------------------------------------------------------------------------    
    
    public String getSalida(){
        return usuarioRepo.getSalida();
    }
}

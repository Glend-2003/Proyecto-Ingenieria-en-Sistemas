package com.bendicion.la.carniceria.carniceria.service;

import java.sql.Date;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.bendicion.la.carniceria.carniceria.Logic.JwtService;
import com.bendicion.la.carniceria.carniceria.Logic.Seguridad;
import com.bendicion.la.carniceria.carniceria.domain.Usuario;
import com.bendicion.la.carniceria.carniceria.jpa.UsuarioCodigoRepository;
import com.bendicion.la.carniceria.carniceria.jpa.UsuarioRepository;

import jakarta.transaction.Transactional;

@Service
@Primary
public class UsuarioService implements IUsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepo;

    @Autowired
    private Seguridad seguridad;

    @Autowired
    private JwtService jwt;

    @Autowired
    private UsuarioCodigoRepository usuarioCodigoRepo;

    @Autowired
    private CorreoService correoService;

    @Override
    @Transactional
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

    @Override
    @Transactional
    public Usuario registerUsuario(Usuario usuario) {
        int rolCliente = 3;

        int existe = usuarioRepo.verifyCorreoProcedureUsuario(usuario.getCorreoUsuario());
        String encriptedPassword = seguridad.encriptPassword(usuario.getContraseniaUsuario());

        if (existe > 0) {
            throw new RuntimeException("El correo ya está en uso.");
        }

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

        String numCodigo = generateCodigo();

        Integer idRol = (usuario.getRol() != null) ? usuario.getRol().getIdRol() : rolCliente;

        // Registrar el usuario
        usuario.setEstadoUsuario(true);

        usuarioRepo.registerProcedureUsuario(
                usuario.getCorreoUsuario(),
                encriptedPassword,
                usuario.getNombreUsuario(),
                usuario.getPrimerApellido(),
                usuario.getSegundoApellido(),
                idRol,
                usuario.isEstadoUsuario(),
                numCodigo
        );

        return usuario;
    }

    @Override
    public String generateCodigo() {
        Random random = new Random();
        return String.format("%06d", random.nextInt(1000000));
    }

    @Override
    @Transactional
    public void getCodigo(String correoUsuario) {
        try {

            Usuario usuario = usuarioRepo.searchUsuario(correoUsuario);

            if (usuario == null) {
                throw new RuntimeException("El correo no está registrado");
            }

            String numCodigo = usuarioCodigoRepo.obtenerCodigoUsuario(correoUsuario);

            if (numCodigo == null) {
                throw new RuntimeException("No se encontró un código de verificación para este usuario");
            }

            String asunto = "Código de Verificación";
            String mensajeHTML = crearMensajeHTML(numCodigo);

            correoService.enviarMensaje(correoUsuario, asunto, mensajeHTML);

            System.out.println("Código de verificación enviado a: " + correoUsuario);
        } catch (Exception e) {
            throw new RuntimeException("Error al verificar el correo y enviar el código: " + e.getMessage());
        }
    }

    private String crearMensajeHTML(String numCodigo) {
        return "<!DOCTYPE html>"
                + "<html lang='es'>"
                + "<head>"
                + "    <meta charset='UTF-8'>"
                + "    <meta name='viewport' content='width=device-width, initial-scale=1.0'>"
                + "    <title>Código de Verificación</title>"
                + "    <style>"
                + "        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }"
                + "        .container { max-width: 600px; margin: 20px auto; background-color: #ffffff; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); border: 1px solid #dddddd; }"
                + // Agregar borde
                "        h1 { color: #333333; }"
                + "        p { color: #555555; line-height: 1.6; }"
                + "        .code { font-size: 24px; font-weight: bold; color: #007BFF; margin: 20px 0; }"
                + "        .footer { margin-top: 20px; font-size: 12px; color: #888888; }"
                + "    </style>"
                + "</head>"
                + "<body>"
                + "    <div class='container'>"
                + "        <h1>Código de Verificación</h1>"
                + "        <p>Estimado usuario de Carnicería La Bendición:</p>"
                + "        <p>Recibimos una solicitud para acceder a tu cuenta. Tu código de verificación es:</p>"
                + "        <div class='code'>" + numCodigo + "</div>"
                + "        <p>Si no solicitaste este código, es posible que otra persona esté intentando acceder a tu cuenta. No reenvíes ni proporciones este código a otra persona.</p>"
                + "        <p>Gracias por ser parte de la familia de Carnicería La Bendición. ¡Esperamos verte pronto!</p>"
                + "        <div class='footer'>"
                + "            <p>Atentamente,</p>"
                + "            <p>El equipo de Carnicería La Bendición</p>"
                + "        </div>"
                + "    </div>"
                + "</body>"
                + "</html>";
    }

    @Override
    @Transactional
    public String cambiarContrasenaConCodigo(String numCodigo, String nuevaContrasenia) {
        try {
            String nuevoCodigo = generateCodigo();
            String encriptedPassword = seguridad.encriptPassword(nuevaContrasenia);

            int resultado = usuarioRepo.cambiarContrasenaConCodigo(numCodigo, encriptedPassword, nuevoCodigo);

            if (resultado == 0) {
                throw new RuntimeException("Código de verificación inválido");
            } else if (resultado == 1) {
                return "Contraseña cambiada con éxito";
            } else {
                throw new RuntimeException("Error desconocido al cambiar la contraseña");
            }
        } catch (Exception e) {
            throw new RuntimeException("Error al cambiar la contraseña: " + e.getMessage());
        }
    }

    @Override
    @Transactional
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
                usuario.getRol().getIdRol(),
                usuario.isEstadoUsuario()
        );

        return usuario;
    }

    @Override
    @Transactional
    public List<Usuario> getUsuario() {
        return usuarioRepo.listProcedureUsuario();
    }

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

        String token = jwt.generateToken(usuario.getCorreoUsuario());

        usuario.setToken(token);

        return usuario;
    }

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

            if (!usuarioRepo.existsById(usuario.getIdUsuario())) {
                System.err.println("El usuario con ID: " + usuario.getIdUsuario() + " no existe.");
                return usuario;
            }
            String encriptedPassword = seguridad.encriptPassword(usuario.getContraseniaUsuario());
            System.out.println("Actualizando usuario con ID: " + usuario.getIdUsuario());
            usuarioRepo.UpdateProcedureContrasena(usuario.getIdUsuario(), encriptedPassword);
            return usuario;
        } catch (Exception e) {
            System.err.println("Error al actualizar el  usuario con ID: " + usuario.getIdUsuario() + ". Detalles: " + e.getMessage());
            return usuario;
        }
    }

    @Override
    public Usuario getUsuarioById(int id) {
        return usuarioRepo.listProcedureUsuarioById(id);
    }

    @Override
    @Transactional
    public boolean activarUsuario(int id) {
        try {

            if (!usuarioRepo.existsById(id)) {
                System.err.println("El usuario con ID: " + id + " no existe.");
                return false;
            }

            System.out.println("activando usuario con ID: " + id);
            usuarioRepo.activarUsuario(id);
            return true;
        } catch (Exception e) {
            System.err.println("Error al activar el usuario con ID: " + id + ". Detalles: " + e.getMessage());
            return false;
        }
    }

    @Override
    @Transactional
    public Usuario actualizarCredenciales(Usuario usuario) {
        try {
            usuario.setEstadoUsuario(true);
            usuarioRepo.actualizarCredenciales(
                    usuario.getIdUsuario(),
                    usuario.getCedulaUsuario(),
                    usuario.getNombreUsuario(),
                    usuario.getPrimerApellido(),
                    usuario.getSegundoApellido(),
                    usuario.getTelefonoUsuario(),
                    usuario.getFechaNacimiento()
            );
            return usuario;
        } catch (Exception e) {
            throw new RuntimeException("Error al actualizar credenciales: " + e.getMessage());
        }
    }

}

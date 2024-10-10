package com.bendicion.la.carniceria.carniceria.Logic;
import at.favre.lib.crypto.bcrypt.BCrypt;
import org.springframework.context.annotation.Configuration;

/**
 *
 * @author Jamel Sandí
 */

@Configuration
public class Seguridad {
    
    // Para encriptar
    public String encriptPassword(String contrasenia) {
        return BCrypt.withDefaults().hashToString(12, contrasenia.toCharArray());
    }

    // Para validar si la contra es la real en el login
    public boolean validatePassword(String contraseniaIngresada, String contraseniaEncriptada) {
        return BCrypt.verifyer().verify(contraseniaIngresada.toCharArray(), contraseniaEncriptada).verified;
    }
}

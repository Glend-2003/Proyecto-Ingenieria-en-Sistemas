package com.bendicion.la.carniceria.carniceria.Logic;
import org.springframework.context.annotation.Configuration;

import at.favre.lib.crypto.bcrypt.BCrypt;


@Configuration
public class Seguridad {
    
    public String encriptPassword(String contrasenia) {
        return BCrypt.withDefaults().hashToString(12, contrasenia.toCharArray());
    }

    public boolean validatePassword(String contraseniaIngresada, String contraseniaEncriptada) {
        return BCrypt.verifyer().verify(contraseniaIngresada.toCharArray(), contraseniaEncriptada).verified;
    }
}

// ConfiguracionMultipart.java
package com.bendicion.la.carniceria.carniceria.config;

import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.unit.DataSize;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;

import jakarta.servlet.MultipartConfigElement;

@Configuration
public class ConfiguracionMultipart {

    /**
     * Configuración del tamaño máximo para la carga de archivos
     * @return ConfigElement para Multipart
     */
    @Bean
    public MultipartConfigElement multipartConfigElement() {
        MultipartConfigFactory factory = new MultipartConfigFactory();
        
        // Configurar tamaño máximo de archivo a 10MB
        factory.setMaxFileSize(DataSize.ofMegabytes(10));
        
        // Configurar tamaño máximo de solicitud a 15MB
        factory.setMaxRequestSize(DataSize.ofMegabytes(15));
        
        // Configurar umbral de tamaño para archivos temporales (opcional)
        factory.setFileSizeThreshold(DataSize.ofKilobytes(2));
        
        return factory.createMultipartConfig();
    }

    /**
     * Resolver para manejar solicitudes multipart
     * @return MultipartResolver
     */
    @Bean
    public MultipartResolver multipartResolver() {
        return new StandardServletMultipartResolver();
    }
}
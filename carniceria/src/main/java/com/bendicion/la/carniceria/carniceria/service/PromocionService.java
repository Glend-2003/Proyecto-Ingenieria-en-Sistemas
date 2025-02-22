/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.bendicion.la.carniceria.carniceria.service;

import com.bendicion.la.carniceria.carniceria.domain.Promocion;

import com.bendicion.la.carniceria.carniceria.jpa.PromocionRepository;
import jakarta.transaction.Transactional;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
   import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.SimpleMailMessage;

/**
 *
 * @author Dilan Gutierrez
 */
@Service
@Primary
public class PromocionService implements IPromocionService {

    @Autowired
    private PromocionRepository promocionRepo;

    @Autowired
    private JavaMailSender mailSender;

    //Listar promociones
    @Override
    @Transactional
    public List<Map<String, Object>> getPromociones() {
        List<Object[]> resultados = promocionRepo.listaPromocion();

        // Mapea cada fila a un mapa de claves y valores
        return resultados.stream().map(fila -> Map.of(
                "idPromocion", fila[0],
                "descripcionPromocion", fila[1],
                "fechaInicioPromocion", fila[2],
                "fechaFinPromocion", fila[3],
                "montoPromocion", fila[4],
                "estadoPromocion", fila[5],
                "nombreProducto", fila[6]
        )).toList();
    }

    @Transactional
    @Override
    public Promocion addPromocion(Promocion promocion) {

        if (promocion.getFechaInicioPromocion() == null) {
            throw new IllegalArgumentException("Debe ingresar una fecha de inicio");
        }
        if (promocion.getFechaFinPromocion() == null) {
            throw new IllegalArgumentException("Debe ingresar una fecha de fin");
        }

        Date fechaInicio = promocion.getFechaInicioPromocion();
        Date fechaFin = promocion.getFechaFinPromocion();

        LocalDate fechaInicioPromocion = fechaInicio.toInstant()
                .atZone(ZoneId.systemDefault())
                .toLocalDate();

        LocalDate fechaFinPromocion = fechaFin.toInstant()
                .atZone(ZoneId.systemDefault())
                .toLocalDate();

// Obtener la fecha actual
        LocalDate fechaActual = LocalDate.now();

//  Permitir la fecha actual y futuras
        if (fechaInicioPromocion.isBefore(fechaActual)) {
            throw new IllegalArgumentException("La fecha de inicio de la promoción no puede ser anterior a la fecha actual");
        }

//  La fecha de fin debe ser igual o posterior a la fecha de inicio
        if (fechaFinPromocion.isBefore(fechaInicioPromocion)) {
            throw new IllegalArgumentException("La fecha de fin de la promoción debe ser posterior o igual a la fecha de inicio");
        }

        if (promocion.getMontoPromocion() == null || promocion.getMontoPromocion().compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("El monto debe ser mayor a cero");
        }

        if (promocion.getProducto() == null) {
            throw new IllegalArgumentException("Usuario is required for adding a comment.");
        }

        //Llamada al stored procedure para guardar
        promocionRepo.saveProcedurePromocion(
                promocion.getDescripcionPromocion(),
                promocion.getFechaInicioPromocion(),
                promocion.getFechaFinPromocion(),
                promocion.getMontoPromocion(),
                promocion.getProducto().getIdProducto()
        );
        System.out.println("Datos recibidos: " + promocion.toString());
        return promocion;
    }

    @Override
    @Transactional
    public Promocion updatePromocion(Promocion promocion) {
        //Llamada al stored procedure para guardar
        promocionRepo.updateProcedurePromocion(
                promocion.getIdPromocion(),
                promocion.getDescripcionPromocion(),
                promocion.getFechaInicioPromocion(),
                promocion.getFechaFinPromocion(),
                promocion.getMontoPromocion(),
                promocion.getProducto().getIdProducto()
        );
        System.out.println("Datos recibidos: " + promocion.toString());
        return promocion;
    }

    @Override
    public boolean deletePromocion(int id) {
        try {
            System.out.println("Eliminando Promocion con ID: " + id);
            promocionRepo.deleteProcedurePromoocion(id);
            return true;
        } catch (Exception e) {
            System.err.println("Error al eliminar la promocion con ID: " + id + ". Detalles: " + e.getMessage());
            return false;
        }
    }

    @Transactional 
     public void enviarMensaje(String destino, String sujeto, String mensaje) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(destino);
            message.setSubject(sujeto);
            message.setText(mensaje);
            mailSender.send(message);
            System.out.println("Correo enviado a: " + destino);
        } catch (Exception e) {
            System.err.println("Error al enviar el correo a " + destino + ": " + e.getMessage());
        }
    }

 

public String mensajePredeterminado(String nombre, String descripcion, Date inicioPromocion, Date finPromocion, BigDecimal montoPromocion) {
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy"); // Formato de fecha legible
    String inicio = dateFormat.format(inicioPromocion);
    String fin = dateFormat.format(finPromocion);
    
    return String.format(
            "¡Hola %s!\n\n"
            + "¡Esperamos que estés teniendo un excelente día!\n\n"
            + "En Carnicería La Bendición, nos complace anunciarte nuestra nueva promoción especial diseñada pensando en ti:\n\n"
            + "✨ Producto en promoción: **%s** ✨\n\n"
            + "📅 **Disponible desde** %s **hasta** %s.\n\n"
            + "🌟 **Por solo %s colones**, podrás disfrutar de los mejores productos que ofrece Carnicería La Bendición.\n\n"
            + "Disfruta de la calidad y los beneficios que ofrecemos solo para ti!\n\n"
            + "No dejes pasar esta oportunidad, ¡te estamos esperando!\n\n"
            + "¡Aprovecha esta promoción antes de que termine!**\n\n"
            + "Gracias por ser parte de la familia de Carnicería La Bendición. ¡Esperamos verte pronto!\n\n"
            + "Con cariño,\n"
            + "El equipo de Carnicería La Bendición",
            nombre, descripcion, inicio, fin, montoPromocion.toString()
    );
}

}

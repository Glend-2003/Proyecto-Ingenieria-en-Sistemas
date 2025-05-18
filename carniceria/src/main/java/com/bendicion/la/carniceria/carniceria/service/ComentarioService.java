package com.bendicion.la.carniceria.carniceria.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.bendicion.la.carniceria.carniceria.domain.Comentario;
import com.bendicion.la.carniceria.carniceria.jpa.ComentarioRepository;

import jakarta.transaction.Transactional;

@Service
@Primary
public class ComentarioService implements IComentarioService {

    @Autowired
    private ComentarioRepository comentarioRepo;

    @Transactional
    @Override
    public Comentario addComentario(Comentario comentario) {

        if (comentario.getUsuario() == null) {
            throw new IllegalArgumentException("Usuario is required for adding a comment.");
        }

        int existe = comentarioRepo.verifyIDProcedureUsuario(comentario.getUsuario().getIdUsuario());
        if (existe == 0) {
            throw new IllegalArgumentException("El usuario no existe");
        }

        comentarioRepo.saveProcedureComentario(
                comentario.getDescripcionComentario(),
                LocalDateTime.now(),
                comentario.getUsuario().getIdUsuario(),
                comentario.getNumCalificacion()
        );
        System.out.println("Datos recibidos: " + comentario.toString());
        return comentario;
    }

    @Override
    @Transactional
    public List<Map<String, Object>> getComentariosAdmin() {
        List<Object[]> resultados = comentarioRepo.leerComentariosAdmin();

        return resultados.stream().map(fila -> Map.of(
                "idComentario", fila[0],
                "descripcionComentario", fila[1],
                "fechaComentario", fila[2],
                "correoUsuario", fila[3],
                "numCalificacion", fila[4],
                "verificacion", fila[5]
        )).toList();
    }

    @Transactional
    @Override
    public Comentario updateComentario(Comentario comentario) {
        System.out.println("Actualizando comentario con ID: " + comentario.getIdComentario());
        System.out.println("Descripción: " + comentario.getDescripcionComentario());

        comentarioRepo.updateProcedureComentario(
                comentario.getIdComentario(),
                comentario.getDescripcionComentario(),
                LocalDateTime.now(),
                comentario.getUsuario().getIdUsuario(),
                comentario.getNumCalificacion()
        );

        return comentario;
    }

    @Override
    public boolean activarComentario(int id) {
        try {

            if (!comentarioRepo.existsById(id)) {
                System.err.println("El comentario con ID: " + id + " no existe.");
                return false;
            }

            System.out.println("Eliminando Comentario con ID: " + id);
            comentarioRepo.activarProcedureComentario(id);
            return true;
        } catch (Exception e) {
            System.err.println("Error al eliminar el comentario con ID: " + id + ". Detalles: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean mostrarComentario(int id) {
        try {

            if (!comentarioRepo.existsById(id)) {
                System.err.println("El comentario con ID: " + id + " no existe.");
                return false;
            }

            System.out.println("Mostrando Comentario con ID: " + id);
            comentarioRepo.mostrarComentario(id);
            return true;
        } catch (Exception e) {
            System.err.println("Error al verificar el comentario con ID: " + id + ". Detalles: " + e.getMessage());
            return false;
        }
    }

    @Override
    @Transactional
    public List<Comentario> getComentariosUsuario() {
        return comentarioRepo.leerComentariosUsuario();
    }

}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.bendicion.la.carniceria.carniceria.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.bendicion.la.carniceria.carniceria.domain.Comentario;
import com.bendicion.la.carniceria.carniceria.jpa.ComentarioRepository;

import jakarta.transaction.Transactional;

/**
 *
 * @author Dilan Gutierrez
 */
@Service
@Primary
public class ComentarioService implements IComentarioService {

    @Autowired
    private ComentarioRepository comentarioRepo;

    @Transactional
    @Override
    public Comentario addComentario(Comentario comentario) {
        //System.out.println(comentario.getUsuario().getNombreUsuario() + " Hizo un comentario  ");

        // Verifica si el usuario existe
        if (comentario.getUsuario() == null) {
            throw new IllegalArgumentException("Usuario is required for adding a comment.");
        }
        
        int existe = comentarioRepo.verifyIDProcedureUsuario(comentario.getUsuario().getIdUsuario());
        if (existe == 0) {
            throw new IllegalArgumentException("El usuario no existe");
        }

        // Llama al procedimiento almacenado para insertar el comentario
        comentarioRepo.saveProcedureComentario(
                comentario.getDescripcionComentario(),
                LocalDateTime.now(), // Suponiendo que quieres usar la fecha y hora actual
                comentario.getUsuario().getIdUsuario(),
                comentario.getNumCalificacion()
        );

        return comentario; // Retorna el comentario
    }

    @Override
    @Transactional
    public List<Comentario> getComentariosAdmin() {
        return comentarioRepo.leerComentariosAdmin();
    }

    @Transactional
    @Override
    public Comentario updateComentario(Comentario comentario) {
        System.out.println("Actualizando comentario con ID: " + comentario.getIdComentario());
        System.out.println("Descripción: " + comentario.getDescripcionComentario());

        // Llama al procedimiento almacenado
        comentarioRepo.updateProcedureComentario(
                comentario.getIdComentario(),
                comentario.getDescripcionComentario(),
                LocalDateTime.now(),
                comentario.getUsuario().getIdUsuario(),
                comentario.getNumCalificacion()
        );

        return comentario; // Retorna el comentario actualizado
    }

    @Override
    public boolean deleComentario(int id) {
        try {
            // Verificar si el comentario existe
            if (!comentarioRepo.existsById(id)) { // Verifica si el comentario existe
                System.err.println("El comentario con ID: " + id + " no existe.");
                return false; // Retorna false si no existe
            }

            System.out.println("Eliminando Comentario con ID: " + id);
            comentarioRepo.deleteProcedureComentario(id);
            return true; // Retorna true si se eliminó exitosamente
        } catch (Exception e) {
            System.err.println("Error al eliminar el comentario con ID: " + id + ". Detalles: " + e.getMessage());
            return false; // Retorna false en caso de error
        }
    }

    @Override
    public boolean mostrarComentario(int id) {
        try {
            // Verificar si el comentario existe
            if (!comentarioRepo.existsById(id)) { // Verifica si el comentario existe
                System.err.println("El comentario con ID: " + id + " no existe.");
                return false; // Retorna false si no existe
            }

            System.out.println("Mostrando Comentario con ID: " + id);
            comentarioRepo.mostrarComentario(id);
            return true; // Retorna true si se eliminó exitosamente
        } catch (Exception e) {
            System.err.println("Error al verificar el comentario con ID: " + id + ". Detalles: " + e.getMessage());
            return false; // Retorna false en caso de error
        }
    }

    @Override
    @Transactional
    public List<Comentario> getComentariosUsuario() {
        return comentarioRepo.leerComentariosUsuario();
    }

}

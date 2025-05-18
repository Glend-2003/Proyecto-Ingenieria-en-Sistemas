/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.bendicion.la.carniceria.carniceria.jpa;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.bendicion.la.carniceria.carniceria.domain.Comentario;

/**
 *
 * @author Dilan Gutierrez
 */
@Repository
public interface ComentarioRepository extends JpaRepository<Comentario, Integer> {

    // SP Add 
    @Modifying
    @Query(value = "CALL spAgregarComentario(:descripcionComentario, :fechaComentario, :idUsuario, :numCalificacion)", nativeQuery = true)
    void saveProcedureComentario(
            @Param("descripcionComentario") String descripcionComentario,
            @Param("fechaComentario") LocalDateTime fechaComentario,
            @Param("idUsuario") int idUsuario,
            @Param("numCalificacion") int numCalificacion
    );

// -----------------------------------------------------------------------------
    // SP para buscar el usuario por medio del id, para verificar si existe
    @Query(value = "{call spVerificarIDUsuario(:idUsuario)}", nativeQuery = true)
    int verifyIDProcedureUsuario(@Param("idUsuario") int idUsuario);

    @Query(value = "{call spLeerComentarios()}", nativeQuery = true)
    List<Object[]> leerComentariosAdmin();

    @Modifying
    @Query(value = "CALL spActualizarComentario(:idComentario, :descripcionComentario, :fechaComentario, :idUsuario, :numCalificacion)", nativeQuery = true)
    void updateProcedureComentario(@Param("idComentario") int idComentario,
            @Param("descripcionComentario") String descripcionComentario,
            @Param("fechaComentario") LocalDateTime fechaComentario,
            @Param("idUsuario") int idUsuario,
            @Param("numCalificacion") int numCalificacion);

    // SP Delete
    @Query(value = "{call spActivarComentario(:idComentario)}", nativeQuery = true)
    void activarProcedureComentario(@Param("idComentario") Integer idComentario);
    
     // SP Delete
    @Query(value = "{call spMostrarComentario(:idComentario)}", nativeQuery = true)
    void mostrarComentario(@Param("idComentario") Integer idComentario);

    @Query(value = "{call spLeerComentariosUsuario()}", nativeQuery = true)
    List<Comentario> leerComentariosUsuario();
}

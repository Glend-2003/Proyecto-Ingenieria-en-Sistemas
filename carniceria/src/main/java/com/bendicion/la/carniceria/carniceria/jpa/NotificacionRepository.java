/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.bendicion.la.carniceria.carniceria.jpa;

import com.bendicion.la.carniceria.carniceria.domain.Notificacion;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Dilan
 */
@Repository
public interface NotificacionRepository extends JpaRepository<Notificacion, Integer>{
    
     @Query(value = "{call spLeerNotificacion(:leidos)}", nativeQuery = true)
    List<Notificacion> listProcedureNotificacion(@Param("leidos") Boolean leidos);
    
     @Query(value = "{call spMarcarNotificacionLeida(:idNotificacion)}", nativeQuery = true)
    void leerNotificacion(@Param("idNotificacion") Integer idNotificacion);
    
    @Query(value = "{call spEliminarNotificacion(:idNotificacion)}", nativeQuery = true)
    void deleteProcedureNotificacion(@Param("idNotificacion") Integer idNotificacion);
    
     @Query(value = "{call spAgregarNotificacion(:descripcionNotificacion, :idUsuario, :fechaNotificacion)}", nativeQuery = true)
    void saveProcedureNotificacion(
        @Param("descripcionNotificacion") String descripcionNotificacion, 
        @Param("idUsuario") int idUsuario,
        @Param("fechaNotificacion") LocalDate fechaNotificacion
    );
}

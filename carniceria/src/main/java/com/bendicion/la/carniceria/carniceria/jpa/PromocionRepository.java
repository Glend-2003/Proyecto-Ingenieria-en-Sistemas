/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.bendicion.la.carniceria.carniceria.jpa;

import com.bendicion.la.carniceria.carniceria.domain.Promocion;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Dilan Gutierrez
 */

@Repository
public interface PromocionRepository extends JpaRepository<Promocion, Integer>{
    
        // Sp Add
    @Modifying
    @Query(value = "{call spAgregarPromocion(:descripcionPromocion, :fechaInicioPromocion, :fechaFinPromocion, :montoPromocion, :idProducto)}", nativeQuery = true)
    void saveProcedurePromocion(
        @Param("descripcionPromocion") String descripcionPromocion, 
        @Param("fechaInicioPromocion") Date fechaInicioPromocion,
        @Param("fechaFinPromocion") Date fechaFinPromocion,
        @Param("montoPromocion") BigDecimal montoPromocion,
        @Param("idProducto") Integer idProducto
       
    );
  
// -----------------------------------------------------------------------------
    
    // SP Read
    @Query(value = "{call spLeerPromociones()}", nativeQuery = true)
    List<Object[]> listaPromocion();
    
// -----------------------------------------------------------------------------    
    
       // Sp Update
    @Modifying
    @Query(value = "{call spActualizarPromocion(:idPromocion, :descripcionPromocion, :fechaInicioPromocion, :fechaFinPromocion, :montoPromocion, :idProducto)}", nativeQuery = true)
    void updateProcedurePromocion(
        @Param("idPromocion") Integer idPromocion,
       @Param("descripcionPromocion") String descripcionPromocion, 
        @Param("fechaInicioPromocion") Date fechaInicioPromocion,
        @Param("fechaFinPromocion") Date fechaFinPromocion,
        @Param("montoPromocion") BigDecimal montoPromocion,
        @Param("idProducto") Integer idProducto
    );

   
// -----------------------------------------------------------------------------   
    
      // SP Delete
    @Query(value = "{call spEliminarPromocion(:idPromocion)}", nativeQuery = true)
    void deleteProcedurePromoocion(@Param("idPromocion") Integer idPromocion);
    
   @Query(value = "{call spActivarPromocion(:idPromocion)}", nativeQuery = true)
    void activarPromocion(@Param("idPromocion") Integer idPromocion);
    
}

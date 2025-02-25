package com.bendicion.la.carniceria.carniceria.jpa;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.bendicion.la.carniceria.carniceria.domain.Categoria;

/**
 *
 * @author Jamel Sandí
 */

@Repository
public interface CategoriaRepository extends JpaRepository<Categoria, Integer>{
    
    // SP Add
    @Query(value = "{call spAgregarCategoria(:nombreCategoria, :descripcionCategoria, :estadoCategoria)}", nativeQuery = true)
    void saveProcedureCategoria(
        @Param("nombreCategoria") String nombreCategoria, 
        @Param("descripcionCategoria") String descripcionCategoria,
        @Param("estadoCategoria") Boolean estadoCategoria
    );

    // SP Update
    @Modifying
    @Query(value = "{call spActualizarCategoria(:idCategoria, :nombreCategoria, :descripcionCategoria, :estadoCategoria)}", nativeQuery = true)
    void updateProcedureCategoria(
        @Param("idCategoria") Integer idCategoria, 
        @Param("nombreCategoria") String nombreCategoria, 
        @Param("descripcionCategoria") String descripcionCategoria,
        @Param("estadoCategoria") Boolean estadoCategoria
    );
    // SP Read
    @Query(value = "{call spLeerCategoria(:estadoCategoria)}", nativeQuery = true)
    List<Categoria> listProcedureCategoria(@Param("estadoCategoria") Boolean estadoCategoria);

    //sp read by id
    @Query(value = "{call spLeerCategoriaPorId(:idCategoria)}", nativeQuery = true)
    Categoria listProcedureCategoriaById(@Param("idCategoria") Integer idCategoria);

    // SP Delete
    @Query(value = "{call spEliminarCategoria(:idCategoria)}", nativeQuery = true)
    void deleteProcedureCategoria(@Param("idCategoria") Integer idCategoria);

      @Query(value = "{call spActivarCategoria(:idCategoria)}", nativeQuery = true)
    void activarCategoria(@Param("idCategoria") Integer idCategoria);
    
}

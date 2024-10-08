package com.bendicion.la.carniceria.carniceria.jpa;
import com.bendicion.la.carniceria.carniceria.domain.Categoria;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Jamel Sandí
 */

@Repository
public interface CategoriaRepository extends JpaRepository<Categoria, Integer>{
    
    // SP Add
    @Query(value = "{call spAgregarCategoria(:nombreCategoria, :descripcionCategoria)}", nativeQuery = true)
    void saveProcedureCategoria(
        @Param("nombreCategoria") String nombreCategoria, 
        @Param("descripcionCategoria") String descripcionCategoria
    );

    // SP Update
    @Query(value = "{call spActualizarCategoria(:idCategoria, :nombreCategoria, :descripcionCategoria)}", nativeQuery = true)
    void updateProcedureCategoria(
        @Param("idCategoria") Integer idCategoria, 
        @Param("nombreCategoria") String nombreCategoria, 
        @Param("descripcionCategoria") String descripcionCategoria
    );
    
    // SP Read
    @Query(value = "{call spLeerCategoria()}", nativeQuery = true)
    List<Categoria> listProcedureCategoria();

    // SP Delete
    @Query(value = "{call spEliminarCategoria(:idCategoria)}", nativeQuery = true)
    void deleteProcedureCategoria(@Param("idCategoria") Integer idCategoria);

}

package com.bendicion.la.carniceria.carniceria.jpa;
import com.bendicion.la.carniceria.carniceria.domain.Rol;
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
public interface RolRepository extends JpaRepository<Rol, Integer>{
    
    // SP Add
    @Query(value = "{call spAgregarRol(:nombreRol, :descripcionRol)}", nativeQuery = true)
    void saveProcedureRol(
        @Param("nombreRol") String nombreRol, 
        @Param("descripcionRol") String descripcionRol
    );

    // SP Update
    @Query(value = "{call spActualizarRol(:idRol, :nombreRol, :descripcionRol)}", nativeQuery = true)
    void updateProcedureRol(
        @Param("idRol") Integer idRol, 
        @Param("nombreRol") String nombreRol, 
        @Param("descripcionRol") String descripcionRol
    );
    
    // SP Read
    @Query(value = "{call spLeerRol()}", nativeQuery = true)
    List<Rol> listProcedureRol();

    // SP Delete
    @Query(value = "{call spEliminarRol(:idRol)}", nativeQuery = true)
    void deleteProcedureRol(@Param("idRol") Integer idRol);
}

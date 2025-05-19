package com.bendicion.la.carniceria.carniceria.jpa;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.bendicion.la.carniceria.carniceria.domain.Rol;

@Repository
public interface RolRepository extends JpaRepository<Rol, Integer> {

    @Query(value = "{call spAgregarRol(:nombreRol, :descripcionRol, :estadoRol)}", nativeQuery = true)
    void saveProcedureRol(
            @Param("nombreRol") String nombreRol,
            @Param("descripcionRol") String descripcionRol,
            @Param("estadoRol") boolean estadoRol
    );

    @Query(value = "{call spActualizarRol(:idRol, :nombreRol, :descripcionRol, :estadoRol)}", nativeQuery = true)
    void updateProcedureRol(
            @Param("idRol") Integer idRol,
            @Param("nombreRol") String nombreRol,
            @Param("descripcionRol") String descripcionRol,
            @Param("estadoRol") boolean estadoRol
    );

    @Query(value = "{call spLeerRol()}", nativeQuery = true)
    List<Rol> listProcedureRol();

    @Query(value = "{call spEliminarRol(:idRol)}", nativeQuery = true)
    void deleteProcedureRol(@Param("idRol") Integer idRol);
}

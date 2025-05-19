package com.bendicion.la.carniceria.carniceria.jpa;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.bendicion.la.carniceria.carniceria.domain.Distrito;

@Repository
public interface DistritoRepository extends JpaRepository<Distrito, Integer> {

    @Query(value = "{call spLeerDistrito()}", nativeQuery = true)
    List<Distrito> listProcedureDistrito();

    @Query(value = "{call spObtenerDistritosPorCanton(:idCanton)}", nativeQuery = true)
    List<Distrito> listProcedureDistritoCanton(@Param("idCanton") int idCanton);
}

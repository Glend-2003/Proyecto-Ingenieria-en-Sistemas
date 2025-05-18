package com.bendicion.la.carniceria.carniceria.jpa;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.bendicion.la.carniceria.carniceria.domain.Canton;

public interface CantonRepository extends JpaRepository<Canton, Integer> {

    @Query(value = "{call spObtenerCantonesPorProvincia(:idProvincia)}", nativeQuery = true)
    List<Canton> listProcedureCantonProvincia(@Param("idProvincia") int idProvincia);
}

package com.bendicion.la.carniceria.carniceria.jpa;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.bendicion.la.carniceria.carniceria.domain.Provincia;

public interface ProvinciaRepository extends JpaRepository<Provincia, Integer> {

    @Query(value = "{call spObtenerProvincias()}", nativeQuery = true)
    List<Provincia> listProcedureProvincia();
}

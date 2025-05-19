package com.bendicion.la.carniceria.carniceria.jpa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import com.bendicion.la.carniceria.carniceria.domain.Direccion;

public interface DireccionRepository extends JpaRepository<Direccion, Integer> {

    @Procedure(procedureName = "spAgregarDireccionUsuario")
    int addDireccionUsuario(
            @Param("p_idUsuario") int idUsuario,
            @Param("p_descripcion") String descripcion,
            @Param("p_codigoPostal") String codigoPostal,
            @Param("p_idDistrito") int idDistrito);

}

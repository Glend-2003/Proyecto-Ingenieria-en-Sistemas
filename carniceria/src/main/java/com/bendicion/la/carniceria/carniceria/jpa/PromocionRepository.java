package com.bendicion.la.carniceria.carniceria.jpa;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.bendicion.la.carniceria.carniceria.domain.Promocion;

@Repository
public interface PromocionRepository extends JpaRepository<Promocion, Integer> {

    @Modifying
    @Query(value = "{call spAgregarPromocion(:descripcionPromocion, :fechaInicioPromocion, :fechaFinPromocion, :montoPromocion, :idProducto)}", nativeQuery = true)
    void saveProcedurePromocion(
            @Param("descripcionPromocion") String descripcionPromocion,
            @Param("fechaInicioPromocion") Date fechaInicioPromocion,
            @Param("fechaFinPromocion") Date fechaFinPromocion,
            @Param("montoPromocion") BigDecimal montoPromocion,
            @Param("idProducto") Integer idProducto
    );

    @Query(value = "{call spLeerPromociones()}", nativeQuery = true)
    List<Object[]> listaPromocion();

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

    @Query(value = "{call spEliminarPromocion(:idPromocion)}", nativeQuery = true)
    void deleteProcedurePromoocion(@Param("idPromocion") Integer idPromocion);

    @Query(value = "{call spActivarPromocion(:idPromocion)}", nativeQuery = true)
    void activarPromocion(@Param("idPromocion") Integer idPromocion);

}

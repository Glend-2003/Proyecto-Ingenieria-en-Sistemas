package com.bendicion.la.carniceria.carniceria.jpa;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.bendicion.la.carniceria.carniceria.domain.TipoPago;

@Repository
public interface TipoPagoRepository extends JpaRepository<TipoPago, Integer> {

    @Query(value = "{call spAgregarTipoPago(:descripcionTipoPago, :estadoTipoPago)}", nativeQuery = true)
    void saveProcedureTipoPago(
            @Param("descripcionTipoPago") String descripcionTipoPago,
            @Param("estadoTipoPago") Boolean estadoTipoPago
    );

    @Modifying
    @Query(value = "{call spActualizarTipoPago(:idTipoPago, :descripcionTipoPago, :estadoTipoPago)}", nativeQuery = true)
    void updateProcedureTipoPago(
            @Param("idTipoPago") Integer idTipoPago,
            @Param("descripcionTipoPago") String descripcionTipoPago,
            @Param("estadoTipoPago") Boolean estadoTipoPago
    );

    @Query(value = "{call spLeerTipoPago()}", nativeQuery = true)
    List<TipoPago> listProcedureTipoPago();

    @Query(value = "{call spLeerTipoPagoPorId(:idTipoPago)}", nativeQuery = true)
    TipoPago listProcedureTipoPagoById(@Param("idTipoPago") Integer idTipoPago);

    @Modifying
    @Query(value = "{call spEliminarTipoPago(:idTipoPago)}", nativeQuery = true)
    void deleteProcedureTipoPago(@Param("idTipoPago") Integer idTipoPago);

    @Query(value = "{call spActivarTipoPago(:idTipoPago)}", nativeQuery = true)
    void activarTipoPago(@Param("idTipoPago") Integer idTipoPago);

}

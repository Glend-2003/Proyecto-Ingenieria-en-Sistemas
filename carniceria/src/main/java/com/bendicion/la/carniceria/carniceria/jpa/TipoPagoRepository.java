package com.bendicion.la.carniceria.carniceria.jpa;
import com.bendicion.la.carniceria.carniceria.domain.TipoPago;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Jamel Sandí
 */

@Repository
public interface TipoPagoRepository extends JpaRepository <TipoPago, Integer>{
    
    // SP Add (Agregar Tipo de Pago)
    @Query(value = "{call spAgregarTipoPago(:descripcionTipoPago, :estadoTipoPago)}", nativeQuery = true)
    void saveProcedureTipoPago(
        @Param("descripcionTipoPago") String descripcionTipoPago, 
        @Param("estadoTipoPago") Boolean estadoTipoPago
    );

    // SP Update (Actualizar Tipo de Pago)
    @Modifying
    @Query(value = "{call spActualizarTipoPago(:idTipoPago, :descripcionTipoPago, :estadoTipoPago)}", nativeQuery = true)
    void updateProcedureTipoPago(
        @Param("idTipoPago") Integer idTipoPago, 
        @Param("descripcionTipoPago") String descripcionTipoPago, 
        @Param("estadoTipoPago") Boolean estadoTipoPago
    );

    // SP Read 
    @Query(value = "{call spLeerTipoPago()}", nativeQuery = true)
    List<TipoPago> listProcedureTipoPago();

    // SP Read by ID 
    @Query(value = "{call spLeerTipoPagoPorId(:idTipoPago)}", nativeQuery = true)
    TipoPago listProcedureTipoPagoById(@Param("idTipoPago") Integer idTipoPago);

    // SP Delete (Desactivar Tipo de Pago)
    @Modifying
    @Query(value = "{call spEliminarTipoPago(:idTipoPago)}", nativeQuery = true)
    void deleteProcedureTipoPago(@Param("idTipoPago") Integer idTipoPago);
    
    @Query(value = "{call spActivarTipoPago(:idTipoPago)}", nativeQuery = true)
    void activarTipoPago(@Param("idTipoPago") Integer idTipoPago);
    
}

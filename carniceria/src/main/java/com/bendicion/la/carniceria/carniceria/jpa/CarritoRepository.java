package com.bendicion.la.carniceria.carniceria.jpa;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.bendicion.la.carniceria.carniceria.domain.Carrito;

@Repository
public interface CarritoRepository extends JpaRepository<Carrito, Integer>{
    @Modifying
    @Query(value = "{call spAgregarCarrito(:idUsuario, :montoTotalCarrito, :estadoCarrito, :cantidadCarrito)}", nativeQuery = true)
    void saveProcedureCarrito(
        @Param("idUsuario") Integer idUsuario, 
        @Param("montoTotalCarrito") BigDecimal montoTotalCarrito,
        @Param("estadoCarrito") boolean estadoCarrito,
        @Param("cantidadCarrito") Integer cantidadCarrito
    );

    @Modifying
    @Query(value = "{call spActualizarCarrito(:idCarrito, :idUsuario, :montoTotalCarrito, :estadoCarrito, :cantidadCarrito)}", nativeQuery = true)
    void updateProcedureCarrito(
        @Param("idCarrito") Integer idCarrito,
        @Param("idUsuario") Integer idUsuario, 
        @Param("montoTotalCarrito") BigDecimal montoTotalCarrito,
        @Param("estadoCarrito") boolean estadoCarrito,
        @Param("cantidadCarrito") Integer cantidadCarrito
    );

    @Query(value = "{call spEliminarCarrito(:idCarrito)}", nativeQuery = true)
    void deleteProcedureCarrito(@Param("idCarrito") Integer idCarrito);

    @Query(value = "{call spLeerCarrito(:estadoCarrito)}", nativeQuery = true)
    List<Carrito> listProcedureCarrito( @Param("estadoCarrito") boolean estadoCarrito);
}

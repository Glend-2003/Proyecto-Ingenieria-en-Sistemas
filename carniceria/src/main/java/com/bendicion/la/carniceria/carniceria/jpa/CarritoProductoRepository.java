package com.bendicion.la.carniceria.carniceria.jpa;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.bendicion.la.carniceria.carniceria.domain.CarritoProducto;

@Repository
public interface CarritoProductoRepository extends JpaRepository<CarritoProducto, Integer> {

    @Modifying
    @Query(value = "{call spAgregarCarritoProducto(:idCarrito, :idProducto, :cantidadProducto)}", nativeQuery = true)
    void saveProcedureCarritoProducto(
            @Param("idCarrito") Integer idCarrito,
            @Param("idProducto") Integer idProducto,
            @Param("cantidadProducto") Integer cantidadProducto
    );

    @Modifying
    @Query(value = "{call spActualizarCarritoProducto(:idCarritoProducto, :idCarrito, :idProducto, :cantidadProducto)}", nativeQuery = true)
    void updateProcedureCarritoProducto(
            @Param("idCarritoProducto") Integer idCarritoProducto,
            @Param("idCarrito") Integer idCarrito,
            @Param("idProducto") Integer idProducto,
            @Param("cantidadProducto") Integer cantidadProducto
    );

    @Modifying
    @Query(value = "{call spActualizarStock(:idProducto, :cantidadProducto)}", nativeQuery = true)
    void updateStock(
            @Param("idProducto") Integer idProducto,
            @Param("cantidadProducto") Integer cantidadProducto
    );

    @Query(value = "{call spEliminarCarritoProducto(:idCarritoProducto)}", nativeQuery = true)
    void deleteProcedureCarritoProducto(@Param("idCarritoProducto") Integer idCarritoProducto);

    @Query(value = "{call spLeerCarritoProductoPorCarrito(:idCarrito)}", nativeQuery = true)
    List<CarritoProducto> findByCarrito(@Param("idCarrito") Integer idCarrito);
}

package com.bendicion.la.carniceria.carniceria.jpa;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.bendicion.la.carniceria.carniceria.domain.Producto;

@Repository
public interface ProductoRepository extends JpaRepository<Producto, Integer> {

    @Modifying
    @Query(value = "{call spAgregarProducto(:nombreProducto, :imgProducto, :montoPrecioProducto, :descripcionProducto, :cantidadProducto, :tipoPesoProducto, :codigoProducto, :stockProducto, :idCategoria, :estadoProducto)}", nativeQuery = true)
    void saveProcedureProducto(
            @Param("nombreProducto") String nombreProducto,
            @Param("imgProducto") String imgProducto,
            @Param("montoPrecioProducto") BigDecimal montoPrecioProducto,
            @Param("descripcionProducto") String descripcionProducto,
            @Param("cantidadProducto") Double cantidadProducto,
            @Param("tipoPesoProducto") String tipoPesoProducto,
            @Param("codigoProducto") String codigoProducto,
            @Param("stockProducto") Integer stockProducto,
            @Param("idCategoria") Integer idCategoria,
            @Param("estadoProducto") boolean estadoProducto
    );

    @Modifying
    @Query(value = "{call spActualizarProducto(:idProducto, :nombreProducto, :imgProducto, :montoPrecioProducto, :descripcionProducto, :cantidadProducto, :tipoPesoProducto, :codigoProducto, :stockProducto, :idCategoria, :estadoProducto)}", nativeQuery = true)
    void updateProcedureProducto(
            @Param("idProducto") Integer idProducto,
            @Param("nombreProducto") String nombreProducto,
            @Param("imgProducto") String imgProducto,
            @Param("montoPrecioProducto") BigDecimal montoPrecioProducto,
            @Param("descripcionProducto") String descripcionProducto,
            @Param("cantidadProducto") Double cantidadProducto,
            @Param("tipoPesoProducto") String tipoPesoProducto,
            @Param("codigoProducto") String codigoProducto,
            @Param("stockProducto") Integer stockProducto,
            @Param("idCategoria") Integer idCategoria,
            @Param("estadoProducto") boolean estadoProducto
    );

    @Query(value = "{call spLeerProducto(:estadoProducto)}", nativeQuery = true)
    List<Producto> listProcedureProducto(@Param("estadoProducto") boolean estadoProducto);

    @Query(value = "{call spEliminarProducto(:idProducto)}", nativeQuery = true)
    void deleteProcedureProducto(@Param("idProducto") Integer idProducto);

    @Query(value = "{call spBuscarProductoPorId(:idProducto)}", nativeQuery = true)
    Producto buscarProducto(@Param("idProducto") int id);

    @Query(value = "{call spActivarProducto(:idProducto)}", nativeQuery = true)
    void activarProducto(@Param("idProducto") Integer idProducto);

}

package com.bendicion.la.carniceria.carniceria.jpa;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.bendicion.la.carniceria.carniceria.domain.Carrito;
import com.bendicion.la.carniceria.carniceria.domain.Usuario;

@Repository
public interface CarritoRepository extends JpaRepository<Carrito, Integer> {

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
    List<Carrito> listProcedureCarrito(@Param("estadoCarrito") boolean estadoCarrito);

    @Query("SELECT c FROM Carrito c WHERE c.usuario.idUsuario = :idUsuario ORDER BY c.idCarrito DESC")
    List<Carrito> findByUsuarioOrderByIdDesc(@Param("idUsuario") Integer idUsuario);

    default Carrito findTopByUsuarioOrderByIdCarritoDesc(Usuario usuario) {
        List<Carrito> carritos = findByUsuarioOrderByIdDesc(usuario.getIdUsuario());
        return carritos.isEmpty() ? null : carritos.get(0);
    }

    @Query(value = "SELECT LAST_INSERT_ID()", nativeQuery = true)
    int getLastInsertId();

    @Query("SELECT c FROM Carrito c WHERE c.idCarrito = :id AND c.usuario.idUsuario = :usuarioId")
    Optional<Carrito> findByIdAndUsuario(@Param("id") int idCarrito, @Param("usuarioId") int usuarioId);

    @Query(value = "{call sp_ObtenerCarritosUsuario(:usuarioId)}", nativeQuery = true)
    List<Object[]> obtenerCarritosUsuario(@Param("usuarioId") Integer usuarioId);

    @Query(value = "SELECT c.idCarrito, c.idUsuario, c.montoTotalCarrito, c.estadoCarrito, c.cantidadCarrito "
            + "FROM tbcarrito c WHERE c.idUsuario = :usuarioId", nativeQuery = true)
    List<Object[]> findCarritosByUsuarioId(@Param("usuarioId") Integer usuarioId);

    @Query(value = "{call sp_ObtenerCarritoPorId(:idCarrito)}", nativeQuery = true)
    List<Object[]> obtenerCarritoPorId(@Param("idCarrito") Integer idCarrito);

    @Query(value = "SELECT cp.idCarritoProducto, cp.idCarrito, cp.idProducto, cp.cantidadProducto, "
            + "c.idUsuario, c.montoTotalCarrito, c.estadoCarrito, c.cantidadCarrito, "
            + "p.nombreProducto, p.imgProducto, p.montoPrecioProducto, p.descripcionProducto, "
            + "p.tipoPesoProducto, p.codigoProducto, p.stockProducto, p.idCategoria, p.estadoProducto "
            + "FROM tbcarritoproducto cp "
            + "JOIN tbcarrito c ON cp.idCarrito = c.idCarrito "
            + "JOIN tbproducto p ON cp.idProducto = p.idProducto "
            + "WHERE c.idUsuario = :usuarioId", nativeQuery = true)
    List<Object[]> findProductosInCarritosByUsuarioId(@Param("usuarioId") Integer usuarioId);

}

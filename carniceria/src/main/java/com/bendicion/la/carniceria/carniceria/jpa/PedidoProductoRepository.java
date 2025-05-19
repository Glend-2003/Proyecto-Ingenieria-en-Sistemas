package com.bendicion.la.carniceria.carniceria.jpa;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.bendicion.la.carniceria.carniceria.domain.PedidoProducto;

@Repository
public interface PedidoProductoRepository extends JpaRepository<PedidoProducto, Integer> {

    @Query(value = "{call spLeerPedidoProducto()}", nativeQuery = true)
    List<PedidoProducto> leerPedidoProducto();

}

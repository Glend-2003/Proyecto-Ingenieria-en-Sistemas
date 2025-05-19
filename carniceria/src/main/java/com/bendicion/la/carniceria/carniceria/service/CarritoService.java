package com.bendicion.la.carniceria.carniceria.service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.bendicion.la.carniceria.carniceria.domain.Carrito;
import com.bendicion.la.carniceria.carniceria.domain.Usuario;
import com.bendicion.la.carniceria.carniceria.jpa.CarritoRepository;
import com.bendicion.la.carniceria.carniceria.jpa.UsuarioRepository;

import jakarta.transaction.Transactional;

@Service
@Primary
public class CarritoService implements ICarritoService {

    @Autowired
    private CarritoRepository carritoRepo;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Override
    @Transactional
    public Carrito addCarrito(Carrito carrito) {

        if (carrito.getUsuario() == null) {
            throw new IllegalArgumentException("El carrito debe tener un usuario asociado");
        }

        Usuario usuario = usuarioRepository.findById(carrito.getUsuario().getIdUsuario())
                .orElseThrow(() -> new IllegalArgumentException("Usuario no encontrado"));

        if (carrito.getMontoTotalCarrito() == null || carrito.getMontoTotalCarrito().compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("El monto total debe ser mayor a cero");
        }

        if (carrito.getCantidadCarrito() <= 0) {
            throw new IllegalArgumentException("La cantidad debe ser mayor a cero");
        }

        carrito.setUsuario(usuario);

        try {

            carritoRepo.saveProcedureCarrito(
                    usuario.getIdUsuario(),
                    carrito.getMontoTotalCarrito(),
                    carrito.isEstadoCarrito(),
                    carrito.getCantidadCarrito()
            );

            int idCarrito = carritoRepo.getLastInsertId();

            return carritoRepo.findByIdAndUsuario(idCarrito, usuario.getIdUsuario())
                    .orElseThrow(() -> new RuntimeException("No se pudo recuperar el carrito después de crearlo"));

        } catch (Exception e) {
            throw new RuntimeException("Error al guardar el carrito: " + e.getMessage(), e);
        }
    }

    @Transactional
    public Carrito updateCarrito(Carrito carrito) {
        if (carrito.getUsuario() == null) {
            throw new IllegalArgumentException("El carrito debe estar asociado a un usuario");
        }
        if (carrito.getCantidadCarrito() <= 0) {
            throw new IllegalArgumentException("La cantidad debe ser mayor a cero");
        }
        if (carrito.getMontoTotalCarrito() == null) {
            throw new IllegalArgumentException("El monto total del carrito no puede estar vacío");
        }

        carritoRepo.updateProcedureCarrito(
                carrito.getIdCarrito(),
                carrito.getUsuario() != null ? carrito.getUsuario().getIdUsuario() : null,
                carrito.getMontoTotalCarrito(),
                carrito.isEstadoCarrito(),
                carrito.getCantidadCarrito()
        );

        return carrito;
    }

    @Override
    @Transactional
    public List<Carrito> getCarrito(boolean estadoCarrito) {
        return carritoRepo.listProcedureCarrito(estadoCarrito);
    }

    @Override
    public boolean deleteCarrito(int idCarrito) {
        try {
            Carrito carrito = carritoRepo.findById(idCarrito).orElse(null);
            if (carrito == null) {
                System.out.println("Carrito con ID " + idCarrito + " no encontrado.");
                return false;
            }
            carritoRepo.deleteProcedureCarrito(idCarrito);
            return true;
        } catch (Exception e) {
            System.out.println("Error al eliminar el carrito con ID: " + idCarrito);
            e.printStackTrace();
            return false;
        }
    }

    @Override
    @Transactional
    public Map<String, List<Object[]>> obtenerCarritosUsuario(Integer usuarioId) {
        Map<String, List<Object[]>> resultado = new HashMap<>();

        List<Object[]> carritos = carritoRepo.findCarritosByUsuarioId(usuarioId);
        resultado.put("carritos", carritos);

        List<Object[]> productos = carritoRepo.findProductosInCarritosByUsuarioId(usuarioId);
        resultado.put("productos", productos);

        return resultado;
    }

    @Override
    public Carrito obtenerCarritoPorId(Integer idCarrito) {
        List<Object[]> resultado = carritoRepo.obtenerCarritoPorId(idCarrito);

        if (resultado == null || resultado.isEmpty()) {
            return null;
        }

        Object[] carritoData = resultado.get(0);

        Carrito carrito = new Carrito();
        carrito.setIdCarrito((Integer) carritoData[0]);

        // Crear y asignar el usuario
        Usuario usuario = new Usuario();
        usuario.setIdUsuario((Integer) carritoData[1]);
        carrito.setUsuario(usuario);

        carrito.setMontoTotalCarrito((BigDecimal) carritoData[2]);
        carrito.setEstadoCarrito((Boolean) carritoData[3]);
        carrito.setCantidadCarrito((Integer) carritoData[4]);

        return carrito;
    }

}

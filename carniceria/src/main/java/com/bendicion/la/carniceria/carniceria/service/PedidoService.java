package com.bendicion.la.carniceria.carniceria.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.bendicion.la.carniceria.carniceria.domain.Carrito;
import com.bendicion.la.carniceria.carniceria.domain.Pedido;
import com.bendicion.la.carniceria.carniceria.domain.Usuario;
import com.bendicion.la.carniceria.carniceria.jpa.GraficosPedidoRepository;
import com.bendicion.la.carniceria.carniceria.jpa.PedidoRepository;
import com.bendicion.la.carniceria.carniceria.jpa.UsuarioRepository;

import jakarta.transaction.Transactional;

@Service
@Primary
public class PedidoService implements IPedidoService {

    @Autowired
    private PedidoRepository pedidoRepo;

    @Autowired
    private CarritoService carritoRepo;

    @Autowired
    private GraficosPedidoRepository graficosRepo;

    @Autowired
    private UsuarioRepository usuarioRepo;

    @Autowired
    private CorreoService correoService;

    @Transactional
    @Override
    public Pedido addPedido(Pedido pedido) {
        Integer idCarrito = pedido.getCarrito().getIdCarrito();
        Integer idTipoPago = pedido.getTipoPago().getIdTipoPago();

        Carrito carritos = carritoRepo.obtenerCarritoPorId(idCarrito);
        if (carritos == null) {
            throw new RuntimeException("El carrito con ID " + idCarrito + " no existe");
        }

        try {

            LocalDateTime localDateTime = pedido.getFechaPedido();

            Date fechaPedido = java.sql.Timestamp.valueOf(localDateTime);

            System.out.println("Fecha exacta seleccionada por usuario: " + localDateTime);
            System.out.println("Fecha convertida a Timestamp: " + fechaPedido);

            pedidoRepo.saveProcedurePedido(
                    pedido.getMontoTotalPedido(),
                    fechaPedido,
                    pedido.isEstadoPedido(),
                    pedido.getEstadoEntregaPedido(),
                    idCarrito,
                    idTipoPago
            );
        } catch (Exception e) {
            System.err.println("Error al procesar la fecha: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Error al guardar el pedido: " + e.getMessage());
        }

        return pedido;
    }

    @Transactional
    @Override
    public Pedido updatePedido(Pedido pedido) {
        try {
            Date fecha = java.sql.Timestamp.valueOf(pedido.getFechaPedido());
            Integer estadoInt = pedido.isEstadoPedido() ? 1 : 0;

            pedidoRepo.updateProcedurePedido(
                    pedido.getIdPedido(),
                    pedido.getMontoTotalPedido(),
                    fecha,
                    estadoInt,
                    pedido.getEstadoEntregaPedido(),
                    pedido.getCarrito().getIdCarrito(),
                    pedido.getTipoPago().getIdTipoPago()
            );

            return pedido;
        } catch (Exception e) {
            throw new RuntimeException("Error al actualizar pedido: " + e.getMessage(), e);
        }
    }

    @Override
    public List<Map<String, Object>> getPedido() {
        try {
            return pedidoRepo.listaPedido();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    @Override
    public List<Map<String, Object>> getPedidoByUsuario(int id) {
        try {
            return pedidoRepo.getPedidoByUsuario(id);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    @Override
    public List<Map<String, Object>> getPedidoEntregado() {

        List<Object[]> resultados = pedidoRepo.listaPedidoEntregado();

        return resultados.stream().map(fila -> {
            Map<String, Object> pedidoMap = new HashMap<>();

            pedidoMap.put("idPedido", fila[0]);
            pedidoMap.put("montoTotalPedido", fila[1]);
            pedidoMap.put("fechaPedido", fila[2]);
            pedidoMap.put("estadoPedido", fila[3]);
            pedidoMap.put("estadoPedidoTexto", fila[4]);
            pedidoMap.put("estadoEntregaPedido", fila[5]);
            pedidoMap.put("idCarrito", fila[6]);
            pedidoMap.put("idTipoPago", fila[7]);

            pedidoMap.put("descripcionTipoPago", fila[8]);
            pedidoMap.put("estadoTipoPago", fila[9]);

            pedidoMap.put("idUsuario", fila[10]);
            pedidoMap.put("montoTotalCarrito", fila[11]);
            pedidoMap.put("estadoCarrito", fila[12]);
            pedidoMap.put("cantidadCarrito", fila[13]);

            pedidoMap.put("nombreUsuario", fila[14]);
            pedidoMap.put("primerApellido", fila[15]);
            pedidoMap.put("segundoApellido", fila[16]);
            pedidoMap.put("nombreCompletoUsuario", fila[17]);
            pedidoMap.put("cedulaUsuario", fila[18]);
            pedidoMap.put("correoUsuario", fila[19]);
            pedidoMap.put("telefonoUsuario", fila[20]);
            pedidoMap.put("fechaNacimiento", fila[21]);

            pedidoMap.put("cantidadProductosDistintos", fila[22]);
            pedidoMap.put("cantidadTotalItems", fila[23]);

            pedidoMap.put("idCarritoProducto", fila[24]);
            pedidoMap.put("cantidadProducto", fila[25]);

            pedidoMap.put("idProducto", fila[26]);
            pedidoMap.put("nombreProducto", fila[27]);
            pedidoMap.put("imgProducto", fila[28]);
            pedidoMap.put("montoPrecioProducto", fila[29]);
            pedidoMap.put("descripcionProducto", fila[30]);
            pedidoMap.put("stockProducto", fila[31]);
            pedidoMap.put("tipoPesoProducto", fila[32]);
            pedidoMap.put("codigoProducto", fila[33]);
            pedidoMap.put("idCategoria", fila[34]);
            pedidoMap.put("estadoProducto", fila[35]);

            return pedidoMap;
        }).toList();
    }

    @Override
    public List<Map<String, Object>> filtrarPedidos(
            int idUsuario,
            String estadoEntrega,
            Date fechaInicio,
            Date fechaFin,
            Integer estadoPedido
    ) {
        return pedidoRepo.filtrarPedidos(idUsuario, estadoEntrega, fechaInicio, fechaFin, estadoPedido);
    }

    @Transactional
    @Override
    public boolean deletePedido(int id) {
        pedidoRepo.deleteProcedurePedido(id);
        return true;
    }

    @Transactional
    @Override
    public boolean updateStatePedido(int id) {
        pedidoRepo.deleteStateProcedurePedido(id);
        return true;
    }

    @Override
    @Transactional
    public void updateStateEntregaPedido(int idPedido, String nuevoEstado) {
        try {
            pedidoRepo.updateStateEntrega(idPedido, nuevoEstado);
        } catch (Exception e) {
            throw new RuntimeException("Error al actualizar estado de entrega: " + e.getMessage());
        }
    }

    @Override
    @Transactional
    public Map<String, Object> getTotalVentas() {
        try {
            return graficosRepo.obtenerVentasPorPeriodo("total");
        } catch (Exception e) {
            throw new RuntimeException("Error al obtener el reporte de ventas: " + e.getMessage());
        }
    }

    @Override
    @Transactional
    public Map<String, Map<String, Object>> getReporteVentasCompleto() {
        try {
            Map<String, Map<String, Object>> reporte = new HashMap<>();

            reporte.put("diario", graficosRepo.obtenerVentasPorPeriodo("dia"));
            reporte.put("semanal", graficosRepo.obtenerVentasPorPeriodo("semana"));
            reporte.put("mensual", graficosRepo.obtenerVentasPorPeriodo("mes"));
            reporte.put("anual", graficosRepo.obtenerVentasPorPeriodo("anio"));
            reporte.put("total", graficosRepo.obtenerVentasPorPeriodo("total"));

            return reporte;
        } catch (Exception e) {
            throw new RuntimeException("Error al obtener el reporte completo de ventas: " + e.getMessage());
        }
    }

    @Override
    @Transactional
    public void sendMail(String correoUsuario, String estado) {
        try {

            Usuario usuario = usuarioRepo.searchUsuario(correoUsuario);

            if (usuario == null) {
                throw new RuntimeException("El correo no está registrado");
            }

            String asunto = "Estado el pedido";
            String mensajeHTML = mensajePredeterminado(usuario.getNombreUsuario(), estado);

            correoService.enviarMensaje(correoUsuario, asunto, mensajeHTML);

            System.out.println("Correoenviado a: " + correoUsuario);
        } catch (Exception e) {
            throw new RuntimeException("Error al enviar el correo: " + e.getMessage());
        }
    }

    @Transactional
    public String mensajePredeterminado(String nombreUsuario, String estadoPedido) {

        LocalDate fecha = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        String fechaFormateada = fecha.format(formatter);

        return "<!DOCTYPE html>"
                + "<html lang='es'>"
                + "<head>"
                + "    <meta charset='UTF-8'>"
                + "    <meta name='viewport' content='width=device-width, initial-scale=1.0'>"
                + "    <title>Actualización de Estado de Pedido</title>"
                + "    <style>"
                + "        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }"
                + "        .container { max-width: 600px; margin: 20px auto; background-color: #ffffff; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); border: 1px solid #dddddd; }"
                + "        h1 { color: #333333; }"
                + "        p { color: #555555; line-height: 1.6; }"
                + "        .status { font-size: 20px; font-weight: bold; color: #28a745; margin: 20px 0; }"
                + "        .footer { margin-top: 20px; font-size: 12px; color: #888888; }"
                + "    </style>"
                + "</head>"
                + "<body>"
                + "    <div class='container'>"
                + "        <h1>Estado de tu Pedido</h1>"
                + "        <p>Hola <strong>" + nombreUsuario + "</strong>,</p>"
                + "        <p>Queremos informarte que el estado de tu pedido ha sido actualizado.</p>"
                + "        <div class='status'>Nuevo estado: " + estadoPedido + "</div>"
                + "        <p>Fecha de actualización: <strong>" + fechaFormateada + "</strong></p>"
                + "        <p>Gracias por confiar en Carnicería La Bendición. Si tenés alguna duda, no dudes en contactarnos.</p>"
                + "        <div class='footer'>"
                + "            <p>Atentamente,</p>"
                + "            <p>El equipo de Carnicería La Bendición</p>"
                + "        </div>"
                + "    </div>"
                + "</body>"
                + "</html>";
    }
}

package com.bendicion.la.carniceria.carniceria.controller;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.bendicion.la.carniceria.carniceria.domain.Categoria;
import com.bendicion.la.carniceria.carniceria.domain.Producto;
import com.bendicion.la.carniceria.carniceria.service.ProductoService;

/**
 * Controlador de productos
 */
@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/producto")
public class ProductoController {

    // IMPORTANTE: MANTENER LA RUTA ORIGINAL para no romper la compatibilidad
    private static final String IMAGE_DIRECTORY = "src/main/resources/static/images";
    
    @Autowired
    private ProductoService productoService;
    
    @GetMapping("/{id}")
    public ResponseEntity<Producto> ObtenerPorId(@PathVariable int id) {
        return ResponseEntity.ok(productoService.ObtenerPorId(id));
    }
    
    // Obtener lista de productos
    @GetMapping("/")
    public ResponseEntity<List<Producto>> listProductos(boolean estadoProducto) {
        List<Producto> productos = productoService.getProducto(estadoProducto);
        return ResponseEntity.ok(productos);
    }

    // Agregar producto sin imagen
    @PostMapping("/agregarProducto")
    public ResponseEntity<?> addProducto(@RequestBody Producto producto) {
        try {
            Producto nuevoProducto = productoService.addProducto(producto);
            Map<String, Object> response = new HashMap<>();
            response.put("message", "Producto agregado con éxito con ID: " + nuevoProducto.getIdProducto());
            response.put("id", nuevoProducto.getIdProducto());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error al agregar el producto: " + e.getMessage()));
        }
    }

    // Agregar producto con imagen (carga de archivo)
    @PostMapping(value = "/agregarConImagen", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> addProductoWithImage(
            @RequestParam("nombreProducto") String nombreProducto,
            @RequestParam("montoPrecioProducto") double montoPrecioProducto,
            @RequestParam("descripcionProducto") String descripcionProducto,
            @RequestParam("cantidadProducto") double cantidadProducto,
            @RequestParam("tipoPesoProducto") String tipoPesoProducto,
            @RequestParam("codigoProducto") String codigoProducto,
            @RequestParam("stockProducto") int stockProducto,
            @RequestParam("idCategoria") int idCategoria,
            @RequestParam("estadoProducto") int estadoProducto,
            @RequestParam("file") MultipartFile file) { 
        
        if (file.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("No se seleccionó ningún archivo");
        }

        try {
            // Verificar o crear el directorio de imágenes
            File directory = new File(IMAGE_DIRECTORY);
            
            // Logs para depuración
            System.out.println("Directorio de imágenes: " + directory.getAbsolutePath());
            System.out.println("Directorio existe: " + directory.exists());
            System.out.println("Directorio es directorio: " + directory.isDirectory());
            System.out.println("Directorio tiene permisos de escritura: " + directory.canWrite());
            
            if (!directory.exists()) {
                boolean created = directory.mkdirs();
                System.out.println("Directorio creado: " + created);
                
                if (!created) {
                    throw new IOException("No se pudo crear el directorio de imágenes: " + directory.getAbsolutePath());
                }
            }

            // Log info sobre el archivo recibido
            System.out.println("Archivo recibido: " + file.getOriginalFilename());
            System.out.println("Tipo de archivo: " + file.getContentType());
            System.out.println("Tamaño de archivo: " + file.getSize() + " bytes");

            // Generar un nombre único para la imagen (con manejo seguro de extensión)
            String originalFilename = file.getOriginalFilename();
            String fileExtension = ".jpg"; // Extensión por defecto
            
            // Extraer extensión solo si existe un punto en el nombre
            if (originalFilename != null && originalFilename.contains(".")) {
                fileExtension = originalFilename.substring(originalFilename.lastIndexOf('.'));
            }
            
            // Usar .jpg para JPEG y .png para PNG, otros formatos convertir a .jpg
            if (!fileExtension.equalsIgnoreCase(".jpg") && 
                !fileExtension.equalsIgnoreCase(".jpeg") && 
                !fileExtension.equalsIgnoreCase(".png")) {
                fileExtension = ".jpg";
            }
            
            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

            // Guardar el archivo de imagen
            Path filePath = Paths.get(directory.getAbsolutePath(), uniqueFileName);
            System.out.println("Guardando imagen en: " + filePath.toString());
            
            Files.copy(file.getInputStream(), filePath);
            System.out.println("Imagen guardada correctamente");

            // Crear y configurar el objeto Producto
            Producto nuevoProducto = new Producto();
            nuevoProducto.setNombreProducto(nombreProducto);
            nuevoProducto.setMontoPrecioProducto(BigDecimal.valueOf(montoPrecioProducto));
            nuevoProducto.setDescripcionProducto(descripcionProducto);
            nuevoProducto.setCantidadProducto(cantidadProducto);
            nuevoProducto.setTipoPesoProducto(tipoPesoProducto);
            nuevoProducto.setCodigoProducto(codigoProducto);
            nuevoProducto.setStockProducto(stockProducto);

            // Crear y asociar la categoría al producto
            Categoria categoria = new Categoria();
            categoria.setIdCategoria(idCategoria);
            nuevoProducto.setCategoria(categoria);

            nuevoProducto.setEstadoProducto(estadoProducto == 1);
            nuevoProducto.setImgProducto(uniqueFileName);

            // Guardar el producto
            Producto savedProducto = productoService.addProducto(nuevoProducto);
            System.out.println("Producto guardado con ID: " + savedProducto.getIdProducto());

            // Respuesta de éxito
            Map<String, Object> response = new HashMap<>();
            response.put("message", "Producto agregado con éxito con ID: " + savedProducto.getIdProducto());
            response.put("id", savedProducto.getIdProducto());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            // Log detallado de la excepción
            e.printStackTrace();
            System.err.println("Error completo: " + e.getMessage());
            if (e.getCause() != null) {
                System.err.println("Causa: " + e.getCause().getMessage());
            }
            
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error detallado al guardar el producto o la imagen: " + e.getMessage()));
        }
    }

    @GetMapping("/images/{imageName}")
    public ResponseEntity<byte[]> getImage(@PathVariable String imageName) {
        try {
            Path filePath = Paths.get(IMAGE_DIRECTORY, imageName);
            System.out.println("Buscando imagen en: " + filePath.toString());
            
            if (!Files.exists(filePath)) {
                System.err.println("Error: La imagen no existe en la ruta: " + filePath.toString());
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
            }
            
            byte[] image = Files.readAllBytes(filePath);
            
            // Determinar el tipo MIME basado en la extensión del archivo
            String contentType = Files.probeContentType(filePath);
            if (contentType == null) {
                // Si no se puede determinar, asumir image/jpeg para .jpg/.jpeg
                if (imageName.toLowerCase().endsWith(".jpg") || imageName.toLowerCase().endsWith(".jpeg")) {
                    contentType = "image/jpeg";
                } else if (imageName.toLowerCase().endsWith(".png")) {
                    contentType = "image/png";
                } else {
                    contentType = "application/octet-stream";
                }
            }
    
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(contentType))
                    .body(image);
        } catch (IOException e) {
            System.err.println("Error al encontrar la imagen: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    // Actualizar producto con imagen
    @PutMapping(value = "/actualizar", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> updateProducto(
            @RequestParam("idProducto") int idProducto,
            @RequestParam("nombreProducto") String nombreProducto,
            @RequestParam(value = "file", required = false) MultipartFile file,
            @RequestParam("montoPrecioProducto") double montoPrecioProducto,
            @RequestParam("descripcionProducto") String descripcionProducto,
            @RequestParam("cantidadProducto") double cantidadProducto,
            @RequestParam("tipoPesoProducto") String tipoPesoProducto,
            @RequestParam("codigoProducto") String codigoProducto,
            @RequestParam("stockProducto") int stockProducto,
            @RequestParam("idCategoria") int idCategoria,
            @RequestParam("estadoProducto") int estadoProducto) {
   
        try {
            // Obtener el producto actual para verificar si ya tiene una imagen
            Producto productoExistente = productoService.ObtenerPorId(idProducto);
            
            // Crear y configurar el objeto Producto
            Producto productoActualizar = new Producto();
            productoActualizar.setIdProducto(idProducto);
            productoActualizar.setNombreProducto(nombreProducto);
            productoActualizar.setMontoPrecioProducto(BigDecimal.valueOf(montoPrecioProducto));
            productoActualizar.setDescripcionProducto(descripcionProducto);
            productoActualizar.setCantidadProducto(cantidadProducto);
            productoActualizar.setTipoPesoProducto(tipoPesoProducto);
            productoActualizar.setCodigoProducto(codigoProducto);
            productoActualizar.setStockProducto(stockProducto);
   
            // Actualizar la categoría del producto
            Categoria categoria = new Categoria();
            categoria.setIdCategoria(idCategoria);
            productoActualizar.setCategoria(categoria);
   
            productoActualizar.setEstadoProducto(estadoProducto == 1);
            
            // Si el producto ya tenía una imagen, mantenerla a menos que se proporcione una nueva
            if (productoExistente != null && productoExistente.getImgProducto() != null) {
                productoActualizar.setImgProducto(productoExistente.getImgProducto());
            }
   
            if (file != null && !file.isEmpty()) {
                // Verificar o crear el directorio de imágenes
                File directory = new File(IMAGE_DIRECTORY);
                
                System.out.println("Directorio de imágenes: " + directory.getAbsolutePath());
                System.out.println("Directorio existe: " + directory.exists());
                
                if (!directory.exists()) {
                    boolean created = directory.mkdirs();
                    System.out.println("Directorio creado: " + created);
                    
                    if (!created) {
                        throw new IOException("No se pudo crear el directorio de imágenes: " + directory.getAbsolutePath());
                    }
                }
   
                // Eliminar la imagen anterior si existe
                if (productoExistente != null && productoExistente.getImgProducto() != null) {
                    Path oldImagePath = Paths.get(directory.getAbsolutePath(), productoExistente.getImgProducto());
                    System.out.println("Intentando eliminar imagen antigua: " + oldImagePath.toString());
                    
                    if (Files.exists(oldImagePath)) {
                        Files.deleteIfExists(oldImagePath);
                        System.out.println("Imagen antigua eliminada");
                    } else {
                        System.out.println("No se encontró la imagen antigua para eliminar");
                    }
                }
   
                // Generar un nombre único para la nueva imagen - con manejo seguro de extensión
                String originalFilename = file.getOriginalFilename();
                String fileExtension = ".jpg";  // Extensión por defecto
                
                // Extraer extensión solo si existe un punto en el nombre
                if (originalFilename != null && originalFilename.contains(".")) {
                    fileExtension = originalFilename.substring(originalFilename.lastIndexOf('.'));
                }
                
                // Usar .jpg para JPEG y .png para PNG, otros formatos convertir a .jpg
                if (!fileExtension.equalsIgnoreCase(".jpg") && 
                    !fileExtension.equalsIgnoreCase(".jpeg") && 
                    !fileExtension.equalsIgnoreCase(".png")) {
                    fileExtension = ".jpg";
                }
                
                String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
   
                // Guardar el archivo de imagen
                Path filePath = Paths.get(directory.getAbsolutePath(), uniqueFileName);
                System.out.println("Guardando nueva imagen en: " + filePath.toString());
                
                Files.copy(file.getInputStream(), filePath);
                System.out.println("Nueva imagen guardada correctamente");
   
                // Asignar el nuevo nombre de la imagen al producto
                productoActualizar.setImgProducto(uniqueFileName);
            }
   
            // Guardar los cambios del producto
            Producto productoActualizado = productoService.updateProducto(productoActualizar);
            System.out.println("Producto actualizado con ID: " + productoActualizado.getIdProducto());
   
            // Respuesta de éxito
            Map<String, Object> response = new HashMap<>();
            response.put("message", "Producto actualizado con éxito con ID: " + productoActualizado.getIdProducto());
            response.put("id", productoActualizado.getIdProducto());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error completo en actualización: " + e.getMessage());
            if (e.getCause() != null) {
                System.err.println("Causa: " + e.getCause().getMessage());
            }
            
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Collections.singletonMap("error", "Error detallado al actualizar el producto o la imagen: " + e.getMessage()));
        }
    }

    // Eliminar producto
    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Boolean> deleteProducto(@PathVariable int id) {
        boolean eliminado = productoService.deleteProducto(id);
        if (eliminado) {
            return ResponseEntity.ok(true);
        } else {
            return ResponseEntity.ok(false);
        }
    }
    
    @PutMapping("/activar/{id}")
    public ResponseEntity<Boolean> activarProducto(@PathVariable int id) {
        boolean estado = productoService.activarProducto(id);

        if (estado) {
            System.out.println("producto activado: ID -->" + id);
            return ResponseEntity.ok(true);
        } else {
            System.out.println("No se pudo activar el producto: ID -->" + id + " no encontrado.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        }
    }
}
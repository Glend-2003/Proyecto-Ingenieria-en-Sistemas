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
 *
 * Controlador de productos
 */
@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/producto")
public class ProductoController {

    //private static final String IMAGE_DIRECTORY = "C:\\Users\\glend\\OneDrive\\Documentos\\NetBeansProjects\\Proyecto-Ingenieria-en-Sistemas\\carniceria\\images";
    private static final String IMAGE_DIRECTORY = "C:\\images";

    @Autowired
    private ProductoService productoService;

    // Obtener lista de productos
    @GetMapping("/")
    public ResponseEntity<List<Producto>> listProductos() {
        List<Producto> productos = productoService.getProducto();
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
        @RequestParam("idCategoria") int idCategoria,
        @RequestParam("estadoProducto") int estadoProducto,
        @RequestParam("file") MultipartFile file) { 
    
    if (file.isEmpty()) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("No se seleccionó ningún archivo");
    }

    try {
        // Verificar o crear el directorio de imágenes
        File directory = new File(IMAGE_DIRECTORY);
        if (!directory.exists()) {
            directory.mkdirs();
        }

        // Generar un nombre único para la imagen
        String fileExtension = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf('.'));
        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

        // Guardar el archivo de imagen
        Path filePath = Paths.get(IMAGE_DIRECTORY, uniqueFileName);
        Files.copy(file.getInputStream(), filePath);

        // Crear y configurar el objeto Producto
        Producto nuevoProducto = new Producto();
        nuevoProducto.setNombreProducto(nombreProducto);
        nuevoProducto.setMontoPrecioProducto(BigDecimal.valueOf(montoPrecioProducto));
        nuevoProducto.setDescripcionProducto(descripcionProducto);

        // Crear y asociar la categoría al producto
        Categoria categoria = new Categoria();
        categoria.setIdCategoria(idCategoria);
        nuevoProducto.setCategoria(categoria); // Relación con Categoria

        nuevoProducto.setEstadoProducto(estadoProducto == 1); // 1 para activo, 0 para inactivo
        nuevoProducto.setImgProducto(uniqueFileName); // Asigna el nombre único del archivo de imagen

        // Guardar el producto
        Producto savedProducto = productoService.addProducto(nuevoProducto);

        // Respuesta de éxito
        Map<String, Object> response = new HashMap<>();
        response.put("message", "Producto agregado con éxito con ID: " + savedProducto.getIdProducto());
        response.put("id", savedProducto.getIdProducto());
        return ResponseEntity.ok(response);
    } catch (IOException e) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(Collections.singletonMap("error", "Error al guardar el producto o la imagen: " + e.getMessage()));
    }
}


    @GetMapping("/images/{imageName}")
    public ResponseEntity<byte[]> getImage(@PathVariable String imageName) {
        try {
            Path filePath = Paths.get(IMAGE_DIRECTORY, imageName);
            System.out.println("Buscando imagen en: " + filePath.toString());
            byte[] image = Files.readAllBytes(filePath);
            
            // Determinar el tipo MIME basado en la extensión del archivo
            String contentType = Files.probeContentType(filePath);
    
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(contentType))
                    .body(image);
        } catch (IOException e) {
            System.err.println("Error al encontrar la imagen: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }
    

   // Actualizar producto con imagen
   @PutMapping(value = "/actualizar", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
   public ResponseEntity<?> updateProducto(
           @RequestParam("idProducto") int idProducto,
           @RequestParam("nombreProducto") String nombreProducto,
           @RequestParam("montoPrecioProducto") double montoPrecioProducto,
           @RequestParam("descripcionProducto") String descripcionProducto,
           @RequestParam("idCategoria") int idCategoria,
           @RequestParam("estadoProducto") int estadoProducto,
           @RequestParam(value = "file", required = false) MultipartFile file) {

       try {
           // Crear y configurar el objeto Producto
           Producto productoExistente = new Producto();
           productoExistente.setIdProducto(idProducto);
           productoExistente.setNombreProducto(nombreProducto);
           productoExistente.setMontoPrecioProducto(BigDecimal.valueOf(montoPrecioProducto));
           productoExistente.setDescripcionProducto(descripcionProducto);

           // Actualizar la categoría del producto
           Categoria categoria = new Categoria();
           categoria.setIdCategoria(idCategoria);
           productoExistente.setCategoria(categoria);

           productoExistente.setEstadoProducto(estadoProducto == 1);

           if (file != null && !file.isEmpty()) {
               // Verificar o crear el directorio de imágenes
               File directory = new File(IMAGE_DIRECTORY);
               if (!directory.exists()) {
                   directory.mkdirs();
               }

               // Eliminar la imagen anterior si existe
               if (productoExistente.getImgProducto() != null) {
                   Path oldImagePath = Paths.get(IMAGE_DIRECTORY, productoExistente.getImgProducto());
                   Files.deleteIfExists(oldImagePath);
               }

               // Generar un nombre único para la nueva imagen
               String fileExtension = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf('.'));
               String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

               // Guardar el archivo de imagen
               Path filePath = Paths.get(IMAGE_DIRECTORY, uniqueFileName);
               Files.copy(file.getInputStream(), filePath);

               // Asignar el nuevo nombre de la imagen al producto
               productoExistente.setImgProducto(uniqueFileName);
           }

           // Guardar los cambios del producto
           Producto productoActualizado = productoService.updateProducto(productoExistente);

           // Respuesta de éxito
           Map<String, Object> response = new HashMap<>();
           response.put("message", "Producto actualizado con éxito con ID: " + productoActualizado.getIdProducto());
           response.put("id", productoActualizado.getIdProducto());
           return ResponseEntity.ok(response);
       } catch (IOException e) {
           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                   .body(Collections.singletonMap("error", "Error al actualizar el producto o la imagen: " + e.getMessage()));
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


}

package com.bendicion.la.carniceria.carniceria.jpa;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.bendicion.la.carniceria.carniceria.domain.Usuario;

/**
 *
 * @author Jamel Sandí
 */

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    
    // SP Add 
    @Query(value = "{call spAgregarUsuario(:cedulaUsuario, :nombreUsuario, :primerApellido, :segundoApellido, :telefonoUsuario, :correoUsuario, :contraseniaUsuario, :fechaNacimiento, :descripcionDireccion, :codigoPostalDireccion, :idDistrito, :idRol)}", nativeQuery = true)
    void saveProcedureUsuario(
        @Param("cedulaUsuario") String cedulaUsuario, 
        @Param("nombreUsuario") String nombreUsuario,
        @Param("primerApellido") String primerApellido, 
        @Param("segundoApellido") String segundoApellido, 
        @Param("telefonoUsuario") String telefonoUsuario, 
        @Param("correoUsuario") String correoUsuario, 
        @Param("contraseniaUsuario") String contraseniaUsuario,
        @Param("fechaNacimiento") Date fechaNacimiento,
        @Param("descripcionDireccion") String descripcionDireccion, 
        @Param("codigoPostalDireccion") String codigoPostalDireccion,
        @Param("idDistrito") Integer idDistrito, 
        @Param("idRol") Integer idRol
    );

// -----------------------------------------------------------------------------    
    
    // SP Register
    @Modifying
    @Query(value = "{call spRegistrarUsuario(:correoUsuario, :contraseniaUsuario, :nombreUsuario, :primerApellido, :SegundoApellido, :estadoUsuario)}", nativeQuery = true)
    void registerProcedureUsuario(
            @Param("correoUsuario") String correoUsuario,
            @Param("contraseniaUsuario") String contraseniaUsuario,
            @Param("nombreUsuario") String nombreUsuario,
            @Param("primerApellido") String primerApellido,
            @Param("SegundoApellido") String SegundoApellido,
            @Param("estadoUsuario") boolean estadoUsuario
    );
// -----------------------------------------------------------------------------
    
    // Sp verficar si ese correo ya existe
    @Query(value = "{call spVerificarCorreo(:correoUsuario)}", nativeQuery = true)
    int verifyCorreoProcedureUsuario(@Param("correoUsuario") String correoUsuario);

// -----------------------------------------------------------------------------    
    
    // SP Update 
    @Modifying
    @Query(value = "{call spActualizarUsuario(:idUsuario, :cedulaUsuario, :nombreUsuario, :primerApellido, :segundoApellido, :telefonoUsuario, :correoUsuario, :contraseniaUsuario, :fechaNacimiento, :descripcionDireccion, :codigoPostalDireccion, :idDistrito, :estadoUsuario)}", nativeQuery = true)
    void updateProcedureUsuario(
        @Param("idUsuario") Integer idUsuario, 
        @Param("cedulaUsuario") String cedulaUsuario, 
        @Param("nombreUsuario") String nombreUsuario,
        @Param("primerApellido") String primerApellido, 
        @Param("segundoApellido") String segundoApellido, 
        @Param("telefonoUsuario") String telefonoUsuario, 
        @Param("correoUsuario") String correoUsuario, 
        @Param("contraseniaUsuario") String contraseniaUsuario,
        @Param("fechaNacimiento") Date fechaNacimiento,
        @Param("descripcionDireccion") String descripcionDireccion, 
        @Param("codigoPostalDireccion") String codigoPostalDireccion,
        @Param("idDistrito") Integer idDistrito,
        @Param("estadoUsuario") boolean estadoUsuario
    );

// -----------------------------------------------------------------------------    
    
    // SP Read 
    @Query(value = "{call spLeerUsuario()}", nativeQuery = true)
    List<Usuario> listProcedureUsuario();

// -----------------------------------------------------------------------------     
    
    // SP Delete 
    @Query(value = "{call spEliminarUsuario(:idUsuario)}", nativeQuery = true)
    void deleteProcedureUsuario(@Param("idUsuario") Integer idUsuario);
    
// -----------------------------------------------------------------------------     
    
    // SP para buscar el usuario por medio del correo, para el Login 
    @Query(value = "{call spBuscarUsuarioPorCorreo(:correoUsuario)}", nativeQuery = true)
    Usuario searchUsuario(@Param("correoUsuario") String correoUsuario);
    
     // SP para para actualizar ccontraseña
    @Query(value = "{call spActualizarContrasena(:idUsuario, :contraseniaUsuario)}", nativeQuery = true)
    Usuario UpdateProcedureContrasena(
            @Param("idUsuario") int idUsuario,
            @Param("contraseniaUsuario") String contraseniaUsuario);
    
    @Query(value = "{call spObtenerUsuarioById(:idUsuario)}", nativeQuery = true)
    Usuario listProcedureUsuarioById(@Param("idUsuario") int idUsuario);
}
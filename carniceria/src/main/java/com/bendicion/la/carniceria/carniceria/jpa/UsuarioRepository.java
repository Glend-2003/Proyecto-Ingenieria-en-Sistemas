package com.bendicion.la.carniceria.carniceria.jpa;
import com.bendicion.la.carniceria.carniceria.domain.Usuario;
import java.util.Date;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author Jamel Sandí
 */

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

    // SP Update 
    @Query(value = "{call spActualizarUsuario(:idUsuario, :cedulaUsuario, :nombreUsuario, :primerApellido, :segundoApellido, :telefonoUsuario, :correoUsuario, :contraseniaUsuario, :fechaNacimiento, :descripcionDireccion, :codigoPostalDireccion, :idDistrito)}", nativeQuery = true)
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
        @Param("idDistrito") Integer idDistrito
    );

    // SP Read 
    @Query(value = "{call spLeerUsuario()}", nativeQuery = true)
    List<Usuario> listProcedureUsuario();

    // SP Delete 
    @Query(value = "{call spEliminarUsuario(:idUsuario)}", nativeQuery = true)
    void deleteProcedureUsuario(@Param("idUsuario") Integer idUsuario);
}


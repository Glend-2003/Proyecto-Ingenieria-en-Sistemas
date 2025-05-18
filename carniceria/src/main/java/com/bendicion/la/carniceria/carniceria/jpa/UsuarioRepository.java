package com.bendicion.la.carniceria.carniceria.jpa;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.bendicion.la.carniceria.carniceria.domain.Usuario;

import jakarta.transaction.Transactional;

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

    @Modifying
    @Query(value = "{call spRegistrarUsuario(:correoUsuario, :contraseniaUsuario, :nombreUsuario, :primerApellido, :segundoApellido, :idRol, :estadoUsuario, :numCodigo)}", nativeQuery = true)
    void registerProcedureUsuario(
            @Param("correoUsuario") String correoUsuario,
            @Param("contraseniaUsuario") String contraseniaUsuario,
            @Param("nombreUsuario") String nombreUsuario,
            @Param("primerApellido") String primerApellido,
            @Param("segundoApellido") String segundoApellido,
            @Param("idRol") int idRol,
            @Param("estadoUsuario") boolean estadoUsuario,
            @Param("numCodigo") String numCodigo
    );

    @Query(value = "{call spVerificarCorreo(:correoUsuario)}", nativeQuery = true)
    int verifyCorreoProcedureUsuario(@Param("correoUsuario") String correoUsuario);

    @Modifying
    @Query(value = "{call spActualizarUsuario(:idUsuario, :cedulaUsuario, :nombreUsuario, :primerApellido, :segundoApellido, :telefonoUsuario, :correoUsuario, :contraseniaUsuario, :fechaNacimiento, :descripcionDireccion, :codigoPostalDireccion, :idDistrito, :idRol, :estadoUsuario)}", nativeQuery = true)
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
            @Param("idRol") Integer idRol,
            @Param("estadoUsuario") boolean estadoUsuario
    );

    @Query(value = "{call spLeerUsuario()}", nativeQuery = true)
    List<Usuario> listProcedureUsuario();

    @Query(value = "{call spEliminarUsuario(:idUsuario)}", nativeQuery = true)
    void deleteProcedureUsuario(
            @Param("idUsuario") Integer idUsuario);

    @Query(value = "{call spBuscarUsuarioPorCorreo(:correoUsuario)}", nativeQuery = true)
    Usuario searchUsuario(
            @Param("correoUsuario") String correoUsuario);

    @Query(value = "{call spActualizarContrasena(:idUsuario, :contraseniaUsuario)}", nativeQuery = true)
    Usuario UpdateProcedureContrasena(
            @Param("idUsuario") int idUsuario,
            @Param("contraseniaUsuario") String contraseniaUsuario);

    @Query(value = "{call spObtenerUsuarioById(:idUsuario)}", nativeQuery = true)
    Usuario listProcedureUsuarioById(
            @Param("idUsuario") Integer idUsuario);

    @Query(value = "{call spActivarUsuario(:idUsuario)}", nativeQuery = true)
    void activarUsuario(
            @Param("idUsuario") Integer idUsuario);

    @Query(value = "CALL spCambiarContrasenaConCodigo(:numCodigo, :nuevaContrasenia, :nuevoCodigo)", nativeQuery = true)
    int cambiarContrasenaConCodigo(
            @Param("numCodigo") String numCodigo,
            @Param("nuevaContrasenia") String nuevaContrasenia,
            @Param("nuevoCodigo") String nuevoCodigo);

    @Modifying
    @Transactional
    @Query(value = "{call spActualizarCredenciales(:idUsuario, :cedulaUsuario, :nombreUsuario, :primerApellido, :segundoApellido, :telefonoUsuario, :fechaNacimiento)}", nativeQuery = true)
    void actualizarCredenciales(
            @Param("idUsuario") Integer idUsuario,
            @Param("cedulaUsuario") String cedulaUsuario,
            @Param("nombreUsuario") String nombreUsuario,
            @Param("primerApellido") String primerApellido,
            @Param("segundoApellido") String segundoApellido,
            @Param("telefonoUsuario") String telefonoUsuario,
            @Param("fechaNacimiento") LocalDate fechaNacimiento
    );

}

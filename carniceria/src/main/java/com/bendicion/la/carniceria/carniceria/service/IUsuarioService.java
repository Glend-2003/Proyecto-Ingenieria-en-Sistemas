package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;

import com.bendicion.la.carniceria.carniceria.domain.Usuario;

import jakarta.transaction.Transactional;

public interface IUsuarioService {

    public Usuario addUsuario(Usuario usuario);

    @Transactional
    public Usuario updateUsuario(Usuario usuario);

    public List<Usuario> getUsuario();

    @Transactional
    public boolean deleteUsuario(int id);

    public Usuario validateLogin(String correo, String contraseniaIngresada);

    public Usuario searchCorreoUsuario(String correo);

    public Usuario registerUsuario(Usuario usuario);

    public Usuario actualizarContrasena(Usuario usuario);

    public Usuario getUsuarioById(int id);

    @Transactional
    public boolean activarUsuario(int id);

    public String generateCodigo();

    public void getCodigo(String correo);

    @Transactional
    public String cambiarContrasenaConCodigo(String numCodigo, String nuevaContrasenia);

    @Transactional
    public Usuario actualizarCredenciales(Usuario usuario);

}

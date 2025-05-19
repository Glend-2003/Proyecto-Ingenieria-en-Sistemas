package com.bendicion.la.carniceria.carniceria.service;

import java.util.List;
import java.util.Map;

import com.bendicion.la.carniceria.carniceria.domain.Comentario;

import jakarta.transaction.Transactional;

public interface IComentarioService {

    public Comentario addComentario(Comentario comentario);

    public List<Map<String, Object>> getComentariosAdmin();

    @Transactional
    public Comentario updateComentario(Comentario comentario);

    @Transactional
    public boolean activarComentario(int id);

    @Transactional
    public boolean mostrarComentario(int id);

    public List<Comentario> getComentariosUsuario();
}

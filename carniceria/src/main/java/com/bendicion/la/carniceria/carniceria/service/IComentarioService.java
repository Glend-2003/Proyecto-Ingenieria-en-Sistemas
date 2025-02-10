/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.bendicion.la.carniceria.carniceria.service;

import com.bendicion.la.carniceria.carniceria.domain.Comentario;
import com.bendicion.la.carniceria.carniceria.domain.Usuario;
import jakarta.transaction.Transactional;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Dilan Gutierrez
 */
public interface IComentarioService {

    // Agregar Comentario 
    public Comentario addComentario(Comentario comentario);

    public List<Map<String, Object>> getComentariosAdmin();

    @Transactional // Asegúrate de que esté anotado
    public Comentario updateComentario(Comentario comentario);
    
    @Transactional
    public boolean deleComentario(int id);
    
    @Transactional
    public boolean mostrarComentario(int id);
    
    public List<Comentario> getComentariosUsuario(); 
}

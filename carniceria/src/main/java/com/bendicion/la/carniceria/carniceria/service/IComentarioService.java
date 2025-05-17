package com.bendicion.la.carniceria.carniceria.service;
import com.bendicion.la.carniceria.carniceria.domain.Comentario;
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
    public boolean activarComentario(int id);
    
    @Transactional
    public boolean mostrarComentario(int id);
    
    public List<Comentario> getComentariosUsuario(); 
}

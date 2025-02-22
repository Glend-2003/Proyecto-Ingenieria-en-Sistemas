/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.bendicion.la.carniceria.carniceria.service;

import com.bendicion.la.carniceria.carniceria.domain.Promocion;
import jakarta.transaction.Transactional;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Dilan Gutierrez
 */
public interface IPromocionService {
    
     // Agregar Promocion 
    public Promocion addPromocion(Promocion promocion);
    
    //Lista de promociones
    @Transactional
     public List<Map<String, Object>> getPromociones();
     
    //Actualizar Promocion
    @Transactional 
    public Promocion updatePromocion(Promocion promocion);
    
    @Transactional
    public boolean deletePromocion(int id);
    
    @Transactional 
    public void enviarMensaje(String destino, String sujeto,String mensaje);
    
    @Transactional 
    public String mensajePredeterminado(String nombre, String descripcion, Date inicioPromocion, Date finPromocion, BigDecimal montoPromocion);
}

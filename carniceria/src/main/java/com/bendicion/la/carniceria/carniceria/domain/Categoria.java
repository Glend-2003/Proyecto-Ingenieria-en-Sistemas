package com.bendicion.la.carniceria.carniceria.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Jamel Sandí
 */

@Entity
@Table(name = "tbcategoria")
public class Categoria {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idCategoria")
    private int idCategoria;
    
    @Column(name = "nombreCategoria")
    private String nombreCategoria;
    
    @Column(name = "descripcionCategoria")
    private String descripcionCategoria;

/*
    Cuando empezemos a hacer el CRUD de Producto si vamos a necesitar esto
    
    @OneToMany(mappedBy = "producto", fetch = FetchType.EAGER)
    @JsonIgnore
    private List<Producto> producto;
    
    public Categoria() {
        producto = new ArrayList<>();
    }
*/
    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public String getNombreCategoria() {
        return nombreCategoria;
    }

    public void setNombreCategoria(String nombreCategoria) {
        this.nombreCategoria = nombreCategoria;
    }

    public String getDescripcionCategoria() {
        return descripcionCategoria;
    }

    public void setDescripcionCategoria(String descripcionCategoria) {
        this.descripcionCategoria = descripcionCategoria;
    }
/*
    public List<Producto> getProducto() {
        return producto;
    }

    public void setProducto(List<Producto> producto) {
        this.producto = producto;
    }
*/
    
}
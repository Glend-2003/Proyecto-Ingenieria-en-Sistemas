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
@Table(name = "tbprovincia")
public class Provincia {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idProvincia")
    private int idProvincia;
    
    @Column(name = "nombreProvincia")
    private String nombreProvincia;
    
    @OneToMany(mappedBy = "provincia", fetch = FetchType.EAGER)
    @JsonIgnore
    private List<Canton> canton;
    
    public Provincia() {
        canton = new ArrayList<>();
    }

    public int getIdProvincia() {
        return idProvincia;
    }

    public void setIdProvincia(int idProvincia) {
        this.idProvincia = idProvincia;
    }

    public String getNombreProvincia() {
        return nombreProvincia;
    }

    public void setNombreProvincia(String nombreProvincia) {
        this.nombreProvincia = nombreProvincia;
    }

    public List<Canton> getCanton() {
        return canton;
    }

    public void setCanton(List<Canton> canton) {
        this.canton = canton;
    }   
}
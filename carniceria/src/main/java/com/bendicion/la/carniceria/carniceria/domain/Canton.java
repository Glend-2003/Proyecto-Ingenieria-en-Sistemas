package com.bendicion.la.carniceria.carniceria.domain;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "tbcanton")
public class Canton {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idCanton")
    private int idCanton;

    @Column(name = "nombreCanton")
    private String nombreCanton;

    @OneToMany(mappedBy = "canton", fetch = FetchType.EAGER)
    @JsonIgnore
    private List<Distrito> distrito;

    @ManyToOne()
    @JoinColumn(name = "idProvincia")
    private Provincia provincia;

    public Canton() {
        distrito = new ArrayList<>();
    }

    public int getIdCanton() {
        return idCanton;
    }

    public void setIdCanton(int idCanton) {
        this.idCanton = idCanton;
    }

    public String getNombreCanton() {
        return nombreCanton;
    }

    public void setNombreCanton(String nombreCanton) {
        this.nombreCanton = nombreCanton;
    }

    public List<Distrito> getDistrito() {
        return distrito;
    }

    public void setDistrito(List<Distrito> distrito) {
        this.distrito = distrito;
    }

    public Provincia getProvincia() {
        return provincia;
    }

    public void setProvincia(Provincia provincia) {
        this.provincia = provincia;
    }

}

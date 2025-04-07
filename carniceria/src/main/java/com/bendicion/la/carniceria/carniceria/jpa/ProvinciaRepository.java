package com.bendicion.la.carniceria.carniceria.jpa;
import com.bendicion.la.carniceria.carniceria.domain.Provincia;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 *
 * @author Jamel Sandí
 */

public interface ProvinciaRepository extends JpaRepository<Provincia, Integer>{
    
    // SP Read Provincia
    @Query(value = "{call spObtenerProvincias()}", nativeQuery = true)
    List<Provincia> listProcedureProvincia();
}

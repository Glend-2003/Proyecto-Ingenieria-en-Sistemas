package com.bendicion.la.carniceria.carniceria.jpa;
import com.bendicion.la.carniceria.carniceria.domain.Distrito;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Jamel Sandí
 */

@Repository
public interface DistritoRepository extends JpaRepository<Distrito, Integer>{
    
    // SP Read
    @Query(value = "{call spLeerDistrito()}", nativeQuery = true)
    List<Distrito> listProcedureDistrito();
    
    // SP Read Distritos por Canton
    @Query(value = "{call spObtenerDistritosPorCanton()}", nativeQuery = true)
    List<Distrito> listProcedureDistritoCanton();
}

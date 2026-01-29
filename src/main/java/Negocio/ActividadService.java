package Negocio;

import Datos.ActividadDAO;
import Entidades.Actividad;
import java.util.List;

public class ActividadService {

    private final ActividadDAO actividadDAO;

    public ActividadService() {
        this.actividadDAO = new ActividadDAO();
    }

    public boolean registrarActividad(Actividad a) {
        // Validacion 1: Nombre obligatorio
        if (a.getNombre() == null || a.getNombre().trim().isEmpty()) {
            System.out.println("Validación: El nombre es obligatorio.");
            return false;
        }

        // Validacion 2: Fecha obligatoria
        if (a.getFecha() == null) {
            System.out.println("Validación: La fecha es obligatoria.");
            return false;
        }
        
        // Validacion 3: Descripción recomendada (opcional)
        if (a.getDescripcion() == null || a.getDescripcion().isEmpty()) {
            // Podríamos poner un texto por defecto si viene vacía
            a.setDescripcion("Sin descripción");
        }

        // Si pasa las validaciones, llamamos al DAO
        return actividadDAO.registrar(a);
    }

    public List<Actividad> listarActividades() {
        return actividadDAO.listar();
    }
}
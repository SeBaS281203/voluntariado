package Negocio;

import Datos.VoluntarioDAO;
import Entidades.Voluntario;
import java.util.List;

public class VoluntarioService {

    private final VoluntarioDAO voluntarioDAO;

    public VoluntarioService() {
        this.voluntarioDAO = new VoluntarioDAO();
    }

    /**
     * Lógica para registrar un voluntario.
     * Validamos que los datos personales estén completos.
     */
    public boolean registrarVoluntario(Voluntario v) {
        
        // 1. Validar campos vacíos
        if (v.getNombres().isEmpty() || v.getApellidos().isEmpty() || 
            v.getTelefono().isEmpty() || v.getCarrera().isEmpty()) {
            System.out.println("Validación: Faltan datos obligatorios del voluntario.");
            return false;
        }

        // 2. Validar correo (si lo escribió, que tenga formato válido)
        if (v.getCorreo() != null && !v.getCorreo().isEmpty()) {
            if (!v.getCorreo().contains("@")) {
                System.out.println("Validación: El correo no es válido.");
                return false;
            }
        }

        // Si todo está bien, lo mandamos a guardar
        return voluntarioDAO.registrar(v);
    }

    /**
     * Obtener la lista de voluntarios para mostrar en una tabla.
     */
    public List<Voluntario> listarVoluntarios() {
        return voluntarioDAO.listar();
    }

    public boolean eliminarVoluntario(int idVoluntario) {
        if (idVoluntario <= 0) {
            System.out.println("Validación: ID de voluntario inválido.");
            return false;
        }
        return voluntarioDAO.eliminarPorId(idVoluntario);
    }

    public boolean actualizarVoluntario(Voluntario v) {
        if (v.getIdVoluntario() <= 0) {
            System.out.println("Validación: ID de voluntario inválido.");
            return false;
        }

        if (v.getNombres().isEmpty() || v.getApellidos().isEmpty() ||
            v.getTelefono().isEmpty() || v.getCarrera().isEmpty()) {
            System.out.println("Validación: Faltan datos obligatorios del voluntario.");
            return false;
        }

        if (v.getCorreo() != null && !v.getCorreo().isEmpty()) {
            if (!v.getCorreo().contains("@")) {
                System.out.println("Validación: El correo no es válido.");
                return false;
            }
        }

        return voluntarioDAO.actualizar(v);
    }
}

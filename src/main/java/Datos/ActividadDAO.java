package Datos;

import Entidades.Actividad;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ActividadDAO {
    
    private final Connection con;

    public ActividadDAO() {
        this.con = Conexion.getConexion();
    }
    
    // MÉTODO REGISTRAR
    public boolean registrar(Actividad a) {
        // Asegúrate de que los nombres de columnas coincidan con TU base de datos
        String sql = "INSERT INTO actividad (nombre_actividad, descripcion, fecha, estado, id_beneficiario, id_usuario_creador) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, a.getNombre());
            ps.setString(2, a.getDescripcion());
            ps.setDate(3, a.getFecha());
            ps.setString(4, a.getEstado());
            
            // Si el ID es 0, enviamos NULL, si no, enviamos el número
            if (a.getIdBeneficiario() > 0) ps.setInt(5, a.getIdBeneficiario());
            else ps.setNull(5, java.sql.Types.INTEGER);
            
            ps.setInt(6, a.getIdUsuarioCreador());
            
            int filas = ps.executeUpdate();
            return filas > 0;
            
        } catch (SQLException e) {
            System.out.println("Error al registrar actividad: " + e.getMessage());
            return false;
        }
    }
    
    // MÉTODO LISTAR
    public List<Actividad> listar() {
        List<Actividad> lista = new ArrayList<>();
        String sql = "SELECT * FROM actividad";
        
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while(rs.next()){
                Actividad a = new Actividad();
                a.setIdActividad(rs.getInt("id_actividad"));
                // OJO: Aquí usa el nombre de la columna en tu BD (puede ser 'nombre' o 'nombre_actividad')
                a.setNombre(rs.getString("nombre_actividad")); 
                a.setDescripcion(rs.getString("descripcion"));
                a.setFecha(rs.getDate("fecha"));
                a.setEstado(rs.getString("estado"));
                a.setIdBeneficiario(rs.getInt("id_beneficiario"));
                a.setIdUsuarioCreador(rs.getInt("id_usuario_creador"));
                
                lista.add(a);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar actividades: " + e.getMessage());
        }
        return lista;
    }

    public boolean eliminarPorId(int idActividad) {
        String sql = "DELETE FROM actividad WHERE id_actividad = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idActividad);
            int filas = ps.executeUpdate();
            return filas > 0;
        } catch (SQLException e) {
            System.out.println("Error al eliminar actividad: " + e.getMessage());
            return false;
        }
    }

    public boolean actualizar(Actividad a) {
        String sql = "UPDATE actividad SET nombre_actividad = ?, descripcion = ?, fecha = ?, estado = ? "
                   + "WHERE id_actividad = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, a.getNombre());
            ps.setString(2, a.getDescripcion());
            ps.setDate(3, a.getFecha());
            ps.setString(4, a.getEstado());
            ps.setInt(5, a.getIdActividad());
            int filas = ps.executeUpdate();
            return filas > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar actividad: " + e.getMessage());
            return false;
        }
    }
}

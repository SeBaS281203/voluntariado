package Datos;

import Entidades.Voluntario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VoluntarioDAO {

    // Obtenemos la conexión única (Singleton)
    private final Connection con;

    public VoluntarioDAO() {
        this.con = Conexion.getConexion();
    }

    /**
     * Método para registrar un voluntario.
     */
    public boolean registrar(Voluntario v) {
        String sql = "INSERT INTO voluntario (nombres, apellidos, correo, telefono, carrera, estado, id_usuario) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, v.getNombres());
            ps.setString(2, v.getApellidos());
            ps.setString(3, v.getCorreo());
            ps.setString(4, v.getTelefono());
            ps.setString(5, v.getCarrera());
            ps.setString(6, "Activo"); // Por defecto activo
            
            // Manejo del ID Usuario (puede ser nulo si no tiene acceso al sistema)
            if (v.getIdUsuario() > 0) {
                ps.setInt(7, v.getIdUsuario());
            } else {
                ps.setNull(7, java.sql.Types.INTEGER);
            }
            
            int filas = ps.executeUpdate();
            return filas > 0;
            
        } catch (SQLException e) {
            System.out.println("Error al registrar voluntario: " + e.getMessage());
            return false;
        }
    }

    /**
     * Método para listar todos los voluntarios.
     */
    public List<Voluntario> listar() {
        List<Voluntario> lista = new ArrayList<>();
        String sql = "SELECT * FROM voluntario";
        
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Voluntario v = new Voluntario();
                v.setIdVoluntario(rs.getInt("id_voluntario"));
                v.setNombres(rs.getString("nombres"));
                v.setApellidos(rs.getString("apellidos"));
                v.setCorreo(rs.getString("correo"));
                v.setTelefono(rs.getString("telefono"));
                v.setCarrera(rs.getString("carrera"));
                v.setEstado(rs.getString("estado"));
                // El id_usuario podría venir nulo de la BD, getInt devuelve 0 si es null
                v.setIdUsuario(rs.getInt("id_usuario"));
                
                lista.add(v);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar voluntarios: " + e.getMessage());
        }
        return lista;
    }
    
    // Aquí podrías agregar métodos para eliminar() o actualizar() más adelante
}
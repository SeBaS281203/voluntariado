package Datos;

import Entidades.Usuario; 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    // Instancia de la conexión (Singleton)
    private final Connection con;

    public UsuarioDAO() {
        // Como Conexion y UsuarioDAO están en el mismo paquete "Datos", 
        // no hace falta importarlo.
        this.con = Conexion.getConexion();
    }

    /**
     * Método para registrar un nuevo usuario en la base de datos.
     */
    public boolean registrar(Usuario usuario) {
        String sql = "INSERT INTO usuario (nombres, apellidos, correo, username, password_hash, estado, creado_en) "
                   + "VALUES (?, ?, ?, ?, ?, 'Activo', NOW())";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, usuario.getNombres());
            ps.setString(2, usuario.getApellidos());
            ps.setString(3, usuario.getCorreo());
            ps.setString(4, usuario.getUsername());
            ps.setString(5, usuario.getPasswordHash()); 
            
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
            
        } catch (SQLException e) {
            System.out.println("Error al registrar usuario: " + e.getMessage());
            return false;
        }
    }

    /**
     * Método para validar el login.
     */
    public Usuario login(String username, String password) {
        Usuario user = null;
        String sql = "SELECT * FROM usuario WHERE username = ? AND password_hash = ? AND estado = 'Activo'";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new Usuario();
                    user.setIdUsuario(rs.getInt("id_usuario"));
                    user.setNombres(rs.getString("nombres"));
                    user.setApellidos(rs.getString("apellidos"));
                    user.setCorreo(rs.getString("correo"));
                    user.setUsername(rs.getString("username"));
                    user.setEstado(rs.getString("estado"));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error en login: " + e.getMessage());
        }
        return user;
    }

    /**
     * Método para listar todos los usuarios.
     */
    public List<Usuario> listar() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuario";
        
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("id_usuario"));
                u.setNombres(rs.getString("nombres"));
                u.setApellidos(rs.getString("apellidos"));
                u.setCorreo(rs.getString("correo"));
                u.setUsername(rs.getString("username"));
                u.setEstado(rs.getString("estado"));
                lista.add(u);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar usuarios: " + e.getMessage());
        }
        return lista;
    }
}

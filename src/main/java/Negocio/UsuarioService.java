package Negocio;

import Datos.UsuarioDAO;
import Entidades.Usuario;
import java.util.List;

public class UsuarioService {

    private final UsuarioDAO usuarioDAO;

    public UsuarioService() {
        // Inicializamos el DAO para poder comunicarnos con la BD
        this.usuarioDAO = new UsuarioDAO();
    }

    /**
     * Lógica para registrar un usuario.
     * Aquí verificamos que los datos sean válidos antes de guardar.
     */
    public boolean registrarUsuario(Usuario usuario) {
        
        // 1. Validar que los campos obligatorios no estén vacíos
        if (usuario.getNombres().isEmpty() || usuario.getApellidos().isEmpty() || 
            usuario.getUsername().isEmpty() || usuario.getPasswordHash().isEmpty()) {
            System.out.println("Validación: Todos los campos son obligatorios.");
            return false;
        }

        // 2. Validar formato de correo (Lo que pediste: debe tener '@')
        if (usuario.getCorreo() == null || !usuario.getCorreo().contains("@")) {
            System.out.println("Validación: El correo debe contener un arroba '@'.");
            return false;
        }

        // 3. Validar longitud de contraseña (ejemplo extra)
        if (usuario.getPasswordHash().length() < 4) {
             System.out.println("Validación: La contraseña es muy corta.");
             return false;
        }

        // Si pasa todas las validaciones, recién llamamos al DAO
        return usuarioDAO.registrar(usuario);
    }

    /**
     * Lógica para el login.
     */
    public Usuario login(String username, String password) {
        // Validamos que no envíen textos vacíos
        if (username.isEmpty() || password.isEmpty()) {
            return null;
        }
        // Llamamos al DAO
        return usuarioDAO.login(username, password);
    }

    /**
     * Obtener lista de usuarios
     */
    public List<Usuario> listarUsuarios() {
        return usuarioDAO.listar();
    }
}


package Entidades;

// Usamos tipos de datos que coincidan con tu SQL (INT -> int, VARCHAR -> String)
public class Usuario {
    private int idUsuario;
    private String nombres;
    private String apellidos;
    private String correo;
    private String username;
    private String passwordHash;
    private String estado;
    
    // Constructor vacío
    public Usuario() {
    }

    // Constructor completo (sin ID, ya que es autoincrementable)
    public Usuario(String nombres, String apellidos, String correo, String username, String passwordHash, String estado) {
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.correo = correo;
        this.username = username;
        this.passwordHash = passwordHash;
        this.estado = estado;
    }

    // Getters y Setters (Necesarios para que las otras capas accedan a los datos)
    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }

    public String getNombres() { return nombres; }
    public void setNombres(String nombres) { this.nombres = nombres; }

    public String getApellidos() { return apellidos; }
    public void setApellidos(String apellidos) { this.apellidos = apellidos; }

    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}

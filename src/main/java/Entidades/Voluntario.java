package Entidades;

public class Voluntario {
    
    // Atributos que coinciden con las columnas de tu Base de Datos
    private int idVoluntario;
    private String nombres;
    private String apellidos;
    private String correo;
    private String telefono;
    private String carrera;
    private String estado;
    private int idUsuario; // Para relacionarlo con el login (puede ser 0 si no tiene usuario)

    // 1. Constructor vacío (Obligatorio para muchas librerías y buenas prácticas)
    public Voluntario() {
    }

    // 2. Constructor lleno (Sin ID, porque el ID es autoincremental en la BD)
    public Voluntario(String nombres, String apellidos, String correo, String telefono, String carrera, String estado, int idUsuario) {
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.correo = correo;
        this.telefono = telefono;
        this.carrera = carrera;
        this.estado = estado;
        this.idUsuario = idUsuario;
    }

    // 3. Getters y Setters (Para leer y escribir los datos)
    public int getIdVoluntario() {
        return idVoluntario;
    }

    public void setIdVoluntario(int idVoluntario) {
        this.idVoluntario = idVoluntario;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getCarrera() {
        return carrera;
    }

    public void setCarrera(String carrera) {
        this.carrera = carrera;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }
    
    // Opcional: Para imprimir el objeto fácilmente
    @Override
    public String toString() {
        return nombres + " " + apellidos;
    }
}
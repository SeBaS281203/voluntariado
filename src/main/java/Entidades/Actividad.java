package Entidades;

import java.sql.Date;

public class Actividad {
    private int idActividad;
    private String nombre;
    private String descripcion;
    private Date fecha;      // Usamos Date de SQL
    private String estado;
    
    // IDs para relacionar con otras tablas (Claves foráneas)
    private int idBeneficiario; 
    private int idUsuarioCreador;

    public Actividad() {
    }

    public Actividad(String nombre, String descripcion, Date fecha, String estado, int idBeneficiario, int idUsuarioCreador) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.fecha = fecha;
        this.estado = estado;
        this.idBeneficiario = idBeneficiario;
        this.idUsuarioCreador = idUsuarioCreador;
    }

    // --- GETTERS Y SETTERS ---
    public int getIdActividad() { return idActividad; }
    public void setIdActividad(int idActividad) { this.idActividad = idActividad; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public Date getFecha() { return fecha; }
    public void setFecha(Date fecha) { this.fecha = fecha; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public int getIdBeneficiario() { return idBeneficiario; }
    public void setIdBeneficiario(int idBeneficiario) { this.idBeneficiario = idBeneficiario; }

    public int getIdUsuarioCreador() { return idUsuarioCreador; }
    public void setIdUsuarioCreador(int idUsuarioCreador) { this.idUsuarioCreador = idUsuarioCreador; }
    
    @Override
    public String toString() {
        return nombre; // Para mostrar solo el nombre si se usa en listas
    }
}
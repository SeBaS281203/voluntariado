package Datos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
    // 1. Instancia estática (Singleton)
    private static Connection instancia = null;
    
    // Configuración de la BD (Ajusta según tu PC)
    private static final String URL = "jdbc:mysql://localhost:3306/sistema_voluntariado";
    private static final String USER = "root"; // Tu usuario de BD
    private static final String PASS = "";     // Tu contraseña de BD

    // 2. Constructor privado para evitar 'new Conexion()' desde fuera
    private Conexion() {}

    // 3. Método estático para obtener la instancia
    public static Connection getConexion() {
        try {
            if (instancia == null || instancia.isClosed()) {
                // Cargar el driver (opcional en versiones nuevas, pero buena práctica)
                Class.forName("com.mysql.cj.jdbc.Driver");
                instancia = DriverManager.getConnection(URL, USER, PASS);
                System.out.println("Conexión exitosa a la base de datos.");
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Error en la conexión: " + e.getMessage());
        }
        return instancia;
    }
    
    // Método para cerrar (opcional pero recomendado)
    public static void cerrar() {
        if (instancia != null) {
            try {
                instancia.close();
                instancia = null;
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
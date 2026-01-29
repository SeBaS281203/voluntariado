<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="Entidades.Usuario" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8">
    <title>Menu - Sistema Voluntariado</title>
    <style>
      body { font-family: Arial, sans-serif; margin: 40px; }
      nav a { margin-right: 16px; }
      .card { max-width: 720px; margin: 0 auto; padding: 24px; border: 1px solid #ccc; border-radius: 8px; }
    </style>
  </head>
  <body>
    <div class="card">
      <nav>
        <a href="<%= request.getContextPath() %>/voluntarios">Voluntarios</a>
        <a href="<%= request.getContextPath() %>/actividades">Actividades</a>
        <a href="<%= request.getContextPath() %>/logout">Salir</a>
      </nav>
      <%
        Usuario usuario = (Usuario) request.getAttribute("usuario");
      %>
      <h1>Menu principal</h1>
      <p>Bienvenido<%= usuario != null ? ", " + usuario.getNombres() : "" %>.</p>
      <p>Selecciona una opcion del menu para continuar.</p>
    </div>
  </body>
</html>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Entidades.Voluntario" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8">
    <title>Voluntarios</title>
    <style>
      body { font-family: Arial, sans-serif; margin: 40px; }
      nav a { margin-right: 16px; }
      .card { max-width: 960px; margin: 0 auto; padding: 24px; border: 1px solid #ccc; border-radius: 8px; }
      .row { display: flex; gap: 16px; margin-bottom: 12px; }
      .field { flex: 1; }
      label { display: block; margin-bottom: 6px; }
      input { width: 100%; padding: 8px; box-sizing: border-box; }
      table { width: 100%; border-collapse: collapse; margin-top: 16px; }
      th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
      .alert { color: #b00020; margin-bottom: 12px; }
      .success { color: #1b5e20; margin-bottom: 12px; }
    </style>
  </head>
  <body>
    <div class="card">
      <nav>
        <a href="<%= request.getContextPath() %>/menu">Menu</a>
        <a href="<%= request.getContextPath() %>/actividades">Actividades</a>
        <a href="<%= request.getContextPath() %>/logout">Salir</a>
      </nav>
      <h1>Gestion de voluntarios</h1>
      <%
        String error = (String) request.getAttribute("error");
        String mensaje = (String) request.getAttribute("mensaje");
        if (error != null) {
      %>
        <div class="alert"><%= error %></div>
      <%
        } else if (mensaje != null) {
      %>
        <div class="success"><%= mensaje %></div>
      <%
        }
      %>
      <form method="post" action="<%= request.getContextPath() %>/voluntarios">
        <div class="row">
          <div class="field">
            <label for="nombres">Nombres</label>
            <input id="nombres" name="nombres" type="text" required>
          </div>
          <div class="field">
            <label for="apellidos">Apellidos</label>
            <input id="apellidos" name="apellidos" type="text" required>
          </div>
        </div>
        <div class="row">
          <div class="field">
            <label for="correo">Correo</label>
            <input id="correo" name="correo" type="email">
          </div>
          <div class="field">
            <label for="telefono">Telefono</label>
            <input id="telefono" name="telefono" type="text" required>
          </div>
        </div>
        <div class="row">
          <div class="field">
            <label for="carrera">Profesion</label>
            <input id="carrera" name="carrera" type="text" required>
          </div>
        </div>
        <button type="submit">Guardar</button>
      </form>
      <%
        List<Voluntario> voluntarios = (List<Voluntario>) request.getAttribute("voluntarios");
      %>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Nombres</th>
            <th>Apellidos</th>
            <th>Correo</th>
            <th>Telefono</th>
            <th>Profesion</th>
          </tr>
        </thead>
        <tbody>
          <%
            if (voluntarios != null) {
              for (Voluntario v : voluntarios) {
          %>
          <tr>
            <td><%= v.getIdVoluntario() %></td>
            <td><%= v.getNombres() %></td>
            <td><%= v.getApellidos() %></td>
            <td><%= v.getCorreo() %></td>
            <td><%= v.getTelefono() %></td>
            <td><%= v.getCarrera() %></td>
          </tr>
          <%
              }
            }
          %>
        </tbody>
      </table>
    </div>
  </body>
</html>

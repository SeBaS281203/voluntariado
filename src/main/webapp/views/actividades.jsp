<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Entidades.Actividad" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8">
    <title>Actividades</title>
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
      .note { font-size: 0.9em; color: #555; margin-bottom: 12px; }
    </style>
  </head>
  <body>
    <div class="card">
      <nav>
        <a href="<%= request.getContextPath() %>/menu">Menu</a>
        <a href="<%= request.getContextPath() %>/voluntarios">Voluntarios</a>
        <a href="<%= request.getContextPath() %>/logout">Salir</a>
      </nav>
      <h1>Gestion de actividades</h1>
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
      <div class="note">Formato de fecha: AAAA-MM-DD</div>
      <form method="post" action="<%= request.getContextPath() %>/actividades">
        <div class="row">
          <div class="field">
            <label for="nombre">Actividad</label>
            <input id="nombre" name="nombre" type="text" required>
          </div>
          <div class="field">
            <label for="descripcion">Descripcion</label>
            <input id="descripcion" name="descripcion" type="text">
          </div>
          <div class="field">
            <label for="fecha">Fecha</label>
            <input id="fecha" name="fecha" type="text" placeholder="2024-12-31" required>
          </div>
        </div>
        <button type="submit">Guardar</button>
      </form>
      <%
        List<Actividad> actividades = (List<Actividad>) request.getAttribute("actividades");
      %>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Actividad</th>
            <th>Descripcion</th>
            <th>Fecha</th>
            <th>Estado</th>
          </tr>
        </thead>
        <tbody>
          <%
            if (actividades != null) {
              for (Actividad a : actividades) {
          %>
          <tr>
            <td><%= a.getIdActividad() %></td>
            <td><%= a.getNombre() %></td>
            <td><%= a.getDescripcion() %></td>
            <td><%= a.getFecha() %></td>
            <td><%= a.getEstado() %></td>
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

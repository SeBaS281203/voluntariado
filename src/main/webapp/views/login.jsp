<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8">
    <title>Login - Sistema Voluntariado</title>
    <style>
      body { font-family: Arial, sans-serif; margin: 40px; }
      .card { max-width: 420px; margin: 0 auto; padding: 24px; border: 1px solid #ccc; border-radius: 8px; }
      .row { margin-bottom: 12px; }
      label { display: block; margin-bottom: 6px; }
      input { width: 100%; padding: 8px; box-sizing: border-box; }
      button { padding: 8px 16px; }
      .alert { color: #b00020; margin-bottom: 12px; }
    </style>
  </head>
  <body>
    <div class="card">
      <h1>Ingreso</h1>
      <%
        String error = (String) request.getAttribute("error");
        String username = (String) request.getAttribute("username");
        if (error != null) {
      %>
        <div class="alert"><%= error %></div>
      <%
        }
      %>
      <form method="post" action="<%= request.getContextPath() %>/login">
        <div class="row">
          <label for="username">Usuario</label>
          <input id="username" name="username" type="text" value="<%= username == null ? "" : username %>" required>
        </div>
        <div class="row">
          <label for="password">Contrasena</label>
          <input id="password" name="password" type="password" required>
        </div>
        <button type="submit">Ingresar</button>
      </form>
    </div>
  </body>
</html>

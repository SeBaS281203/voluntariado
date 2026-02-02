<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8">
    <title>Login - Sistema Voluntariado</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
      tailwind.config = {
        theme: {
          extend: {
            fontFamily: {
              sans: ['Inter', 'ui-sans-serif', 'system-ui', 'sans-serif']
            }
          }
        }
      };
    </script>
  </head>
  <body class="min-h-screen bg-zinc-100 text-zinc-900 font-sans">
    <div class="min-h-screen flex items-center justify-center px-6 py-12">
      <div class="w-full max-w-md">
        <div class="mb-8">
          <p class="text-sm uppercase tracking-[0.2em] text-zinc-500">Sistema Voluntariado</p>
          <h1 class="mt-3 text-2xl font-semibold text-zinc-900">Ingreso</h1>
          <p class="mt-2 text-sm text-zinc-600">Accede con tu usuario y contrasena.</p>
        </div>
        <div class="rounded-2xl border border-zinc-200 bg-white p-6 shadow-sm">
          <%
            String error = (String) request.getAttribute("error");
            String username = (String) request.getAttribute("username");
            if (error != null) {
          %>
            <div class="mb-4 rounded-lg border border-zinc-200 bg-zinc-50 px-4 py-3 text-sm text-zinc-800">
              <%= error %>
            </div>
          <%
            }
          %>
          <form method="post" action="<%= request.getContextPath() %>/login" class="space-y-4">
            <div>
              <label for="username" class="block text-sm font-medium text-zinc-700">Usuario</label>
              <input id="username" name="username" type="text" value="<%= username == null ? "" : username %>" required
                class="mt-2 w-full rounded-lg border border-zinc-300 bg-white px-3 py-2 text-sm text-zinc-900 placeholder-zinc-400 shadow-sm focus:border-zinc-900 focus:outline-none focus:ring-2 focus:ring-zinc-200">
            </div>
            <div>
              <label for="password" class="block text-sm font-medium text-zinc-700">Contrasena</label>
              <input id="password" name="password" type="password" required
                class="mt-2 w-full rounded-lg border border-zinc-300 bg-white px-3 py-2 text-sm text-zinc-900 placeholder-zinc-400 shadow-sm focus:border-zinc-900 focus:outline-none focus:ring-2 focus:ring-zinc-200">
            </div>
            <button type="submit"
              class="w-full rounded-lg bg-zinc-900 px-4 py-2 text-sm font-semibold text-white shadow-sm transition hover:bg-zinc-800 focus:outline-none focus:ring-2 focus:ring-zinc-300">
              Ingresar
            </button>
          </form>
        </div>
        <p class="mt-6 text-xs text-zinc-500">Uso interno. Si tienes problemas, contacta al administrador.</p>
      </div>
    </div>
  </body>
</html>

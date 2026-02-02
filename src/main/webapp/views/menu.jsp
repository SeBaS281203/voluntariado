<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="Entidades.Usuario" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8">
    <title>Menu - Sistema Voluntariado</title>
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
    <div class="min-h-screen px-6 py-12">
      <div class="mx-auto w-full max-w-4xl">
        <header class="mb-8 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <p class="text-sm uppercase tracking-[0.2em] text-zinc-500">Sistema Voluntariado</p>
            <h1 class="mt-3 text-2xl font-semibold">Menu principal</h1>
          </div>
          <nav class="flex flex-wrap gap-3 text-sm">
            <a class="rounded-full border border-zinc-300 bg-white px-4 py-2 text-zinc-700 hover:border-zinc-400 hover:text-zinc-900" href="<%= request.getContextPath() %>/voluntarios">Voluntarios</a>
            <a class="rounded-full border border-zinc-300 bg-white px-4 py-2 text-zinc-700 hover:border-zinc-400 hover:text-zinc-900" href="<%= request.getContextPath() %>/actividades">Actividades</a>
            <a class="rounded-full border border-zinc-300 bg-zinc-900 px-4 py-2 text-white hover:bg-zinc-800" href="<%= request.getContextPath() %>/logout">Salir</a>
          </nav>
        </header>
        <div class="rounded-2xl border border-zinc-200 bg-white p-8 shadow-sm">
          <%
            Usuario usuario = (Usuario) request.getAttribute("usuario");
          %>
          <h2 class="text-xl font-semibold text-zinc-900">Bienvenido<%= usuario != null ? ", " + usuario.getNombres() : "" %>.</h2>
          <p class="mt-2 text-sm text-zinc-600">Selecciona una opcion del menu para continuar.</p>
          <div class="mt-6 grid gap-4 sm:grid-cols-2">
            <a class="rounded-xl border border-zinc-200 bg-zinc-50 px-5 py-4 text-sm font-medium text-zinc-800 hover:border-zinc-300" href="<%= request.getContextPath() %>/voluntarios">
              Gestionar voluntarios
            </a>
            <a class="rounded-xl border border-zinc-200 bg-zinc-50 px-5 py-4 text-sm font-medium text-zinc-800 hover:border-zinc-300" href="<%= request.getContextPath() %>/actividades">
              Gestionar actividades
            </a>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>

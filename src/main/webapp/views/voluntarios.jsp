<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Entidades.Voluntario" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8">
    <title>Voluntarios</title>
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
      <div class="mx-auto w-full max-w-5xl">
        <header class="mb-8 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <p class="text-sm uppercase tracking-[0.2em] text-zinc-500">Sistema Voluntariado</p>
            <h1 class="mt-3 text-2xl font-semibold">Gestion de voluntarios</h1>
          </div>
          <div class="flex flex-wrap items-center gap-3 text-sm">
            <button type="button"
              class="rounded-full border border-zinc-900 bg-zinc-900 px-4 py-2 text-white hover:bg-zinc-800"
              onclick="openVoluntarioModal()">
              Nuevo voluntario
            </button>
            <nav class="flex flex-wrap gap-2 rounded-full border border-zinc-200 bg-white p-1">
              <a class="rounded-full px-3 py-1.5 text-zinc-700 hover:text-zinc-900" href="<%= request.getContextPath() %>/menu">Menu</a>
              <span class="rounded-full bg-zinc-900 px-3 py-1.5 text-white">Voluntarios</span>
              <a class="rounded-full px-3 py-1.5 text-zinc-700 hover:text-zinc-900" href="<%= request.getContextPath() %>/actividades">Actividades</a>
            </nav>
            <a class="rounded-full border border-zinc-300 bg-zinc-900 px-4 py-2 text-white hover:bg-zinc-800" href="<%= request.getContextPath() %>/logout">Salir</a>
          </div>
        </header>
        <%
          String error = (String) request.getAttribute("error");
          String mensaje = (String) request.getAttribute("mensaje");
          if (error != null) {
        %>
          <div class="mb-6 rounded-2xl border border-zinc-200 bg-white px-6 py-4 text-sm text-zinc-800 shadow-sm">
            <%= error %>
          </div>
        <%
          } else if (mensaje != null) {
        %>
          <div class="mb-6 rounded-2xl border border-zinc-200 bg-white px-6 py-4 text-sm text-zinc-800 shadow-sm">
            <%= mensaje %>
          </div>
        <%
          }
        %>
        <div class="mt-8 rounded-2xl border border-zinc-200 bg-white p-6 shadow-sm">
          <h2 class="text-lg font-semibold text-zinc-900">Listado de voluntarios</h2>
          <div class="mt-4 overflow-x-auto">
            <table class="min-w-full text-sm">
              <thead class="text-left text-xs uppercase tracking-wide text-zinc-500">
                <tr class="border-b border-zinc-200">
                  <th class="pb-3 pr-4">ID</th>
                  <th class="pb-3 pr-4">Nombres</th>
                  <th class="pb-3 pr-4">Apellidos</th>
                  <th class="pb-3 pr-4">Correo</th>
                  <th class="pb-3 pr-4">Telefono</th>
                  <th class="pb-3 pr-4">Profesion</th>
                  <th class="pb-3">Acciones</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-zinc-100">
                <%
                  List<Voluntario> voluntarios = (List<Voluntario>) request.getAttribute("voluntarios");
                  if (voluntarios != null) {
                    for (Voluntario v : voluntarios) {
                %>
                <tr class="text-zinc-700">
                  <td class="py-3 pr-4"><%= v.getIdVoluntario() %></td>
                  <td class="py-3 pr-4"><%= v.getNombres() %></td>
                  <td class="py-3 pr-4"><%= v.getApellidos() %></td>
                  <td class="py-3 pr-4"><%= v.getCorreo() %></td>
                  <td class="py-3 pr-4"><%= v.getTelefono() %></td>
                  <td class="py-3 pr-4"><%= v.getCarrera() %></td>
                  <td class="py-3">
                    <div class="flex flex-wrap gap-2">
                      <button type="button"
                        class="rounded-lg border border-zinc-300 px-3 py-1 text-xs font-semibold text-zinc-700 hover:border-zinc-400 hover:text-zinc-900"
                        data-id="<%= v.getIdVoluntario() %>"
                        data-nombres="<%= v.getNombres() %>"
                        data-apellidos="<%= v.getApellidos() %>"
                        data-correo="<%= v.getCorreo() %>"
                        data-telefono="<%= v.getTelefono() %>"
                        data-carrera="<%= v.getCarrera() %>"
                        onclick="openVoluntarioModalFromButton(this)">
                        Editar
                      </button>
                      <form method="post" action="<%= request.getContextPath() %>/voluntarios" onsubmit="return confirm('¿Eliminar este voluntario?');">
                        <input type="hidden" name="accion" value="eliminar">
                        <input type="hidden" name="idVoluntario" value="<%= v.getIdVoluntario() %>">
                        <button type="submit" class="rounded-lg border border-zinc-300 px-3 py-1 text-xs font-semibold text-zinc-700 hover:border-zinc-400 hover:text-zinc-900">
                          Eliminar
                        </button>
                      </form>
                    </div>
                  </td>
                </tr>
                <%
                    }
                  }
                %>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
    <div id="voluntarioModal" class="fixed inset-0 z-50 hidden items-center justify-center bg-zinc-900/60 px-4">
      <div class="w-full max-w-2xl rounded-2xl bg-white p-6 shadow-xl">
        <div class="flex items-start justify-between gap-4">
          <div>
            <p class="text-sm uppercase tracking-[0.2em] text-zinc-500">Voluntarios</p>
            <h2 id="voluntarioModalTitle" class="mt-2 text-xl font-semibold text-zinc-900">Nuevo voluntario</h2>
          </div>
          <button type="button" class="rounded-full border border-zinc-300 px-3 py-1 text-xs text-zinc-700 hover:border-zinc-400" onclick="closeVoluntarioModal()">Cerrar</button>
        </div>
        <form method="post" action="<%= request.getContextPath() %>/voluntarios" class="mt-6 grid gap-4 md:grid-cols-2">
          <input type="hidden" id="voluntarioAccion" name="accion" value="crear">
          <input type="hidden" id="voluntarioId" name="idVoluntario" value="">
          <div>
            <label for="modalNombres" class="block text-sm font-medium text-zinc-700">Nombres</label>
            <input id="modalNombres" name="nombres" type="text" required
              class="mt-2 w-full rounded-lg border border-zinc-300 bg-white px-3 py-2 text-sm text-zinc-900 shadow-sm focus:border-zinc-900 focus:outline-none focus:ring-2 focus:ring-zinc-200">
          </div>
          <div>
            <label for="modalApellidos" class="block text-sm font-medium text-zinc-700">Apellidos</label>
            <input id="modalApellidos" name="apellidos" type="text" required
              class="mt-2 w-full rounded-lg border border-zinc-300 bg-white px-3 py-2 text-sm text-zinc-900 shadow-sm focus:border-zinc-900 focus:outline-none focus:ring-2 focus:ring-zinc-200">
          </div>
          <div>
            <label for="modalCorreo" class="block text-sm font-medium text-zinc-700">Correo</label>
            <input id="modalCorreo" name="correo" type="email"
              class="mt-2 w-full rounded-lg border border-zinc-300 bg-white px-3 py-2 text-sm text-zinc-900 shadow-sm focus:border-zinc-900 focus:outline-none focus:ring-2 focus:ring-zinc-200">
          </div>
          <div>
            <label for="modalTelefono" class="block text-sm font-medium text-zinc-700">Telefono</label>
            <input id="modalTelefono" name="telefono" type="text" required
              class="mt-2 w-full rounded-lg border border-zinc-300 bg-white px-3 py-2 text-sm text-zinc-900 shadow-sm focus:border-zinc-900 focus:outline-none focus:ring-2 focus:ring-zinc-200">
          </div>
          <div class="md:col-span-2">
            <label for="modalCarrera" class="block text-sm font-medium text-zinc-700">Profesion</label>
            <input id="modalCarrera" name="carrera" type="text" required
              class="mt-2 w-full rounded-lg border border-zinc-300 bg-white px-3 py-2 text-sm text-zinc-900 shadow-sm focus:border-zinc-900 focus:outline-none focus:ring-2 focus:ring-zinc-200">
          </div>
          <div class="md:col-span-2 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
            <p class="text-xs text-zinc-500">Campos obligatorios marcados por el navegador.</p>
            <button id="voluntarioModalSubmit" type="submit"
              class="w-full rounded-lg bg-zinc-900 px-4 py-2 text-sm font-semibold text-white shadow-sm transition hover:bg-zinc-800 focus:outline-none focus:ring-2 focus:ring-zinc-300 sm:w-auto">
              Guardar
            </button>
          </div>
        </form>
      </div>
    </div>
    <script>
      const voluntarioModal = document.getElementById('voluntarioModal');
      const voluntarioModalTitle = document.getElementById('voluntarioModalTitle');
      const voluntarioModalSubmit = document.getElementById('voluntarioModalSubmit');
      const voluntarioAccion = document.getElementById('voluntarioAccion');
      const voluntarioId = document.getElementById('voluntarioId');
      const modalNombres = document.getElementById('modalNombres');
      const modalApellidos = document.getElementById('modalApellidos');
      const modalCorreo = document.getElementById('modalCorreo');
      const modalTelefono = document.getElementById('modalTelefono');
      const modalCarrera = document.getElementById('modalCarrera');

      function openVoluntarioModal(data) {
        const isEdit = data && data.id;
        voluntarioModal.classList.remove('hidden');
        voluntarioModal.classList.add('flex');
        voluntarioModalTitle.textContent = isEdit ? 'Editar voluntario' : 'Nuevo voluntario';
        voluntarioModalSubmit.textContent = isEdit ? 'Actualizar' : 'Guardar';
        voluntarioAccion.value = isEdit ? 'editar' : 'crear';
        voluntarioId.value = isEdit ? data.id : '';
        modalNombres.value = isEdit ? data.nombres : '';
        modalApellidos.value = isEdit ? data.apellidos : '';
        modalCorreo.value = isEdit ? data.correo : '';
        modalTelefono.value = isEdit ? data.telefono : '';
        modalCarrera.value = isEdit ? data.carrera : '';
      }

      function openVoluntarioModalFromButton(button) {
        const data = {
          id: button.dataset.id,
          nombres: button.dataset.nombres,
          apellidos: button.dataset.apellidos,
          correo: button.dataset.correo,
          telefono: button.dataset.telefono,
          carrera: button.dataset.carrera
        };
        openVoluntarioModal(data);
      }

      function closeVoluntarioModal() {
        voluntarioModal.classList.add('hidden');
        voluntarioModal.classList.remove('flex');
      }

      voluntarioModal.addEventListener('click', (event) => {
        if (event.target === voluntarioModal) {
          closeVoluntarioModal();
        }
      });
    </script>
  </body>
</html>

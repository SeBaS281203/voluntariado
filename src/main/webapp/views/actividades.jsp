<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Entidades.Actividad" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8">
    <title>Actividades</title>
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
            <h1 class="mt-3 text-2xl font-semibold">Gestion de actividades</h1>
          </div>
          <div class="flex flex-wrap items-center gap-3 text-sm">
            <button type="button"
              class="rounded-full border border-zinc-900 bg-zinc-900 px-4 py-2 text-white hover:bg-zinc-800"
              onclick="openActividadModal()">
              Nueva actividad
            </button>
            <nav class="flex flex-wrap gap-2 rounded-full border border-zinc-200 bg-white p-1">
              <a class="rounded-full px-3 py-1.5 text-zinc-700 hover:text-zinc-900" href="<%= request.getContextPath() %>/menu">Menu</a>
              <a class="rounded-full px-3 py-1.5 text-zinc-700 hover:text-zinc-900" href="<%= request.getContextPath() %>/voluntarios">Voluntarios</a>
              <span class="rounded-full bg-zinc-900 px-3 py-1.5 text-white">Actividades</span>
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
          <h2 class="text-lg font-semibold text-zinc-900">Listado de actividades</h2>
          <div class="mt-4 overflow-x-auto">
            <table class="min-w-full text-sm">
              <thead class="text-left text-xs uppercase tracking-wide text-zinc-500">
                <tr class="border-b border-zinc-200">
                  <th class="pb-3 pr-4">ID</th>
                  <th class="pb-3 pr-4">Actividad</th>
                  <th class="pb-3 pr-4">Descripcion</th>
                  <th class="pb-3 pr-4">Fecha</th>
                  <th class="pb-3 pr-4">Estado</th>
                  <th class="pb-3">Acciones</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-zinc-100">
                <%
                  List<Actividad> actividades = (List<Actividad>) request.getAttribute("actividades");
                  if (actividades != null) {
                    for (Actividad a : actividades) {
                %>
                <tr class="text-zinc-700">
                  <td class="py-3 pr-4"><%= a.getIdActividad() %></td>
                  <td class="py-3 pr-4"><%= a.getNombre() %></td>
                  <td class="py-3 pr-4"><%= a.getDescripcion() %></td>
                  <td class="py-3 pr-4"><%= a.getFecha() %></td>
                  <td class="py-3 pr-4"><%= a.getEstado() %></td>
                  <td class="py-3">
                    <div class="flex flex-wrap gap-2">
                      <button type="button"
                        class="rounded-lg border border-zinc-300 px-3 py-1 text-xs font-semibold text-zinc-700 hover:border-zinc-400 hover:text-zinc-900"
                        data-id="<%= a.getIdActividad() %>"
                        data-nombre="<%= a.getNombre() %>"
                        data-descripcion="<%= a.getDescripcion() %>"
                        data-fecha="<%= a.getFecha() %>"
                        data-estado="<%= a.getEstado() %>"
                        onclick="openActividadModalFromButton(this)">
                        Editar
                      </button>
                      <form method="post" action="<%= request.getContextPath() %>/actividades" onsubmit="return confirm('¿Eliminar esta actividad?');">
                        <input type="hidden" name="accion" value="eliminar">
                        <input type="hidden" name="idActividad" value="<%= a.getIdActividad() %>">
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
    <div id="actividadModal" class="fixed inset-0 z-50 hidden items-center justify-center bg-zinc-900/60 px-4">
      <div class="w-full max-w-3xl rounded-2xl bg-white p-6 shadow-xl">
        <div class="flex items-start justify-between gap-4">
          <div>
            <p class="text-sm uppercase tracking-[0.2em] text-zinc-500">Actividades</p>
            <h2 id="actividadModalTitle" class="mt-2 text-xl font-semibold text-zinc-900">Nueva actividad</h2>
          </div>
          <button type="button" class="rounded-full border border-zinc-300 px-3 py-1 text-xs text-zinc-700 hover:border-zinc-400" onclick="closeActividadModal()">Cerrar</button>
        </div>
        <p class="mt-4 text-xs text-zinc-500">Formato de fecha: AAAA-MM-DD</p>
        <form method="post" action="<%= request.getContextPath() %>/actividades" class="mt-4 grid gap-4 md:grid-cols-4">
          <input type="hidden" id="actividadAccion" name="accion" value="crear">
          <input type="hidden" id="actividadId" name="idActividad" value="">
          <div class="md:col-span-2">
            <label for="modalNombreActividad" class="block text-sm font-medium text-zinc-700">Actividad</label>
            <input id="modalNombreActividad" name="nombre" type="text" required
              class="mt-2 w-full rounded-lg border border-zinc-300 bg-white px-3 py-2 text-sm text-zinc-900 shadow-sm focus:border-zinc-900 focus:outline-none focus:ring-2 focus:ring-zinc-200">
          </div>
          <div class="md:col-span-2">
            <label for="modalDescripcionActividad" class="block text-sm font-medium text-zinc-700">Descripcion</label>
            <input id="modalDescripcionActividad" name="descripcion" type="text"
              class="mt-2 w-full rounded-lg border border-zinc-300 bg-white px-3 py-2 text-sm text-zinc-900 shadow-sm focus:border-zinc-900 focus:outline-none focus:ring-2 focus:ring-zinc-200">
          </div>
          <div>
            <label for="modalFechaActividad" class="block text-sm font-medium text-zinc-700">Fecha</label>
            <input id="modalFechaActividad" name="fecha" type="date" required
              class="mt-2 w-full rounded-lg border border-zinc-300 bg-white px-3 py-2 text-sm text-zinc-900 shadow-sm focus:border-zinc-900 focus:outline-none focus:ring-2 focus:ring-zinc-200">
          </div>
          <div>
            <label for="modalEstadoActividad" class="block text-sm font-medium text-zinc-700">Estado</label>
            <input id="modalEstadoActividad" name="estado" type="text" placeholder="Pendiente"
              class="mt-2 w-full rounded-lg border border-zinc-300 bg-white px-3 py-2 text-sm text-zinc-900 shadow-sm focus:border-zinc-900 focus:outline-none focus:ring-2 focus:ring-zinc-200">
          </div>
          <div class="md:col-span-4 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
            <p class="text-xs text-zinc-500">Completa la informacion antes de guardar.</p>
            <button id="actividadModalSubmit" type="submit"
              class="w-full rounded-lg bg-zinc-900 px-4 py-2 text-sm font-semibold text-white shadow-sm transition hover:bg-zinc-800 focus:outline-none focus:ring-2 focus:ring-zinc-300 sm:w-auto">
              Guardar
            </button>
          </div>
        </form>
      </div>
    </div>
    <script>
      const actividadModal = document.getElementById('actividadModal');
      const actividadModalTitle = document.getElementById('actividadModalTitle');
      const actividadModalSubmit = document.getElementById('actividadModalSubmit');
      const actividadAccion = document.getElementById('actividadAccion');
      const actividadId = document.getElementById('actividadId');
      const modalNombreActividad = document.getElementById('modalNombreActividad');
      const modalDescripcionActividad = document.getElementById('modalDescripcionActividad');
      const modalFechaActividad = document.getElementById('modalFechaActividad');
      const modalEstadoActividad = document.getElementById('modalEstadoActividad');

      function openActividadModal(data) {
        const isEdit = data && data.id;
        actividadModal.classList.remove('hidden');
        actividadModal.classList.add('flex');
        actividadModalTitle.textContent = isEdit ? 'Editar actividad' : 'Nueva actividad';
        actividadModalSubmit.textContent = isEdit ? 'Actualizar' : 'Guardar';
        actividadAccion.value = isEdit ? 'editar' : 'crear';
        actividadId.value = isEdit ? data.id : '';
        modalNombreActividad.value = isEdit ? data.nombre : '';
        modalDescripcionActividad.value = isEdit ? data.descripcion : '';
        modalFechaActividad.value = isEdit ? data.fecha : '';
        modalEstadoActividad.value = isEdit ? data.estado : '';
      }

      function openActividadModalFromButton(button) {
        const data = {
          id: button.dataset.id,
          nombre: button.dataset.nombre,
          descripcion: button.dataset.descripcion,
          fecha: button.dataset.fecha,
          estado: button.dataset.estado
        };
        openActividadModal(data);
      }

      function closeActividadModal() {
        actividadModal.classList.add('hidden');
        actividadModal.classList.remove('flex');
      }

      actividadModal.addEventListener('click', (event) => {
        if (event.target === actividadModal) {
          closeActividadModal();
        }
      });
    </script>
  </body>
</html>

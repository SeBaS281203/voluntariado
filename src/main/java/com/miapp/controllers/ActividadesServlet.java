package com.miapp.controllers;

import Entidades.Actividad;
import Entidades.Usuario;
import Negocio.ActividadService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "ActividadesServlet", urlPatterns = {"/actividades"})
public class ActividadesServlet extends HttpServlet {
    private final ActividadService actividadService = new ActividadService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (!AuthUtil.requireLogin(request, response)) {
            return;
        }
        loadAndForward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (!AuthUtil.requireLogin(request, response)) {
            return;
        }

        String accion = value(request.getParameter("accion"));
        if ("eliminar".equalsIgnoreCase(accion)) {
            int idActividad = parseId(request.getParameter("idActividad"));
            if (idActividad <= 0) {
                request.setAttribute("error", "ID de actividad inválido.");
            } else if (actividadService.eliminarActividad(idActividad)) {
                request.setAttribute("mensaje", "Actividad eliminada con exito.");
            } else {
                request.setAttribute("error", "No se pudo eliminar la actividad.");
            }
            loadAndForward(request, response);
            return;
        }

        if ("editar".equalsIgnoreCase(accion)) {
            int idActividad = parseId(request.getParameter("idActividad"));
            String nombre = value(request.getParameter("nombre"));
            String descripcion = value(request.getParameter("descripcion"));
            String fechaTexto = value(request.getParameter("fecha"));
            String estado = value(request.getParameter("estado"));

            if (fechaTexto.isEmpty()) {
                request.setAttribute("error", "Debe ingresar una fecha (AAAA-MM-DD).");
                loadAndForward(request, response);
                return;
            }

            Date fechaSql;
            try {
                fechaSql = Date.valueOf(fechaTexto);
            } catch (IllegalArgumentException ex) {
                request.setAttribute("error", "Formato de fecha incorrecto. Use AAAA-MM-DD.");
                loadAndForward(request, response);
                return;
            }

            Actividad actividad = new Actividad();
            actividad.setIdActividad(idActividad);
            actividad.setNombre(nombre);
            actividad.setDescripcion(descripcion);
            actividad.setFecha(fechaSql);
            actividad.setEstado(estado);

            if (actividadService.actualizarActividad(actividad)) {
                request.setAttribute("mensaje", "Actividad actualizada con exito.");
            } else {
                request.setAttribute("error", "No se pudo actualizar la actividad. Verifica los datos.");
            }

            loadAndForward(request, response);
            return;
        }

        String nombre = value(request.getParameter("nombre"));
        String descripcion = value(request.getParameter("descripcion"));
        String fechaTexto = value(request.getParameter("fecha"));

        if (fechaTexto.isEmpty()) {
            request.setAttribute("error", "Debe ingresar una fecha (AAAA-MM-DD).");
            loadAndForward(request, response);
            return;
        }

        Date fechaSql;
        try {
            fechaSql = Date.valueOf(fechaTexto);
        } catch (IllegalArgumentException ex) {
            request.setAttribute("error", "Formato de fecha incorrecto. Use AAAA-MM-DD.");
            loadAndForward(request, response);
            return;
        }

        Usuario usuario = AuthUtil.getUsuario(request);
        int idUsuario = usuario != null ? usuario.getIdUsuario() : 1;

        Actividad actividad = new Actividad(nombre, descripcion, fechaSql, "Pendiente", 0, idUsuario);
        if (actividadService.registrarActividad(actividad)) {
            request.setAttribute("mensaje", "Actividad guardada con exito.");
        } else {
            request.setAttribute("error", "No se pudo guardar la actividad. Verifica los datos.");
        }

        loadAndForward(request, response);
    }

    private void loadAndForward(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Actividad> actividades = actividadService.listarActividades();
        request.setAttribute("actividades", actividades);

        try {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/actividades.jsp");
            dispatcher.forward(request, response);
        } catch (Exception ex) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "No se pudo cargar actividades.");
        }
    }

    private String value(String input) {
        return input == null ? "" : input.trim();
    }

    private int parseId(String input) {
        try {
            return Integer.parseInt(value(input));
        } catch (NumberFormatException ex) {
            return -1;
        }
    }
}

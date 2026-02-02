package com.miapp.controllers;

import Entidades.Voluntario;
import Negocio.VoluntarioService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "VoluntariosServlet", urlPatterns = {"/voluntarios"})
public class VoluntariosServlet extends HttpServlet {
    private final VoluntarioService voluntarioService = new VoluntarioService();

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
            int idVoluntario = parseId(request.getParameter("idVoluntario"));
            if (idVoluntario <= 0) {
                request.setAttribute("error", "ID de voluntario inválido.");
            } else if (voluntarioService.eliminarVoluntario(idVoluntario)) {
                request.setAttribute("mensaje", "Voluntario eliminado con exito.");
            } else {
                request.setAttribute("error", "No se pudo eliminar el voluntario.");
            }
            loadAndForward(request, response);
            return;
        }

        if ("editar".equalsIgnoreCase(accion)) {
            int idVoluntario = parseId(request.getParameter("idVoluntario"));
            String nombres = value(request.getParameter("nombres"));
            String apellidos = value(request.getParameter("apellidos"));
            String correo = value(request.getParameter("correo"));
            String telefono = value(request.getParameter("telefono"));
            String carrera = value(request.getParameter("carrera"));

            Voluntario voluntario = new Voluntario(nombres, apellidos, correo, telefono, carrera, "Activo", 0);
            voluntario.setIdVoluntario(idVoluntario);
            if (voluntarioService.actualizarVoluntario(voluntario)) {
                request.setAttribute("mensaje", "Voluntario actualizado con exito.");
            } else {
                request.setAttribute("error", "No se pudo actualizar el voluntario. Verifica los datos.");
            }

            loadAndForward(request, response);
            return;
        }

        String nombres = value(request.getParameter("nombres"));
        String apellidos = value(request.getParameter("apellidos"));
        String correo = value(request.getParameter("correo"));
        String telefono = value(request.getParameter("telefono"));
        String carrera = value(request.getParameter("carrera"));

        Voluntario voluntario = new Voluntario(nombres, apellidos, correo, telefono, carrera, "Activo", 0);
        if (voluntarioService.registrarVoluntario(voluntario)) {
            request.setAttribute("mensaje", "Voluntario registrado con exito.");
        } else {
            request.setAttribute("error", "No se pudo guardar el voluntario. Verifica los datos.");
        }

        loadAndForward(request, response);
    }

    private void loadAndForward(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Voluntario> voluntarios = voluntarioService.listarVoluntarios();
        request.setAttribute("voluntarios", voluntarios);

        try {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/voluntarios.jsp");
            dispatcher.forward(request, response);
        } catch (Exception ex) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "No se pudo cargar voluntarios.");
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

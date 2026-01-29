package com.miapp.controllers;

import Entidades.Usuario;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "MenuServlet", urlPatterns = {"/menu"})
public class MenuServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (!AuthUtil.requireLogin(request, response)) {
            return;
        }

        Usuario user = AuthUtil.getUsuario(request);
        request.setAttribute("usuario", user);

        try {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/menu.jsp");
            dispatcher.forward(request, response);
        } catch (Exception ex) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "No se pudo cargar el menu.");
        }
    }
}

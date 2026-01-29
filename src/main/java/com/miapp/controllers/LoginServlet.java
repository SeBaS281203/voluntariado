package com.miapp.controllers;

import Entidades.Usuario;
import Negocio.UsuarioService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    private final UsuarioService usuarioService = new UsuarioService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Usuario user = usuarioService.login(username == null ? "" : username, password == null ? "" : password);
        if (user != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("usuario", user);
            response.sendRedirect(request.getContextPath() + "/menu");
            return;
        }

        request.setAttribute("error", "Usuario o contrasena incorrectos.");
        request.setAttribute("username", username);
        forward(request, response);
    }

    private void forward(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/login.jsp");
            dispatcher.forward(request, response);
        } catch (Exception ex) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "No se pudo cargar la vista.");
        }
    }
}

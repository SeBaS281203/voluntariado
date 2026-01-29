package com.miapp.controllers;

import Entidades.Usuario;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

final class AuthUtil {
    private AuthUtil() {}

    static Usuario getUsuario(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }
        Object value = session.getAttribute("usuario");
        return (value instanceof Usuario) ? (Usuario) value : null;
    }

    static boolean requireLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (getUsuario(request) == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        return true;
    }
}

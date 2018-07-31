/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.cryptoluka.controller;

import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.cryptoluka.business.Players;
import org.cryptoluka.dao.PlayerDAO;
import org.cryptoluka.entity.Player;
import org.cryptoluka.utils.Respuesta;

/**
 *
 * @author arielsalas
 */
public class login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
        PrintWriter out = response.getWriter();
        JsonObject resp = new JsonObject();

        try {

            String email = request.getParameter("email");
            String pass = request.getParameter("pass");

            if (email == null || email.equalsIgnoreCase("") || email.trim().length() < 1) {
                throw new Exception();
            }

            if (pass == null || pass.equalsIgnoreCase("") || pass.trim().length() < 1) {
                throw new Exception();
            }

           
            Players p = new Players();

            Respuesta r = p.Login(email, pass);

            if (r.getStatus()) {

                Player session = (Player) r.getData();
                session.setPassword("");
                
                request.getSession().setAttribute("player", session);

                resp.addProperty("status", "OK");

            }
        } catch (Exception ex) {
            resp.addProperty("status", ex.toString());
        }

        out.print(resp.toString());
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

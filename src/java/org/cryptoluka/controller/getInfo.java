/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.cryptoluka.controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.cryptoluka.dao.InfoDAO;
import org.cryptoluka.dao.RollDAO;
import org.cryptoluka.entity.Player;
import org.cryptoluka.entity.Rollhistory;

/**
 *
 * @author arielsalas
 */
public class getInfo extends HttpServlet {

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

        PrintWriter out = response.getWriter();

        JsonObject resp = new JsonObject();

        try {

            String required = request.getParameter("method");

            if (required == null || required.trim().equalsIgnoreCase("") || required.trim().length() < 1) {
                throw new Exception("Invalid parameters");
            }

            switch (required) {

                case "jackpot":
                    InfoDAO idao = new InfoDAO();

                    resp.addProperty("status", "OK");
                    resp.addProperty("message", "Jackpot");
                    resp.addProperty("jackpot", idao.getJackpot());
                    break;
                case "last7plays":

                    RollDAO rdao = new RollDAO();
                    ArrayList<Rollhistory> rolls = (ArrayList<Rollhistory>) rdao.getLast7Bets();

                    JsonArray lastBets = new JsonArray();

                    if (rolls.size() > 0) {

                        for (Rollhistory bet : rolls) {

                            JsonObject myRoll = new JsonObject();

                            myRoll.addProperty("gameid", bet.getIdgame());
                            myRoll.addProperty("player", bet.getNickname());
                            myRoll.addProperty("time", bet.getCreationtime().toString());
                            myRoll.addProperty("bet", bet.getBet());
                            myRoll.addProperty("target", bet.getTarget());
                            myRoll.addProperty("number", bet.getNumber());
                            myRoll.addProperty("result", bet.getResult());

                            lastBets.add(myRoll);

                        }
                    }

                    resp.addProperty("status", "OK");
                    resp.add("message", lastBets);

                    break;
                default:
                    resp.addProperty("status", "OK");
                    resp.addProperty("message", "Method not found");
            }

        } catch (Exception ex) {

            resp.addProperty("status", "ERROR");
            resp.addProperty("message", ex.getMessage());

        }

        // PRINTS RESPONSE
        out.print(resp.toString());
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

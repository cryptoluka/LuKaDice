/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.cryptoluka.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.UUID;
import java.util.concurrent.ThreadLocalRandom;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.cryptoluka.dao.PlayerDAO;
import org.cryptoluka.dao.RollDAO;
import org.cryptoluka.entity.Player;
import org.cryptoluka.entity.Rollhistory;
import org.cryptoluka.utils.Encriptacion;
import org.cryptoluka.utils.MathDice;

/**
 *
 * @author arielsalas
 */
public class playDice extends HttpServlet {

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

        PrintWriter out = response.getWriter();

        try {

            // VALIDATE SESSION
            Player pl = null;
            if (request.getSession().getAttribute("player") != null) {
                pl = (Player) request.getSession().getAttribute("player");
            } else {
                throw new Exception("No existe sesión");
            }

            // GET ALL PARAMS
            String paramProbabilidad = request.getParameter("target");
            String paramPayout = request.getParameter("payout");
            String paramBalance = request.getParameter("balance");
            String paramRango = request.getParameter("bet");
            String paramMontoApostado = request.getParameter("apuesta");

            // VALIDATE PARAMS
            if (paramProbabilidad == null || paramProbabilidad.trim().equalsIgnoreCase("") || Double.parseDouble(paramProbabilidad) < 1.01 || Double.parseDouble(paramProbabilidad) > 98.99) {
                throw new Exception("Target no es valido");
            }

            if (paramPayout == null || paramPayout.trim().equalsIgnoreCase("") || Double.parseDouble(paramPayout) < 1.01 || Double.parseDouble(paramPayout) > 98.01) {
                throw new Exception("Payout no es valido");
            }

            if (paramBalance == null || paramBalance.trim().equalsIgnoreCase("") || Double.parseDouble(paramBalance) < 0) {
                throw new Exception("Balance no es valido");
            }

            if (paramRango == null || paramRango.trim().equalsIgnoreCase("") || Integer.parseInt(paramRango) < 100 || Integer.parseInt(paramRango) > 9799) {
                throw new Exception("Bet no es valido");
            }

            if (paramMontoApostado == null || paramMontoApostado.trim().equalsIgnoreCase("") || Double.parseDouble(paramMontoApostado) < 0.00001000 || Double.parseDouble(paramMontoApostado) > 100) {
                throw new Exception("Monto apostado no es valido");
            }

            if (pl.getBalance().doubleValue() != Double.parseDouble(paramBalance)) {
                throw new Exception("Balances incorrectos");
            }

            // INIT MATH OBJECTS
            DecimalFormat eight = new DecimalFormat("0.00000000");
            MathDice m = new MathDice();

            // INIT BUSINESS OBJECTS
            PlayerDAO pdao = new PlayerDAO();
            JsonObject playerToken = new JsonObject();

            // THEN PLAY THE GAME
            int randomNum = ThreadLocalRandom.current().nextInt(0, 9999 + 1);

            // PARSE ALL VARIABLES (TO SERVER COMPARING)
            boolean isWon = false;
            double profit = 0;
            int rangeBet = Integer.parseInt(paramRango);
            double numberPayout = Double.parseDouble(eight.format(Double.parseDouble(paramPayout)).replace(",", "."));
            double numberApuesta = Double.parseDouble(eight.format(Double.parseDouble(paramMontoApostado)).replace(",", "."));
            double winChance = m.calculateChance(rangeBet);

            if (numberPayout != m.calculatePayout(winChance)) {
                throw new Exception("Payout incorrectos");
            }

            if (randomNum < rangeBet) {
                isWon = true;
            }

            // SELECT THE PLAYER FOR SECURITY - DONT USE SESSION
            Player updatingPlayer = pdao.getById(pl.getIdplayer());

            if (isWon) {

                profit = (numberApuesta * (numberPayout - 1));
                profit = Double.parseDouble(eight.format(profit).replace(",", "."));
                
                
                double newBalance = updatingPlayer.getBalance().doubleValue() + profit;

                updatingPlayer.setBalance(BigDecimal.valueOf(newBalance));

                pdao.update(updatingPlayer);

                pl.setBalance(BigDecimal.valueOf(newBalance));

                playerToken.addProperty("profit", profit);

            } else {

                double newBalance = updatingPlayer.getBalance().doubleValue() - numberApuesta;

                updatingPlayer.setBalance(BigDecimal.valueOf(newBalance));

                pdao.update(updatingPlayer);

                pl.setBalance(BigDecimal.valueOf(newBalance));

                playerToken.addProperty("profit", numberApuesta);

            }

            RollDAO rdao = new RollDAO();
            Rollhistory roll = new Rollhistory();

            roll.setIdgame(UUID.randomUUID().toString());
            roll.setPlayer(pl);
            roll.setNumber(randomNum);
            roll.setNickname(pl.getNickname());
            roll.setBet(BigDecimal.valueOf(numberApuesta));
            roll.setTarget(BigDecimal.valueOf(numberPayout));
            roll.setCreationtime(new Date());
            roll.setLastupdate(new Date());

            if (isWon) {
                roll.setProfit(BigDecimal.valueOf(profit));
                roll.setResult(true);
            } else {
                roll.setProfit(BigDecimal.valueOf(0.00000000));
                roll.setResult(false);
            }

            rdao.add(roll);

            playerToken.addProperty("number", randomNum);
            playerToken.addProperty("balance", pl.getBalance());
            playerToken.addProperty("nickname", updatingPlayer.getNickname());
            playerToken.addProperty("roll_uuid", roll.getIdgame());

            out.print(playerToken.toString());

        } catch (Exception ex) {
            Logger.getLogger(playDice.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println(ex.toString());
            
        }

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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.cryptoluka.business;

import java.math.BigDecimal;
import java.util.Date;
import java.util.UUID;
import org.cryptoluka.dao.PlayerDAO;
import org.cryptoluka.entity.Player;
import org.cryptoluka.utils.Encriptacion;
import org.cryptoluka.utils.Payments;
import org.cryptoluka.utils.Respuesta;

/**
 *
 * @author arielsalas
 */
public class Players {

    public Players() {
    }

    public Respuesta Login(String email, String password) {

        Respuesta r = new Respuesta();

        try {

            Payments pay = new Payments();
            PlayerDAO pdao = new PlayerDAO();

            Player p = pdao.getByCorreoActive(email);

            if (p != null) {

                r.setData(p);
                r.setMessage("Login correcto!");
                r.setStatus(true);

            }

        } catch (Exception ex) {

            r.setData(null);
            r.setMessage("No se encontraron datos");
            r.setStatus(false);

            System.out.println("Error: " + ex.toString());
        }

        return r;
    }

    public Respuesta registrarUsuario(String email, String password) {

        Respuesta r = new Respuesta();

        try {

            Payments pay = new Payments();
            Player p = new Player();

            p.setIdplayer(UUID.randomUUID().toString());
            p.setPaymentid(pay.generatePaymentID());
            p.setNickname("player-" + p.getIdplayer().substring(0, 8));
            p.setBalance(BigDecimal.valueOf(50.00000000));
            p.setEmail(email);
            p.setUsername("player-" + p.getIdplayer().substring(0, 8));
            p.setPassword(Encriptacion.Encriptar(password));
            p.setCreationtime(new Date());
            p.setLastupdate(new Date());

            PlayerDAO pdao = new PlayerDAO();
            pdao.add(p);
            
            r.setStatus(true);
            r.setMessage("Usuario registrado!");
            r.setData(pdao.getById(p.getIdplayer()));
            

        } catch (Exception ex) {
            System.out.println("Error: " + ex.toString());
            r.setStatus(false);
            r.setMessage("Error al registrar usuario");
        }

        return r;
    }

    public Respuesta solicitarNuevoPaymentID(String userUUID) {

        Respuesta r = new Respuesta();

        try {

            Payments pay = new Payments();
            PlayerDAO pdao = new PlayerDAO();

            Player p = pdao.getById(userUUID);

            if (p != null) {

                p.setPaymentid(pay.generatePaymentID());
                p.setLastupdate(new Date());

                pdao.update(p);
            }

        } catch (Exception ex) {
            System.out.println("Error: " + ex.toString());
        }

        return r;
    }

}

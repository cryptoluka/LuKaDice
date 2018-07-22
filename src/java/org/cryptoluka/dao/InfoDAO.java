/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.cryptoluka.dao;

import java.math.BigDecimal;
import java.util.List;
import org.cryptoluka.dal.HibernateUtil;
import org.cryptoluka.entity.Player;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

/**
 *
 * @author arielsalas
 */
public class InfoDAO {

    public double getJackpot() throws Exception {
        Session sessionA = HibernateUtil.getSessionFactory().openSession();
        sessionA.beginTransaction();

        try {

            String statement = "SELECT (SUM(ab.Profit) / 3) * 2 AS 'JACKPOT' FROM player pl\n"
                    + "JOIN (\n"
                    + "	SELECT r.idplayer AS 'nick', (50 - p.balance) AS 'Profit'\n"
                    + "	FROM rollhistory r\n"
                    + "	JOIN player p ON p.idplayer = r.idplayer\n"
                    + "	GROUP BY p.nickname, r.idplayer, p.balance, (50 - p.balance)\n"
                    + "	) ab ON pl.idplayer = ab.nick";

            double jackpot = 0;

            SQLQuery query = sessionA.createSQLQuery(statement);
            List<Object> rows = query.list();

            jackpot = Double.parseDouble(rows.get(0).toString());

            System.out.println("Jackpot: " + jackpot);

            sessionA.getTransaction().commit();

            return jackpot;
        } catch (Exception e) {
            sessionA.getTransaction().rollback();
            System.out.println(e.getMessage());
            throw e;
        } finally {
            sessionA.close();
        }
    }

}

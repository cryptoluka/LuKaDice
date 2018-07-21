/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.cryptoluka.utils;

import java.text.DecimalFormat;

/**
 *
 * @author arielsalas
 */
public class MathDice {

    public MathDice() {
    }
    
    public double calculatePayout(double chance) {
        
        DecimalFormat two = new DecimalFormat("0.00");
        
        double payout = (99 / chance);
        payout = Double.parseDouble(two.format(payout).replace(",", "."));
        
        System.out.println("Payout: " + payout + "x");
        
        return payout;
    }
    
    public double calculateChance(int rangeBet) {
        
        DecimalFormat two = new DecimalFormat("0.00");
        
        double chance = ((double) rangeBet / 9999) * 100;
        chance = Double.parseDouble(two.format(chance).replace(",", "."));
        
        System.out.println("Chance: " + chance + "%");
        
        return chance;
    }
    
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.cryptoluka.utils;

import java.math.BigInteger;
import java.security.SecureRandom;

public class Payments {

    public Payments() {

    }

    public String generatePaymentID() {

        SecureRandom secureRandom = new SecureRandom();
        byte[] token = new byte[32];
        secureRandom.nextBytes(token);

        String hex = new BigInteger(1, token).toString(16);

        if (hex.length() == 64) {
            return hex;
        } else {
            return generatePaymentID();
        }
    }
}

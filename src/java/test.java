
import java.math.BigInteger;
import java.security.SecureRandom;
import org.cryptoluka.business.Players;
import org.cryptoluka.entity.Player;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author arielsalas
 */
public class test {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        Players p = new Players();
        // p.registrarUsuario();
         p.solicitarNuevoPaymentID("d12d17ab-591d-41e5-a231-1a90a7629e52");
        
        Player zz = (Player) p.Login("ariel_saher@hotmail.com", "1234").getData();
        
        System.out.println(zz.getPaymentid());
        
        System.exit(0);

        // testRandom64();
    }
    
    public static void testRandom64() {
        for (int i = 0; i < 100; i++) {
            
            SecureRandom secureRandom = new SecureRandom();
            byte[] token = new byte[32];
            secureRandom.nextBytes(token);
            
            String hex = new BigInteger(1, token).toString(16);
            
            if (hex.length() != 64) {
                System.out.println("ERROR");
            } else {
                System.out.println(hex + " " + hex.length()); //hex encoding
            }
        }
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cloud.multimicro.booking.util;
import java.security.Key;
import java.util.Date;

import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;

import org.jboss.logging.Logger;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

/*
 *
 * @author zo
 */

public class Jwt {
    private static final Logger LOGGER = Logger.getLogger(Jwt.class);
    
    public static String generateToken() {
        //The JWT signature algorithm we will be using to sign the token
        SignatureAlgorithm signatureAlgorithm = SignatureAlgorithm.HS256;

        long nowMillis = System.currentTimeMillis();
        Date now = new Date(nowMillis);

        //We will sign our JWT with our ApiKey secret
        byte[] apiKeySecretBytes = DatatypeConverter.parseBase64Binary(Constant.MMC_JWT_SECRET_KEY);
        Key signingKey = new SecretKeySpec(apiKeySecretBytes, signatureAlgorithm.getJcaName());

        //Let's set the JWT Claims
        JwtBuilder builder = Jwts.builder().setId(Constant.MMC_JWT_ID)
                .setIssuedAt(now)
                .setSubject(Constant.MMC_JWT_SUBJECT)
                .setIssuer(Constant.MMC_JWT_ISSUER)
                .signWith(signatureAlgorithm, signingKey);

        //if it has been specified, let's add the expiration
        if (Constant.MMC_JWT_TTL >= 0) {
            long expMillis = nowMillis + Constant.MMC_JWT_TTL;
            Date exp = new Date(expMillis);
            builder.setExpiration(exp);
        }

        //Builds the JWT and serializes it to a compact, URL-safe string
        return builder.compact();
    }
    
    public static boolean isTokenValid(String token) {
        try {
            //This line will throw an exception if it is not a signed JWS (as expected)
            Claims claims = Jwts.parser()
            .setSigningKey(DatatypeConverter.parseBase64Binary(Constant.MMC_JWT_SECRET_KEY))
            .parseClaimsJws(token).getBody();
            return claims != null;
        
        } catch (Exception e) {
            LOGGER.info(e.getMessage());
            return false;
        }
    }    
}
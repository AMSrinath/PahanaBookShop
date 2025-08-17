package pahana.education.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import pahana.education.model.response.UserDataResponse;

import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class JwtUtil {
    private static final Key key = Keys.secretKeyFor(SignatureAlgorithm.HS256);
    private static final long EXPIRATION_TIME = 1000 * 60 * 60; // 1 hour

    public static String generateToken(UserDataResponse userDataResponse) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("userId", userDataResponse.getId());
        claims.put("email", userDataResponse.getEmail());
        claims.put("firstName", userDataResponse.getFirstName());
        claims.put("lastName", userDataResponse.getLastName());
        claims.put("role", userDataResponse.getUserRole().getName());
        claims.put("userImage", userDataResponse.getUserImagePath());

        return Jwts.builder()
                .setClaims(claims)
                .setSubject(userDataResponse.getUserName())
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .signWith(key)
                .compact();
    }


    public static Claims validateToken(String token) {
        try {
            return Jwts.parserBuilder()
                    .setSigningKey(key)
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        } catch (JwtException e) {
            return null;
        }
    }

    public static Map<String, Object> decodeToken(String token) {
        try {
            Claims claims = Jwts.parserBuilder()
                    .setSigningKey(key)
                    .build()
                    .parseClaimsJws(token)
                    .getBody();

            Map<String, Object> userDetails = new HashMap<>();
            userDetails.put("userId", claims.get("userId"));
            userDetails.put("email", claims.get("email"));
            userDetails.put("firstName", claims.get("firstName"));
            userDetails.put("lastName", claims.get("lastName"));
            userDetails.put("role", claims.get("role"));
            userDetails.put("userImage", claims.get("userImage"));
            userDetails.put("username", claims.getSubject());

            return userDetails;
        } catch (JwtException e) {
            return null;
        }
    }
}

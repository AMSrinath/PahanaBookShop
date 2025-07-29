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
import java.util.Objects;

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
}

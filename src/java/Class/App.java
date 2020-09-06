package Class;

import com.google.gson.Gson;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ianso
 */
public class App {
    
    // enumeraciones
    public enum Rol {
        
        ADMINISTRADOR (1),
        ANONIMO (2),
        NORMAL (3),
        MODERADOR (4),
        CREADOR (5),
        EDITOR (6)
        ;
        
        private final int ID;
        
        private Rol(int id) {
            
            ID = id;
        }
        
        public int getCode() {
            
            return ID;
        }
    }
    
    // metodos
    public static void returnJsonError(HttpServletResponse response, String error) throws IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(400);
        response.getWriter().write(new Gson().toJson(error));
    }
    
    public static void returnJsonSuccess(HttpServletResponse response, Object contenido) throws IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(200);
        response.getWriter().write(new Gson().toJson(contenido));
    }
}

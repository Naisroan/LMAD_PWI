package Class;

import DAO.UsuarioDAO;
import DAO.ValoracionDAO;
import Model.Noticia;
import Model.Usuario;
import Model.Valoracion;
import com.google.gson.Gson;
import java.io.IOException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
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
    
    public final static String NAME_ERROR_MESSAGE = "MSG_ERROR";
    public final static String NAME_SUCCESS_MESSAGE = "MSG_SUCCESS";
    public final static String PATH_USERS_IMAGES = "res/assets/users/images";
    public final static String PATH_NEWS_IMAGES = "res/assets/news/images";
    
    // metodos
    public static Usuario AuthUser(HttpServletRequest request) {
        
        try {
        
            Object attribute = request.getSession().getAttribute("usuario_logeado");
            if (attribute == null) {

                Cookie[] cookies = null;
                cookies = request.getCookies();

                if(cookies != null) {

                    for (int i = 0; i < cookies.length; i++) {

                        Cookie cookie = cookies[i];

                        if(cookie.getName() == "mantener_sesion") {

                            Usuario usuario = UsuarioDAO.ReadByNick(String.valueOf(cookie.getValue()));

                            if (usuario != null) {
                                request.getSession(true).setAttribute("usuario_logeado", usuario);
                            }

                            return usuario;
                        }
                     }
                }

                return null;
            }
            
            return (Usuario)attribute;
            
        } catch (Exception ex) {
            return null;
        }
    }
    
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
    
    public static void returnErrorMessage(String redirect, String message,
            HttpServletRequest request, HttpServletResponse response, ServletContext sc) 
            throws ServletException, IOException {
        request.setAttribute(NAME_ERROR_MESSAGE, message);
        sc.getRequestDispatcher(redirect).forward(request, response);
    }
    
    public static void returnErrorMessage(String redirect, String message,
            HttpServletRequest request, HttpServletResponse response, ServletContext sc, String attributeName) 
            throws ServletException, IOException {
        request.setAttribute(attributeName, message);
        sc.getRequestDispatcher(redirect).forward(request, response);
    }
    
    public static void returnSuccessMessage(String redirect, String message,
            HttpServletRequest request, HttpServletResponse response, ServletContext sc) 
            throws ServletException, IOException {
        request.setAttribute(NAME_SUCCESS_MESSAGE, message);
        sc.getRequestDispatcher(redirect).forward(request, response);
    }
    
    public static void returnSuccessMessage(String redirect, String message,
            HttpServletRequest request, HttpServletResponse response, ServletContext sc, String attributeName) 
            throws ServletException, IOException {
        request.setAttribute(attributeName, message);
        sc.getRequestDispatcher(redirect).forward(request, response);
    }
    
    public static void redirectSuccessMessage(String redirect, String message,
            HttpServletRequest request, HttpServletResponse response, ServletContext sc) 
            throws ServletException, IOException {
        request.setAttribute(NAME_SUCCESS_MESSAGE, message);
        response.sendRedirect(redirect);
    }
    
    public static Boolean isNumber(Object value) {
        try {
            Integer.parseInt(String.valueOf(value));
            return true;
        } catch(NumberFormatException ex) {
            return false;
        }
    }
    
    public static Boolean canSaveNoticia(HttpServletRequest request) {
        
        Usuario usuario = AuthUser(request);
        
        if (usuario != null) {
            return true;
        }
        
        // si el usuario no es admin, creados ni editor, no puede editar una noticia ni crearla
        if (usuario.getId_rol() == App.Rol.ADMINISTRADOR.getCode() ||
            usuario.getId_rol() == App.Rol.CREADOR.getCode() || 
            usuario.getId_rol() == App.Rol.EDITOR.getCode()) {

           return true;
        }
        
        return false;
    }
    
    public static Boolean esNoticiaAceptada(Noticia noticia) {
        
        if (noticia.getAprobada()) {
            return true;
        }
        
        if (noticia.getComentario_aprobacion() == null) {
            return false;
        }
        
        if (noticia.getComentario_aprobacion().equals("Noticia aprobada")) {
            return true;
        }
        
        return false;
    }
    
    public static Boolean esNoticiaRechazada(Noticia noticia) {
        
        if(esNoticiaPendienteAprobar(noticia)) {
            return false;
        }
        
        if (!noticia.getAprobada()) {
            return true;
        }
        
        if (noticia.getComentario_aprobacion() != null) {
            
            if (noticia.getComentario_aprobacion().equals("Noticia aprobada")) {
                return false;
            }
        }
        
        return true;
    }
    
    public static Boolean esNoticiaPendienteAprobar(Noticia noticia) {
        
        if (noticia.getComentario_aprobacion() == null) {
            return true;
        }
        
        if (noticia.getComentario_aprobacion().equals("")) {
            return true;
        }
        
        return false;
    }
    
    public static Boolean esNoticiaFavorita(Noticia noticia, Usuario usuario) throws Exception {
        
        try {

            if (noticia == null || usuario == null) {
                return false;
            }

            String strIdNoticia = String.valueOf(noticia.getId_noticia());
            String strIdUsuario = String.valueOf(usuario.getId_usuario());

            Valoracion val = ValoracionDAO.ReadByIdUsuarioIdNoticia(strIdUsuario, strIdNoticia);

            return val.isFavorito_noticia();
        
        } catch (Exception ex) {
            return false;
        }
    }
    
    public static String getExtension(String contentType) {
        switch (contentType) {
            case "image/png":
                return ".png";
            case "image/jpeg":
                return ".jpg";
            case "video/mp4":
                return ".mp4";
        }
        return ".ext";
    }
    
    public static Boolean isImage(String ruta) {
        return ruta.contains(".jpg") || ruta.contains(".jpeg") || ruta.contains(".png");
    }
}

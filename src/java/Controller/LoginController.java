package Controller;

import Class.App;
import DAO.UsuarioDAO;
import Model.Usuario;
import com.google.gson.Gson;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ianso
 */
@WebServlet("/GetUsuario")
public class LoginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        
        try {
         
            String strUsuario = request.getParameter("nick");
            String strPassword = request.getParameter("password");
            Boolean esAnonimo = Boolean.parseBoolean(request.getParameter("esAnonimo"));
            Boolean mantenerSesion = Boolean.parseBoolean(request.getParameter("mantener_sesion"));
            
            Usuario usuario = null;
            
            if (!esAnonimo) {
                
                usuario = UsuarioDAO.ReadByNick(strUsuario);
                
                // se valida que el usuario exista, y que la contraseña coincida
                if (usuario == null || !usuario.getPass().equals(strPassword)) {

                    // si no es asi, manda una cadena vacia
                    App.returnJsonSuccess(response, "");
                    return;
                }
                
                if (usuario.getNick().contains("_AN")) {
                    App.returnJsonError(response, "El usuario es anónimo, haga click en el botón Modo Anónimo");
                    return;
                }
            
            } else {
            
                usuario = UsuarioDAO.ReadByNick(strUsuario);
                
                if (usuario != null) {

                    App.returnJsonError(response, "Ingrese otro nombre de usuario anónimo");
                    return;
                }
            
                usuario = UsuarioDAO.ReadByNick(strUsuario + "_AN");
                
                if (usuario == null) {
                    
                    // creamos el usuario nuevo
                    usuario = new Usuario();

                    usuario.setNick(strUsuario + "_AN");
                    usuario.setId_rol(App.Rol.ANONIMO.getCode());
                    usuario.setCorreo("anonimo@fake.com");
                    usuario.setPass("");
                    usuario.setRuta_imagen("");

                    if (!UsuarioDAO.Create(usuario)) {

                        App.returnJsonError(response, "El usuario no ha sido creado por alguna razón");
                        return;
                    }
                }
            }
            
            request.getSession(true).setAttribute("usuario_logeado", usuario);
            
            if (mantenerSesion)
            {
                Cookie cookMantenerSesion = new Cookie("mantener_sesion", String.valueOf(usuario.getId_usuario()));
                
                int segundosExpiracion = 60 * 60 * 1; // 1 -> 1 hora
                
                cookMantenerSesion.setMaxAge(segundosExpiracion);
                
                response.addCookie(cookMantenerSesion);
            }
            
            // si encontro una coincidencia de usuario y contraseña, retorna el usuario
            App.returnJsonSuccess(response, usuario);
            
            // response.sendRedirect(request.getContextPath() + "/app/home.jsp");
        }
        catch (Exception ex) {
            
            App.returnJsonError(response, ex.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

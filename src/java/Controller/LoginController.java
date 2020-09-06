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
            
            Usuario usuario = UsuarioDAO.ReadByNick(strUsuario);
            
            // se valida que el usuario exista, y que la contraseña coincida
            if (usuario == null || !usuario.getPass().equals(strPassword)) {
                
                // si no es asi, manda una cadena vacia
                App.returnJsonSuccess(response, "");
                return;
            }
            
            // si encontro una coincidencia de usuario y contraseña, retorna el usuario
            App.returnJsonSuccess(response, usuario);
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

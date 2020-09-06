package Controller;

import Class.App;
import DAO.UsuarioDAO;
import Model.Usuario;
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
@WebServlet("/RegistrarUsuario")
public class RegisterController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        
        String strCorreo = request.getParameter("correo");
        String strUsuario = request.getParameter("nick");
        String strPassword = request.getParameter("password");
        
        try {
            
            // validamos que no existe ya un usuario igual
            if (UsuarioDAO.ReadByNick(strUsuario) != null) {
                
                App.returnJsonError(response, "El usuario " + strUsuario + " ya existe, ingrese otro diferente");
                return;
            }
            
            // validamos que no existe ya un correo igual
            if (UsuarioDAO.ReadByCorreo(strCorreo) != null) {
                
                App.returnJsonError(response, "El correo " + strCorreo + " ya existe, ingrese otro diferente");
                return;
            }
        
            // creamos el usuario nuevo
            Usuario usuario = new Usuario();

            usuario.setCorreo(strCorreo);
            usuario.setNick(strUsuario);
            usuario.setPass(strPassword);
            usuario.setRuta_imagen("");
            usuario.setId_rol(App.Rol.NORMAL.getCode());
            
            if (!UsuarioDAO.Create(usuario)) {
                
                App.returnJsonError(response, "El usuario no ha sido creado por alguna razón");
                return;
                
            } else {
                
                App.returnJsonSuccess(response, usuario);
                return;   
            }
            
        } catch (Exception ex) {
            
            App.returnJsonError(response, ex.getMessage());
            return;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(RegisterController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(RegisterController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

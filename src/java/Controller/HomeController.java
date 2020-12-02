/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Class.App;
import DAO.MultimediaDAO;
import DAO.UsuarioDAO;
import Model.Multimedia;
import Model.Usuario;
import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author ianso
 */
@WebServlet(urlPatterns = {"/Home", "/Logout", "/ChangeAvatar"})
@MultipartConfig(maxFileSize = 1024 * 1024 * 100, maxRequestSize = 1024 * 1024 * 150)
public class HomeController extends HttpServlet {
    
    private static final String SERLVET_HOME = "/Home";
    private static final String SERLVET_LOGOUT = "/Logout";
    private static final String SERLVET_CHANGEAVATAR = "/ChangeAvatar";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        
        ServletContext sc = getServletContext();
        String contextPath = request.getContextPath();
        String servletPath = request.getServletPath();
        request.setCharacterEncoding("UTF-8");
        
        switch (servletPath)
        {
            case SERLVET_HOME:
            {
                response.sendRedirect(contextPath + "/app/home.jsp");
                break;
            }
            
            case SERLVET_LOGOUT:
            {
                request.getSession().invalidate();
                response.sendRedirect(contextPath + "/login.jsp");
                break;
            }
            
            case SERLVET_CHANGEAVATAR:
            {
                String redirect = "/app/home.jsp";
                Usuario nodo = App.AuthUser(request);
                
                if (nodo == null) {
                    App.returnErrorMessage(redirect, "No se pudo obtener el usuario autenticado", request, response, sc);
                    return;
                }

                Part file = request.getPart("fuAvatar");
                String path = request.getServletContext().getRealPath("");
                File fileSaveDir = new File(path + App.PATH_USERS_IMAGES);

                if (!fileSaveDir.exists()) {
                    fileSaveDir.mkdirs();
                }

                String contentType = file.getContentType();
                String nameImage = file.getName() + System.currentTimeMillis() + App.getExtension(contentType);
                String fullPath = path + App.PATH_USERS_IMAGES + "/" + nameImage;
                String serverPath = "/" + App.PATH_USERS_IMAGES + "/" + nameImage;

                File multimediaFile = new File(fullPath);

                if(multimediaFile.exists()) { 
                    multimediaFile.delete();
                }

                file.write(fullPath);

                String rutaAvatarAntigua = nodo.getRuta_imagen();
                nodo.setRuta_imagen(serverPath);

                if (!UsuarioDAO.Update(nodo)) {
                    App.returnErrorMessage(redirect, "No se pudo adjuntar el avatar alguna razón", request, response, sc);
                    return;
                }
                
                if (rutaAvatarAntigua != null && !String.valueOf(rutaAvatarAntigua).equals("")) {
                    
                    String serverRealPath = request.getServletContext().getRealPath("");
                    
                    File avatarAntiguo = new File(serverRealPath + rutaAvatarAntigua);
                    if (avatarAntiguo.exists()) {
                        avatarAntiguo.delete();
                    }
                } 

                response.sendRedirect(contextPath + "/app/home.jsp");
                
                break;
            }
            
            default:
            {
                response.sendRedirect(contextPath + "/app/home.jsp");
                break;
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(HomeController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(HomeController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

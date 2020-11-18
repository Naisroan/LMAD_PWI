/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ianso
 */
@WebServlet(urlPatterns = {"/Home", "/Logout"})
public class HomeController extends HttpServlet {
    
    private static final String SERLVET_HOME = "/Home";
    private static final String SERLVET_LOGOUT = "/Logout";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // request.getRequestDispatcher("/app/home.jsp").forward(request, response);
        String contextPath = request.getContextPath();
        String servletPath = request.getServletPath();
        
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
        processRequest(request, response);
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
        processRequest(request, response);
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

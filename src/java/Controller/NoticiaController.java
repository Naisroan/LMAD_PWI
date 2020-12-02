package Controller;

import Class.App;
import DAO.CategoriasDAO;
import DAO.MultimediaDAO;
import DAO.NoticiaDAO;
import DAO.ComentarioDAO;
import DAO.ValoracionDAO;
import Model.Categorias;
import Model.Multimedia;
import Model.Noticia;
import Model.Usuario;
import Model.Comentario;
import Model.Valoracion;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
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
@WebServlet(urlPatterns = {"/noticia/save", "/noticia/aprobar", "/noticia/comentario", "/noticia/comentario/like", "/noticia/favorito"})
@MultipartConfig(maxFileSize = 1024 * 1024 * 100, maxRequestSize = 1024 * 1024 * 150)
public class NoticiaController extends HttpServlet {
    
    private static final String SERLVET_PRINCIPAL = "/noticia";
    private static final String SERLVET_SAVE = SERLVET_PRINCIPAL + "/save";
    private static final String SERLVET_APROBAR = SERLVET_PRINCIPAL + "/aprobar";
    private static final String SERLVET_COMENTARIO = SERLVET_PRINCIPAL + "/comentario";
    private static final String SERLVET_COMENTARIO_LIKE = SERLVET_PRINCIPAL + "/comentario/like";
    private static final String SERLVET_FAVORITO = SERLVET_PRINCIPAL + "/favorito";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        
        request.setCharacterEncoding("UTF-8");
        ServletContext sc = getServletContext();
        String contextPath = request.getContextPath();
        String servletPath = request.getServletPath();

        switch (servletPath) {

            case SERLVET_SAVE: {

                String strBtnGuardar = request.getParameter("btnGuardar");
                String strBtnEliminar = request.getParameter("btnEliminar");
                String strBtnSubir = request.getParameter("btnSubir");
                
                if (strBtnGuardar != null) {
                    
                    Save(request, response, sc, contextPath, servletPath);
                    
                } else if (strBtnSubir != null) {
                    
                    Upload(request, response, sc, contextPath, servletPath);
                    
                } else if (strBtnEliminar != null) {
                    
                    Delete(request, response, sc, contextPath, servletPath);
                    
                }else {
                    
                    response.sendRedirect(contextPath + "/app/home.jsp");
                }
                
                break;
            }

            case SERLVET_APROBAR: {

                Aprobar(request, response, sc, contextPath, servletPath);
                
                break;
            }

            case SERLVET_COMENTARIO: {

                Comentario(request, response, sc, contextPath, servletPath);
                
                break;
            }

            case SERLVET_COMENTARIO_LIKE: {

                ComentarioLike(request, response, sc, contextPath, servletPath);
                
                break;
            }

            case SERLVET_FAVORITO: {

                MarcarFavorita(request, response, sc, contextPath, servletPath);
                
                break;
            }

            default: {
                response.sendRedirect(contextPath + "/app/home.jsp");
                break;
            }
        }
    }
    
    protected void Save(HttpServletRequest request, HttpServletResponse response, ServletContext sc, String contextPath, String servletPath)
        throws ServletException, IOException, Exception {
        
        String redirect = "/app/notice_detail.jsp";
            
        try  {
            
            Usuario usuario = App.AuthUser(request);

            if (usuario == null) {
                App.returnErrorMessage(redirect, "Usuario no autenticado", request, response, sc);
                return;
            }

            if (!CamposValidosSave(request, response, redirect)) {
                return;
            }

            String strCategoria = String.valueOf(request.getParameter("nodo_categoria"));
            Categorias cat = CategoriasDAO.Read(strCategoria);

            if (cat == null) {
                App.returnErrorMessage(redirect, "La categoría seleccionada no existe", request, response, sc);
                return;
            }

            Object attribute = request.getParameter("id");
            Noticia nodo = null;

            // si es null, es nuevo, de lo contrario, es una modificación
            if (!App.isNumber(attribute)) {

                nodo = new Noticia();
                nodo.setTitulo(String.valueOf(request.getParameter("nodo_titulo")));
                nodo.setDesc_corta(String.valueOf(request.getParameter("nodo_descripcion")));
                nodo.setNoticia(String.valueOf(request.getParameter("nodo_noticia")));
                nodo.setId_categoria(cat.getId_categoria());
                nodo.setId_usuario(usuario.getId_usuario());

                nodo = NoticiaDAO.Create(nodo);
                
                if (nodo == null) {
                    App.returnErrorMessage(redirect, "No se pudo crear la noticia por alguna razón", request, response, sc);
                    return;
                }

            } else {
                
                nodo = NoticiaDAO.Read(String.valueOf(attribute));
                
                if (nodo == null) {
                    App.returnErrorMessage(redirect, "No se pudo crear la noticia por alguna razón", request, response, sc);
                    return;
                }
                
                nodo.setTitulo(String.valueOf(request.getParameter("nodo_titulo")));
                nodo.setDesc_corta(String.valueOf(request.getParameter("nodo_descripcion")));
                nodo.setNoticia(String.valueOf(request.getParameter("nodo_noticia")));
                nodo.setId_categoria(cat.getId_categoria());

                if (!NoticiaDAO.Update(nodo)) {
                    App.returnErrorMessage(redirect, "No se pudo actualizar la noticia por alguna razón", request, response, sc);
                    return;
                }
            }

            String strParameter = "?id=" + nodo.getId_noticia();
            App.returnSuccessMessage(redirect + strParameter, "Noticia guardada", request, response, sc);
        
        } catch (Exception ex) {
            App.returnErrorMessage(redirect, "Ha ocurrido un error: " + ex.getMessage(), request, response, sc);
            return;
        }
    }
    
    protected Boolean CamposValidosSave(HttpServletRequest request, HttpServletResponse response, String redirect) 
        throws ServletException, IOException, Exception {
        
        if (request.getParameter("nodo_titulo") == null) {
            App.returnErrorMessage(redirect, "Ingrese el titulo", request, response, getServletContext());
            return false;
        }
        
        if (request.getParameter("nodo_descripcion") == null) {
            App.returnErrorMessage(redirect, "Ingrese la descripción", request, response, getServletContext());
            return false;
        }
        
        if (request.getParameter("nodo_noticia") == null) {
            App.returnErrorMessage(redirect, "Ingrese la noticia", request, response, getServletContext());
            return false;
        }
        
        if (request.getParameter("nodo_categoria") == null) {
            App.returnErrorMessage(redirect, "Seleccione la categoría", request, response, getServletContext());
            return false;
        }
        
        return true;
    }
        
    protected void Upload(HttpServletRequest request, HttpServletResponse response, ServletContext sc, String contextPath, String servletPath)
        throws ServletException, IOException, Exception {
        
        String redirect = "/app/notice_detail.jsp";
        Object attribute = request.getParameter("id");
        Noticia nodo = null;
                
        nodo = NoticiaDAO.Read(String.valueOf(attribute));

        if (nodo == null) {
            App.returnErrorMessage(redirect, "No se pudo obtener la noticia", request, response, sc);
            return;
        }
        
        Part file = request.getPart("fuMultimedia");
        String path = request.getServletContext().getRealPath("");
        File fileSaveDir = new File(path + App.PATH_NEWS_IMAGES);
        
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }
        
        String contentType = file.getContentType();
        String nameImage = file.getName() + System.currentTimeMillis() + App.getExtension(contentType);
        String fullPath = path + App.PATH_NEWS_IMAGES + "/" + nameImage;
        String serverPath = "/" + App.PATH_NEWS_IMAGES + "/" + nameImage; // /LMAD_PWI/res/assets/news/images/fuMultimedia1606728023157.jpg
        
        File multimediaFile = new File(fullPath);
        
        if(multimediaFile.exists()) { 
            multimediaFile.delete();
        }
        
        file.write(fullPath);

        Multimedia multimedia = new Multimedia();
        multimedia.setId_noticia(nodo.getId_noticia());
        multimedia.setRuta(serverPath);
        multimedia.setTipo_contenido(contentType);
        
        if (!MultimediaDAO.Create(multimedia)) {
            App.returnErrorMessage(redirect, "No se pudo adjuntar la multimedia por alguna razón", request, response, sc);
            return;
        }

        String strParameter = "?id=" + nodo.getId_noticia();
        App.returnSuccessMessage(redirect + strParameter, "Multimedia adjuntada", request, response, sc);
    }
    
    protected void Delete(HttpServletRequest request, HttpServletResponse response, ServletContext sc, String contextPath, String servletPath)
        throws ServletException, IOException, Exception {
        
        String redirect = "/app/notice_detail.jsp";
            
        try  {
            
            Usuario usuario = App.AuthUser(request);

            if (usuario == null) {
                App.returnErrorMessage(redirect, "Usuario no autenticado", request, response, sc);
                return;
            }

            Object attribute = request.getParameter("id");
            Noticia nodo = null;

            if (!App.isNumber(attribute)) {
                App.returnErrorMessage(redirect, "No se pudo obtener la noticia", request, response, sc);
                return;
            }
                
            nodo = NoticiaDAO.Read(String.valueOf(attribute));

            if (nodo == null) {
                App.returnErrorMessage(redirect, "No se pudo obtener la noticia", request, response, sc);
                return;
            }
            
            List<Multimedia> multimedias = MultimediaDAO.ReadByIdNoticia(String.valueOf(nodo.getId_noticia())); 
            String serverPath = request.getServletContext().getRealPath("");
            
            for (Multimedia multimedia : multimedias) {
                String rutaArchivo = serverPath + multimedia.getRuta();
                File archivo = new File(rutaArchivo);
                if (archivo.exists()) {
                    archivo.delete();
                }
            }

            if (!NoticiaDAO.Delete(String.valueOf(nodo.getId_noticia()))) {
                App.returnErrorMessage(redirect, "No se pudo eliminar la noticia por alguna razón", request, response, sc);
                return;
            }

            String strParameter = "";
            App.returnSuccessMessage(redirect + strParameter, "Noticia borrada con éxito", request, response, sc);
        
        } catch (Exception ex) {
            App.returnErrorMessage(redirect, "Ha ocurrido un error: " + ex.getMessage(), request, response, sc);
            return;
        }
    }
    
    protected void Aprobar(HttpServletRequest request, HttpServletResponse response, ServletContext sc, String contextPath, String servletPath)
        throws ServletException, IOException, Exception {
        
        String redirect = "/app/show_notice.jsp";
            
        try  {
            
            Usuario usuario = App.AuthUser(request);

            if (usuario == null) {
                App.returnErrorMessage(redirect, "Usuario no autenticado", request, response, sc);
                return;
            }

            Object attribute = request.getParameter("id");
            Noticia nodo = null;

            if (!App.isNumber(attribute)) {
                App.returnErrorMessage(redirect, "No se pudo obtener la noticia", request, response, sc);
                return;
            }
                
            nodo = NoticiaDAO.Read(String.valueOf(attribute));

            if (nodo == null) {
                App.returnErrorMessage(redirect, "No se pudo obtener la noticia", request, response, sc);
                return;
            }
            
            String strBtnAprobar = request.getParameter("btnAprobar");
            String strBtnRechazar = request.getParameter("btnRechazar");
            String strComentarioAprobatorio = request.getParameter("comentario_aprobacion");
            Boolean aprobar = strBtnAprobar != null;
            
            if (!aprobar && (strComentarioAprobatorio == null || strComentarioAprobatorio == "")){
                App.returnErrorMessage(redirect, "Ingrese un comentario del porque rechazará la noticia", request, response, sc);
                return;
            }
            
            if (!aprobar && strComentarioAprobatorio.equals("Noticia aprobada")) {
                App.returnErrorMessage(redirect, "Ingrese un comentario diferente", request, response, sc);
                return;
            }
            
            strComentarioAprobatorio = aprobar ? "Noticia aprobada" : strComentarioAprobatorio;
                    
            if (!NoticiaDAO.Aprobar(nodo, aprobar, strComentarioAprobatorio)) {
                App.returnErrorMessage(redirect, "No se pudo actualizar la noticia por alguna razón", request, response, sc);
                return;
            }

            String strParameter = "?id=" + nodo.getId_noticia();
            App.returnSuccessMessage(redirect + strParameter, aprobar ? "Noticia aprobada" : "Noticia rechazada", request, response, sc);
        
        } catch (Exception ex) {
            App.returnErrorMessage(redirect, "Ha ocurrido un error: " + ex.getMessage(), request, response, sc);
            return;
        }
    }
    
    protected void Comentario(HttpServletRequest request, HttpServletResponse response, ServletContext sc, String contextPath, String servletPath)
        throws ServletException, IOException, Exception {
        
        String redirect = "/app/show_notice.jsp";
            
        try  {
            
            Usuario usuario = App.AuthUser(request);

            if (usuario == null) {
                App.returnErrorMessage(redirect, "Usuario no autenticado", request, response, sc);
                return;
            }

            Object attribute = request.getParameter("id");
            Noticia nodo = null;

            if (!App.isNumber(attribute)) {
                App.returnErrorMessage(redirect, "No se pudo obtener la noticia", request, response, sc, "MSG_ERROR_COMENTARIO");
                return;
            }
                
            nodo = NoticiaDAO.Read(String.valueOf(attribute));

            if (nodo == null) {
                App.returnErrorMessage(redirect, "No se pudo obtener la noticia", request, response, sc, "MSG_ERROR_COMENTARIO");
                return;
            }
            
            String strComentario = request.getParameter("nuevo_comentario");
            
            if (strComentario == null || String.valueOf(strComentario).equals("")) {
                
                App.returnErrorMessage(redirect, "Ingrese el comentario", request, response, sc, "MSG_ERROR_COMENTARIO");
                return;
            }
            
            String strIdComentarioPadre = request.getParameter("idComentarioPadre");
            Comentario com = new Comentario();
            
            com.setId_noticia(nodo.getId_noticia());
            com.setId_usuario(usuario.getId_usuario());
            com.setDescripcion(strComentario);
            com.setId_comentario_padre(Integer.parseInt(strIdComentarioPadre));
                
            if (!ComentarioDAO.Create(com)) {
                
                App.returnErrorMessage(redirect, "El comentario no se creo por alguna razón", request, response, sc, "MSG_ERROR_COMENTARIO");
                return;
            }

            String strParameter = "?id=" + nodo.getId_noticia();
            App.returnSuccessMessage(redirect + strParameter, "Comentario agregado", request, response, sc, "MSG_SUCCESS_COMENTARIO");
        
        } catch (Exception ex) {
            App.returnErrorMessage(redirect, "Ha ocurrido un error: " + ex.getMessage(), request, response, sc, "MSG_ERROR_COMENTARIO");
            return;
        }
    }
    
    protected void ComentarioLike(HttpServletRequest request, HttpServletResponse response, ServletContext sc, String contextPath, String servletPath)
        throws ServletException, IOException, Exception {
        
        String redirect = "/app/show_notice.jsp";
            
        try  {
            
            Usuario usuario = App.AuthUser(request);

            if (usuario == null) {
                App.returnErrorMessage(redirect, "Usuario no autenticado", request, response, sc);
                return;
            }

            Object attribute = request.getParameter("id");
            Noticia nodo = null;

            if (!App.isNumber(attribute)) {
                App.returnErrorMessage(redirect, "No se pudo obtener la noticia", request, response, sc, "MSG_ERROR_COMENTARIO");
                return;
            }
                
            nodo = NoticiaDAO.Read(String.valueOf(attribute));

            if (nodo == null) {
                App.returnErrorMessage(redirect, "No se pudo obtener la noticia", request, response, sc, "MSG_ERROR_COMENTARIO");
                return;
            }
            
            String strLike = request.getParameter("like");
            String strIdComentario = request.getParameter("idComentario");
            
            if (strLike == null || String.valueOf(strLike).equals("")) {
                
                App.returnErrorMessage(redirect, "De me gusta o no me gusta al comentario", request, response, sc, "MSG_ERROR_COMENTARIO");
                return;
            }
            
            if (strIdComentario == null || String.valueOf(strIdComentario).equals("")) {
                
                App.returnErrorMessage(redirect, "No se pudo obtener el comentario", request, response, sc, "MSG_ERROR_COMENTARIO");
                return;
            }
            
            Boolean like = Boolean.parseBoolean(strLike);
            int idComentario = Integer.parseInt(strIdComentario);
            
            Valoracion val = new Valoracion();
            
            val.setId_usuario(usuario.getId_usuario());
            val.setId_comentario(idComentario);
            val.setId_noticia(nodo.getId_noticia());
            val.setValoracion_comentario(like);
            val.setTipo_valoracion(2);
            
            Valoracion valDuplicada = ValoracionDAO.ReadByIdUsuarioIdComentario(String.valueOf(usuario.getId_usuario()), strIdComentario);
            
            if (valDuplicada != null) {
                
                val.setId_valoracion(valDuplicada.getId_valoracion());
                
                if (!ValoracionDAO.Update(val)) {

                    App.returnErrorMessage(redirect, "El voto no se actualizo por alguna razón", request, response, sc, "MSG_ERROR_COMENTARIO");
                    return;
                }
                
            } else {
                
                val.setFavorito_noticia(false);
                val.setValoracion_noticia(0);
                
                if (!ValoracionDAO.Create(val)) {

                    App.returnErrorMessage(redirect, "El voto no se creo por alguna razón", request, response, sc, "MSG_ERROR_COMENTARIO");
                    return;
                }
            }

            String strParameter = "?id=" + nodo.getId_noticia();
            App.returnSuccessMessage(redirect + strParameter, "Comentario votado", request, response, sc, "MSG_SUCCESS_COMENTARIO");
        
        } catch (Exception ex) {
            App.returnErrorMessage(redirect, "Ha ocurrido un error: " + ex.getMessage(), request, response, sc, "MSG_ERROR_COMENTARIO");
            return;
        }
    }
    
    protected void MarcarFavorita(HttpServletRequest request, HttpServletResponse response, ServletContext sc, String contextPath, String servletPath)
        throws ServletException, IOException, Exception {
        
        String redirect = "/app/show_notice.jsp";
            
        try  {
            
            Usuario usuario = App.AuthUser(request);

            if (usuario == null) {
                App.returnErrorMessage(redirect, "Usuario no autenticado", request, response, sc);
                return;
            }

            Object attribute = request.getParameter("id");
            Noticia nodo = null;

            if (!App.isNumber(attribute)) {
                App.returnErrorMessage(redirect, "No se pudo obtener la noticia", request, response, sc, "MSG_ERROR_COMENTARIO");
                return;
            }
                
            nodo = NoticiaDAO.Read(String.valueOf(attribute));

            if (nodo == null) {
                App.returnErrorMessage(redirect, "No se pudo obtener la noticia", request, response, sc, "MSG_ERROR_COMENTARIO");
                return;
            }
            
            String strFavorito = request.getParameter("favorito");
            
            if (strFavorito == null || String.valueOf(strFavorito).equals("")) {
                
                App.returnErrorMessage(redirect, "De favorito o no a la noticia", request, response, sc, "MSG_ERROR_COMENTARIO");
                return;
            }
            
            Boolean favorita = Boolean.parseBoolean(strFavorito);
            
            Valoracion val = new Valoracion();
            
            val.setId_usuario(usuario.getId_usuario());
            val.setId_noticia(nodo.getId_noticia());
            val.setFavorito_noticia(favorita);
            val.setTipo_valoracion(1);
            val.setId_comentario(0);
            val.setValoracion_comentario(false);
            val.setValoracion_noticia(0);
            
            Valoracion valDuplicada = ValoracionDAO.ReadByIdUsuarioIdNoticia(String.valueOf(usuario.getId_usuario()), String.valueOf(nodo.getId_noticia()));
            
            if (valDuplicada != null) {
                
                val.setId_valoracion(valDuplicada.getId_valoracion());
                
                if (!ValoracionDAO.Update(val)) {

                    App.returnErrorMessage(redirect, "El favorito no se actualizo por alguna razón", request, response, sc, "MSG_ERROR_COMENTARIO");
                    return;
                }
                
            } else {
                
                if (!ValoracionDAO.Create(val)) {

                    App.returnErrorMessage(redirect, "El favorito no se creo por alguna razón", request, response, sc, "MSG_ERROR_COMENTARIO");
                    return;
                }
            }

            String strParameter = "?id=" + nodo.getId_noticia();
            App.returnSuccessMessage(redirect + strParameter, "Noticia marcada como favorita", request, response, sc, "MSG_SUCCESS_COMENTARIO");
        
        } catch (Exception ex) {
            App.returnErrorMessage(redirect, "Ha ocurrido un error: " + ex.getMessage(), request, response, sc, "MSG_ERROR_COMENTARIO");
            return;
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
            Logger.getLogger(NoticiaController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(NoticiaController.class.getName()).log(Level.SEVERE, null, ex);
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

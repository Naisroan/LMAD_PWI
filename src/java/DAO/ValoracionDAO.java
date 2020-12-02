/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Class.StoredProcedure;
import Model.Valoracion;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author fer_2
 */
public class ValoracionDAO {
    private static final String STR_SP_Create = "sp_valoracion_create";
    private static final String STR_SP_Delete = "sp_valoracion_delete";
    private static final String STR_SP_Update = "sp_valoracion_update";
    private static final String STR_SP_ReadByUsuarioComentario = "sp_valoracion_readByUsuarioComentario";
    private static final String STR_SP_ReadByUsuarioNoticia = "sp_valoracion_readByUsuarioNoticia";
    
    public static Boolean Create(Valoracion nodo) throws Exception {
        
        StoredProcedure sp = null;
    
        try{
            sp = new StoredProcedure(STR_SP_Create);
            
            sp.agregarParametro("p_id_noticia", nodo.getId_noticia());
            sp.agregarParametro("p_id_comentario", nodo.getId_comentario());
            sp.agregarParametro("p_id_usuario", nodo.getId_usuario());
            sp.agregarParametro("p_favorito_noticia", nodo.isFavorito_noticia());
            sp.agregarParametro("p_valoracion_noticia", nodo.getValoracion_noticia());
            sp.agregarParametro("p_valoracion_comentario", nodo.isValoracion_comentario());
            sp.agregarParametro("p_tipo_valoracion", nodo.getTipo_valoracion());
           
            return sp.insert();
        }
        catch(SQLException ex){
            throw ex;
        } finally {
            sp.close();
        }
    }
    
    public static Boolean Delete(String id) throws Exception{
        
        StoredProcedure sp = null;
    
        try{
            sp = new StoredProcedure(STR_SP_Delete);
            sp.agregarParametro("p_id_valoracion", Integer.parseInt(id));
            
            return sp.insert();
        }
        catch(SQLException ex){
            throw ex;
        }
    }
    
    public static Boolean Update(Valoracion nodo) throws Exception {
        
        StoredProcedure sp = null;
        
        try{
            sp = new StoredProcedure(STR_SP_Update);
            
            sp.agregarParametro("p_id_valoracion", nodo.getId_valoracion());
            sp.agregarParametro("p_id_noticia", nodo.getId_noticia());
            sp.agregarParametro("p_id_comentario", nodo.getId_comentario());
            sp.agregarParametro("p_id_usuario", nodo.getId_usuario());
            sp.agregarParametro("p_favorito_noticia", nodo.isFavorito_noticia());
            sp.agregarParametro("p_valoracion_noticia", nodo.getValoracion_noticia());
            sp.agregarParametro("p_valoracion_comentario", nodo.isValoracion_comentario());
            sp.agregarParametro("p_tipo_valoracion", nodo.getTipo_valoracion());
            
            return sp.insert();
        }
        catch(SQLException ex){
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static Valoracion ReadByIdUsuarioIdNoticia(String idUsuario, String idNoticia) throws Exception {
        
        StoredProcedure sp = null;
        
        try {
            
            sp = new StoredProcedure(STR_SP_ReadByUsuarioNoticia);
            sp.agregarParametro("p_id_usuario", Integer.parseInt(idUsuario));
            sp.agregarParametro("p_id_noticia", Integer.parseInt(idNoticia));
            
            ResultSet rs = sp.select();
            
            while (rs.next()) {
               
                return (Valoracion)Parse(rs);
            }
        
            return null;
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }
    
    public static Valoracion ReadByIdUsuarioIdComentario(String id, String idComentario) throws Exception {
        
        StoredProcedure sp = null;
        
        try {
            
            sp = new StoredProcedure(STR_SP_ReadByUsuarioComentario);
            sp.agregarParametro("p_id_usuario", Integer.parseInt(id));
            sp.agregarParametro("p_id_comentario", Integer.parseInt(idComentario));
            
            ResultSet rs = sp.select();
            
            while (rs.next()) {
               
                return (Valoracion)Parse(rs);
            }
        
            return null;
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static Valoracion Parse(ResultSet rs) throws SQLException {
        
        Valoracion nodo = new Valoracion();
        
        nodo.setId_valoracion(rs.getInt("id_valoracion"));
        nodo.setId_usuario(rs.getInt("id_usuario"));
        nodo.setId_comentario(rs.getInt("id_comentario"));
        nodo.setId_noticia(rs.getInt("id_noticia"));
        nodo.setFavorito_noticia(rs.getBoolean("favorito_noticia"));
        nodo.setValoracion_comentario(rs.getBoolean("valoracion_comentario"));
        nodo.setValoracion_noticia(rs.getInt("valoracion_noticia"));
        nodo.setFecha_hora(rs.getDate("fecha_hora"));
        nodo.setTipo_valoracion(rs.getInt("tipo_valoracion"));
        
        return nodo;
    }
    
}

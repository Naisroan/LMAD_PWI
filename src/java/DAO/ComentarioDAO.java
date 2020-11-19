/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Class.StoredProcedure;
import Model.Comentario;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author fer_2
 */
public class ComentarioDAO {
    private static final String STR_SP_Create = "sp_comentario_create";
    private static final String STR_SP_Delete = "sp_comentario_delete";
    private static final String STR_SP_ReadByNoticia = "sp_comentario_readBynoticia";
    private static final String STR_SP_ReadByComentarioPadre = "sp_comentario_readBycomentariopadre";
    
    
    public static Boolean Create(Comentario nodo) throws Exception{
    
        try{
            StoredProcedure sp = new StoredProcedure(STR_SP_Create);
            
            sp.agregarParametro("p_descripcion", nodo.getDescripcion());
            sp.agregarParametro("p_id_usuario", nodo.getId_usuario());
            sp.agregarParametro("p_id_noticia", nodo.getId_noticia());
            sp.agregarParametro("fecha_hora", nodo.getFecha_hora());
            
            return sp.insert();
        }
        catch(SQLException ex){
            throw ex;
        }
        
    }
    
    public static Boolean Delete(String id) throws Exception{
    
        try{
            StoredProcedure sp = new StoredProcedure(STR_SP_Delete);
            sp.agregarParametro("p_id_comentario", Integer.parseInt(id));
            
            return sp.insert();
        }
        catch(SQLException ex){
            throw ex;
        }
    }
    
    public static Comentario ReadByNoticia(String id) throws Exception{
    
        try{
            StoredProcedure sp = new StoredProcedure(STR_SP_ReadByNoticia);
            sp.agregarParametro("p_id_noticia", Integer.parseInt(id));
            
            ResultSet rs = sp.select();
            
            while(rs.next()){
                return (Comentario)Parse(rs);
            }
            return null;
        }
        catch(SQLException ex){
            throw ex;

        }
    }
    
    public static Comentario ReadByComentarioPadre(String id) throws Exception{
    
        try{
            StoredProcedure sp = new StoredProcedure(STR_SP_ReadByComentarioPadre);
            sp.agregarParametro("p_id_comentario_padre", Integer.parseInt(id));
            
            ResultSet rs = sp.select();
            
            while(rs.next()){
                return (Comentario)Parse(rs);
            }
            return null;
        }
        
        catch(SQLException ex){
            throw ex;
        }
        
        
    
    }
    
    public static Comentario Parse(ResultSet rs) throws SQLException{
        
        Comentario nodo = new Comentario();
        
        nodo.setId_comentario(rs.getInt("id_comentario"));
        nodo.setFecha_hora(rs.getDate("fecha_hora"));
        nodo.setDescripcion(rs.getString("descripcion"));
        nodo.setId_usuario(rs.getInt("id_usuario"));
        nodo.setId_noticia(rs.getInt("id_noticia"));
        nodo.setId_comentario_padre(rs.getInt("id_comentario_padre"));
        
        return nodo;
    }
    
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Class.StoredProcedure;
import Model.Valoracion;
import java.sql.SQLException;

/**
 *
 * @author fer_2
 */
public class ValoracionDAO {
    private static final String STR_SP_Create = "sp_valoracion_create";
    private static final String STR_SP_Delete = "sp_valoracion_delete";
    private static final String STR_SP_Update = "sp_valoracion_update";
    
    public static Boolean Create(Valoracion nodo) throws Exception {
    
        try{
            StoredProcedure sp = new StoredProcedure(STR_SP_Create);
            
            sp.agregarParametro("p_id_noticia", nodo.getId_noticia());
            sp.agregarParametro("p_id_comentario", nodo.getId_comentario());
            sp.agregarParametro("p_id_usuario", nodo.getId_usuario());
            sp.agregarParametro("p_favorito_noticia", nodo.isFavorito_noticia());
            sp.agregarParametro("p_valoracion_noticia", nodo.getValoracion_noticia());
            sp.agregarParametro("p_valoracion_comentario", nodo.isValoracion_comentario());
            sp.agregarParametro("p_fecha_hora", nodo.getFecha_hora());
           
            return sp.insert();
        }
        catch(SQLException ex){
            throw ex;
        }
    }
    
    public static Boolean Delete(String id) throws Exception{
    
        try{
            StoredProcedure sp = new StoredProcedure(STR_SP_Delete);
            sp.agregarParametro("p_id_valoracion", Integer.parseInt(id));
            
            return sp.insert();
        }
        catch(SQLException ex){
            throw ex;
        }
    }
    
    public static Boolean Update(Valoracion nodo) throws Exception {
        
        try{
            StoredProcedure sp = new StoredProcedure(STR_SP_Update);
            
            sp.agregarParametro("p_id_valoracion", nodo.getId_valoracion());
            sp.agregarParametro("p_id_noticia", nodo.getId_noticia());
            sp.agregarParametro("p_id_comentario", nodo.getId_comentario());
            sp.agregarParametro("p_id_usuario", nodo.getId_usuario());
            sp.agregarParametro("p_favorito_noticia", nodo.isFavorito_noticia());
            sp.agregarParametro("p_valoracion_noticia", nodo.getValoracion_noticia());
            sp.agregarParametro("p_valoracion_comentario", nodo.isValoracion_comentario());
            sp.agregarParametro("p_fecha_hora", nodo.getFecha_hora());
            
            return sp.insert();
        }
        catch(SQLException ex){
            throw ex;
        }
    }
    
}

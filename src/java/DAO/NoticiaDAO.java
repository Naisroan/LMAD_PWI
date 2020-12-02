package DAO;

import Class.StoredProcedure;
import Model.Noticia;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ianso
 */
public class NoticiaDAO {
    
    private static final String STR_SP_Create = "sp_noticia_create";
    private static final String STR_SP_Update = "sp_noticia_update";
    private static final String STR_SP_Read = "sp_noticia_read";
    private static final String STR_SP_ReadAll = "sp_noticia_readAll";
    private static final String STR_SP_ReadLast = "sp_noticia_readLast";
    private static final String STR_SP_Delete = "sp_noticia_delete";
    private static final String STR_SP_Aprobar = "sp_noticia_aprobar";
    private static final String STR_SP_ReadByUsuario = "sp_noticia_readByIdUsuario";
    private static final String STR_SP_ReadByFavoritasUsuario = "sp_noticia_readByFavoritasIdUsuario";
    
    
    public static Noticia Create(Noticia nodo) throws Exception {
    
        StoredProcedure sp = null;
        
        try {
            
            sp = new StoredProcedure(STR_SP_Create);
            
            sp.agregarParametro("p_titulo", nodo.getTitulo());
            sp.agregarParametro("p_desc_corta", nodo.getDesc_corta());
            sp.agregarParametro("p_noticia", nodo.getNoticia());
            sp.agregarParametro("p_id_categoria", nodo.getId_categoria());
            sp.agregarParametro("p_id_usuario", nodo.getId_usuario());
            
            if (!sp.insert()) {
                return null;
            } else {
                return ReadLast();
            }
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static Boolean Update(Noticia nodo) throws Exception {
    
        StoredProcedure sp = null;
        
        try {
            
            sp = new StoredProcedure(STR_SP_Update);
            
            sp.agregarParametro("p_id_noticia", nodo.getId_noticia());
            sp.agregarParametro("p_titulo", nodo.getTitulo());
            sp.agregarParametro("p_desc_corta", nodo.getDesc_corta());
            sp.agregarParametro("p_noticia", nodo.getNoticia());
            sp.agregarParametro("p_id_categoria", nodo.getId_categoria());
            sp.agregarParametro("p_id_usuario", nodo.getId_usuario());
            
            return sp.insert();
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static Boolean Aprobar(Noticia nodo, boolean aprobar, String comentario) throws Exception {
    
        StoredProcedure sp = null;
        
        try {
            
            sp = new StoredProcedure(STR_SP_Aprobar);

            sp.agregarParametro("p_id_noticia", nodo.getId_noticia());
            sp.agregarParametro("p_aprobada", aprobar);
            sp.agregarParametro("p_comentario_aprobacion", comentario);
            
            return sp.insert();
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static Boolean Delete(String id) throws Exception {
    
        StoredProcedure sp = null;
        
        try {
            
            sp = new StoredProcedure(STR_SP_Delete);
            sp.agregarParametro("p_id_noticia", Integer.parseInt(id));
        
            return sp.insert();
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static Noticia Read(String id) throws Exception {
    
        StoredProcedure sp = null;
        
        try {
            
            sp = new StoredProcedure(STR_SP_Read);
            sp.agregarParametro("p_id_noticia", Integer.parseInt(id));
            
            ResultSet rs = sp.select();
            
            while (rs.next()) {
               
                return (Noticia)Parse(rs);
            }
        
            return null;
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static Noticia ReadLast() throws Exception {
    
        StoredProcedure sp = null;
        
        try {
            
            sp = new StoredProcedure(STR_SP_ReadLast);
            ResultSet rs = sp.select();
            
            while (rs.next()) {
               
                return (Noticia)Parse(rs);
            }
        
            return null;
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static List ReadAll(int soloAprobadas) throws Exception {
    
        StoredProcedure sp = null;
        
        ArrayList<Noticia> lista;
        lista = new ArrayList<>();
        
        try {
            
            sp = new StoredProcedure(STR_SP_ReadAll);
            
            sp.agregarParametro("p_aprobada", soloAprobadas);
            
            ResultSet rs = sp.select();
            
            while (rs.next()) {
               
                lista.add((Noticia)Parse(rs));
            }
        
            return lista;
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static List ReadByIdUsuario(int idUsuario) throws Exception {
    
        StoredProcedure sp = null;
        
        ArrayList<Noticia> lista;
        lista = new ArrayList<>();
        
        try {
            
            sp = new StoredProcedure(STR_SP_ReadByUsuario);
            
            sp.agregarParametro("idUsuario", idUsuario);
            
            ResultSet rs = sp.select();
            
            while (rs.next()) {
               
                lista.add((Noticia)Parse(rs));
            }
        
            return lista;
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static List ReadByFavoritasUsuario(int idUsuario) throws Exception {
    
        StoredProcedure sp = null;
        
        ArrayList<Noticia> lista;
        lista = new ArrayList<>();
        
        try {
            
            sp = new StoredProcedure(STR_SP_ReadByFavoritasUsuario);
            
            sp.agregarParametro("idUsuario", idUsuario);
            
            ResultSet rs = sp.select();
            
            while (rs.next()) {
               
                lista.add((Noticia)Parse(rs));
            }
        
            return lista;
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static Noticia Parse(ResultSet rs) throws SQLException {
        
        Noticia nodo = new Noticia();
        
        nodo.setId_usuario(rs.getInt("id_usuario"));
        nodo.setId_noticia(rs.getInt("id_noticia"));
        nodo.setTitulo(rs.getString("titulo"));
        nodo.setDesc_corta(rs.getString("desc_corta"));
        nodo.setId_categoria(rs.getInt("id_categoria"));
        nodo.setNoticia(rs.getString("noticia"));
        nodo.setThumbnail(rs.getString("thumbnail"));
        nodo.setAprobada(rs.getBoolean("aprobada"));
        nodo.setComentario_aprobacion(rs.getString("comentario_aprobacion"));
        
        return nodo;
    }
}

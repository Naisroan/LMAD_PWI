package DAO;

import Class.StoredProcedure;
import Model.Multimedia;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ianso
 */
public class MultimediaDAO {
    
    private static final String STR_SP_Create = "sp_noticia_multimedia_create";
    private static final String STR_SP_Update = "sp_noticia_multimedia_update";
    private static final String STR_SP_Read = "sp_noticia_multimedia_read";
    private static final String STR_SP_ReadAll = "sp_noticia_multimedia_readAll";
    private static final String STR_SP_ReadByNoticiaId = "sp_noticia_multimedia_readBynoticia";
    private static final String STR_SP_Delete = "sp_noticia_multimedia_delete";
    
    
    public static Boolean Create(Multimedia nodo) throws Exception {
    
        StoredProcedure sp = null;
        
        try {
            
            sp = new StoredProcedure(STR_SP_Create);
            
            sp.agregarParametro("p_id_noticia", nodo.getId_noticia());
            sp.agregarParametro("p_ruta", nodo.getRuta());
            sp.agregarParametro("p_tipo_contenido", nodo.getTipo_contenido());
            
            if (!sp.insert()) {
                return false;
            } else {
                return true;
            }
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static Boolean Update(Multimedia nodo) throws Exception {
    
        StoredProcedure sp = null;
        
        try {
            
            sp = new StoredProcedure(STR_SP_Update);
            
            sp.agregarParametro("p_id_noticia_multimedia", nodo.getId_noticia_multimedia());
            sp.agregarParametro("p_id_noticia", nodo.getId_noticia());
            sp.agregarParametro("p_ruta", nodo.getRuta());
            sp.agregarParametro("p_tipo_contenido", nodo.getTipo_contenido());
            
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
            sp.agregarParametro("p_id_noticia_multimedia", Integer.parseInt(id));
        
            return sp.insert();
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static Multimedia Read(String id) throws Exception {
    
        StoredProcedure sp = null;
        
        try {
            
            sp = new StoredProcedure(STR_SP_Read);
            sp.agregarParametro("p_id_noticia_multimedia", Integer.parseInt(id));
            
            ResultSet rs = sp.select();
            
            while (rs.next()) {
               
                return (Multimedia)Parse(rs);
            }
        
            return null;
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static List ReadByIdNoticia(String id) throws Exception {
    
        StoredProcedure sp = null;
        
        ArrayList<Multimedia> lista;
        lista = new ArrayList<>();
        
        try {
            
            sp = new StoredProcedure(STR_SP_ReadByNoticiaId);
            
            sp.agregarParametro("p_id_noticia", Integer.parseInt(id));
            
            ResultSet rs = sp.select();
            
            while (rs.next()) {
               
                lista.add((Multimedia)Parse(rs));
            }
        
            return lista;
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static Multimedia Parse(ResultSet rs) throws SQLException {
        
        Multimedia nodo = new Multimedia();
        
        nodo.setId_noticia(rs.getInt("id_noticia"));
        nodo.setId_noticia_multimedia(rs.getInt("id_noticia_multimedia"));
        nodo.setRuta(rs.getString("ruta"));
        nodo.setTipo_contenido(rs.getString("tipo_contenido"));
        
        return nodo;
    }
    
}

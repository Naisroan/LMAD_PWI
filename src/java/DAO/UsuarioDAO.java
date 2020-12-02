package DAO;

import Interfaces.IEntity;
import java.util.ArrayList;
import java.util.List;
import Class.StoredProcedure;
import Model.Usuario;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ianso
 */
public class UsuarioDAO {
    
    private static final String STR_SP_Create = "sp_usuario_create";
    private static final String STR_SP_Update = "sp_usuario_update";
    private static final String STR_SP_Delete = "sp_usuario_delete";
    private static final String STR_SP_Read = "sp_usuario_read";
    private static final String STR_SP_ReadByNick = "sp_usuario_readByNick";
    private static final String STR_SP_ReadByCorreo = "sp_usuario_readByCorreo";
    private static final String STR_SP_ReadAll = "sp_usuario_readall";

    public static Boolean Create(Usuario nodo) throws Exception {
        
        StoredProcedure sp = null;
        
        try {
            
            sp = new StoredProcedure(STR_SP_Create);
            
            sp.agregarParametro("p_id_rol", nodo.getId_rol());
            sp.agregarParametro("p_correo", nodo.getCorreo());
            sp.agregarParametro("p_nick", nodo.getNick());
            sp.agregarParametro("p_pass", nodo.getPass());
            sp.agregarParametro("p_ruta_imagen", nodo.getRuta_imagen());
            
            return sp.insert();
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static Boolean Update(Usuario nodo) throws Exception {
        
        StoredProcedure sp = null;
        
        try {
            
            sp = new StoredProcedure(STR_SP_Update);
            
            sp.agregarParametro("p_id_usuario", nodo.getId_usuario());
            sp.agregarParametro("p_id_rol", nodo.getId_rol());
            sp.agregarParametro("p_correo", nodo.getCorreo());
            sp.agregarParametro("p_nick", nodo.getNick());
            sp.agregarParametro("p_pass", nodo.getPass());
            sp.agregarParametro("p_ruta_imagen", nodo.getRuta_imagen());
            
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
            sp.agregarParametro("p_id_usuario", Integer.parseInt(id));
        
            return sp.insert();
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static Usuario Read(String id) throws Exception {
        
        StoredProcedure sp = null;
        
        try {
            
            sp = new StoredProcedure(STR_SP_Read);
            sp.agregarParametro("p_id_usuario", Integer.parseInt(id));
            
            ResultSet rs = sp.select();
            
            while (rs.next()) {
               
                return (Usuario)Parse(rs);
            }
        
            return null;
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static Usuario ReadByNick(String nick) throws Exception {
        
        StoredProcedure sp = null;
        
        try {
            
            sp = new StoredProcedure(STR_SP_ReadByNick);
            sp.agregarParametro("p_nick", nick);
            
            ResultSet rs = sp.select();
            
            while (rs.next()) {
               
                return (Usuario)Parse(rs);
            }
        
            return null;
        } 
        catch (SQLException ex) {
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static Usuario ReadByCorreo(String correo) throws Exception {
        
        StoredProcedure sp = null;
        
        try {
            
            sp = new StoredProcedure(STR_SP_ReadByCorreo);
            sp.agregarParametro("p_correo", correo);
            
            ResultSet rs = sp.select();
            
            while (rs.next()) {
               
                return (Usuario)Parse(rs);
            }
        
            return null;
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static List ReadAll() throws Exception {
        
        StoredProcedure sp = null;
        ArrayList<Usuario> lista;
        lista = new ArrayList<>();
        
        try {
            
            sp = new StoredProcedure(STR_SP_ReadAll);
            ResultSet rs = sp.select();
            
            while (rs.next()) {
               
                lista.add((Usuario)Parse(rs));
            }
        
            return lista;
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static Usuario Parse(ResultSet rs) throws SQLException {
        
        Usuario nodo = new Usuario();
        
        nodo.setId_usuario(rs.getInt("id_usuario"));
        nodo.setId_rol(rs.getInt("id_rol"));
        nodo.setCorreo(rs.getString("correo"));
        nodo.setNick(rs.getString("nick"));
        nodo.setPass(rs.getString("pass"));
        nodo.setRuta_imagen(rs.getString("ruta_imagen"));
        
        return nodo;
    }
    
}

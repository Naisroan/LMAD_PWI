/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Class.StoredProcedure;
import Model.Rol;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author fer_2
 */
public class RolDAO {
    private static final String STR_SP_ReadByUsuario = "sp_rol_readByUsuario";
    
    public static Rol ReadByUsuario(String id) throws Exception{
    
        try{
            StoredProcedure sp = new StoredProcedure(STR_SP_ReadByUsuario);
            sp.agregarParametro("p_id_usuario", Integer.parseInt(id));
            
            ResultSet rs = sp.select();
            
            while(rs.next()){
                return (Rol)Parse(rs);
            }
            return null;
        }
        catch(SQLException ex){
            
            throw ex;
        }
    }
    
    public static Rol Parse(ResultSet rs) throws SQLException{
        
        Rol nodo = new Rol();
        
        nodo.setId_rol(rs.getInt("id_rol"));
        nodo.setNombre(rs.getString("nombre"));
        
        return nodo;
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Class.StoredProcedure;
import Model.Categorias;
import java.sql.ResultSet;
import java.sql.SQLException;


/**
 *
 * @author fer_2
 */
public class CategoriasDAO {
    private final static String STR_SP_Read = "sp_categorias_read";
    
    public static Categorias Read(String id) throws Exception {
        try {
            
            StoredProcedure sp = new StoredProcedure(STR_SP_Read);
            sp.agregarParametro("p_id_categoria", Integer.parseInt(id));
            
            ResultSet rs = sp.select();
            while(rs.next()){
                return (Categorias)Parse(rs);
            }
            
            return null;
        }
        catch(SQLException ex){
            throw ex;
        }     
    }
    
    public static Categorias Parse(ResultSet rs) throws SQLException {
        
        Categorias nodo = new Categorias();
        
        nodo.setId_categoria(rs.getInt("id_categoria"));
        nodo.setNombre(rs.getString("nombre"));
        
        return nodo;
    }
    
}

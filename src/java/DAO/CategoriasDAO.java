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
import java.util.ArrayList;
import java.util.List;


/**
 *
 * @author fer_2
 */
public class CategoriasDAO {
    
    private final static String STR_SP_Read = "sp_categorias_read";
    private final static String STR_SP_ReadByNombre = "sp_categorias_readByNombre";
    private final static String STR_SP_ReadAll = "sp_categorias_readAll";
    
    public static Categorias Read(String id) throws Exception {
        
        StoredProcedure sp = null;
        
        try {
            
            sp = new StoredProcedure(STR_SP_Read);
            sp.agregarParametro("p_id_categoria", Integer.parseInt(id));
            
            ResultSet rs = sp.select();
            while(rs.next()){
                return (Categorias)Parse(rs);
            }
            
            return null;
        }
        catch(SQLException ex){
            throw ex;
        } finally {
            sp.close();
        }
    }

    public static Categorias ReadByNombre(String nombre) throws Exception {
        
        StoredProcedure sp = null;
        
        try {
            
            sp = new StoredProcedure(STR_SP_ReadByNombre);
            sp.agregarParametro("p_nombre", nombre);
            
            ResultSet rs = sp.select();
            while(rs.next()){
                return (Categorias)Parse(rs);
            }
            
            return null;
        }
        catch(SQLException ex){
            throw ex;
        } finally {
            sp.close();
        }
    }
    
    public static List ReadAll() throws Exception {
        
        StoredProcedure sp = null;
        ArrayList<Categorias> lista;
        lista = new ArrayList<>();
        
        try {
            
            sp = new StoredProcedure(STR_SP_ReadAll);
            ResultSet rs = sp.select();
            
            while (rs.next()) {
               
                lista.add((Categorias)Parse(rs));
            }
        
            return lista;
        } 
        catch (SQLException ex) {
            
            throw ex;
        } finally {
            sp.close();
        }
    }
    
    public static Categorias Parse(ResultSet rs) throws SQLException {
        
        Categorias nodo = new Categorias();
        
        nodo.setId_categoria(rs.getInt("id_categoria"));
        nodo.setNombre(rs.getString("nombre"));
        
        return nodo;
    }
    
}

package Class;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ianso
 */
public class Conexion {
    
    private Connection _Connection;
    
    private static final String NOMBRE_DRIVER = "com.mysql.jdbc.Driver";
    private static final String STR_CONEXION = "jdbc:mysql://localhost:3306";
    private static final String STR_CONEXION_BASEDATOS = "noti_app";
    private static final String STR_CONEXION_USUARIO = "root";
    private static final String STR_CONEXION_PASSWORD = "a1234567890A";
    
    private PreparedStatement _PreparedStatment;
    private ResultSet _ResultSet;
    
    public Conexion() throws Exception {
        
        try {
            
            Class.forName(NOMBRE_DRIVER);
            
            _Connection = DriverManager.getConnection(
                    STR_CONEXION + "/" + STR_CONEXION_BASEDATOS + "?useSSL=false&" + "serverTimezone=UTC",
                    STR_CONEXION_USUARIO,
                    STR_CONEXION_PASSWORD
            );
        }
        catch (ClassNotFoundException | SQLException ex) {
            
            throw ex;
        }
    }
    
    public Connection getConnection() {
        return _Connection;
    }
    
    public PreparedStatement getPreparedStatment() {
        
        return _PreparedStatment;
    }
    
    public ResultSet getResultSet() {
        
        return _ResultSet;
    }
}
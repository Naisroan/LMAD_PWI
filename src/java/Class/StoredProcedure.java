package Class;

import java.awt.Image;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.text.DecimalFormat;
import java.time.LocalTime;
import java.util.ArrayList;

/**
 *
 * @author ianso
 */
public class StoredProcedure {
    
    // atributos
    private String Nombre;
    private ArrayList<StoredProcedureParameter> Parametros;
    private Conexion _Conexion;
    
    // constructor
    public StoredProcedure(String nombre) throws SQLException, Exception {
        
        try {
            
            Nombre = nombre;
            Parametros = new ArrayList<>();
            _Conexion = new Conexion();
        
        } catch (Exception ex) {
            
            throw ex;
        }
    }
    
    // metodos
    public void agregarParametro(String nombreParametro, Object valor) throws Exception {
        
        try {
            
            Parametros.add(new StoredProcedureParameter(nombreParametro, valor));
        }
        catch (Exception ex) {
            
            throw ex;
        }
    }
    
    private CallableStatement getCallableStatement() throws SQLException {
        
        try {
            
            String strStoredProcedure = "{call " + Nombre + " (";
            
            for (int i = 0; i < Parametros.size(); i++) {
                
                strStoredProcedure += "?";
                
                if (i + 1 != Parametros.size()) {
                    
                    strStoredProcedure += ",";
                }
            }
            
            strStoredProcedure += ") }";
            
            return _Conexion.getConnection().prepareCall(strStoredProcedure);
        
        } catch (SQLException ex) {
            
            throw ex;
        }
    }
    
    public ResultSet select() throws Exception {
        
        try {
            
            CallableStatement cs = getCallableStatement();
            
            int index = 1;
            
            for (StoredProcedureParameter param : Parametros) {
                
                setValue(cs, param, index);
                index++;
            }
            
            return cs.executeQuery();
            
        } catch (SQLException ex) {
            
            throw ex;
        }
    }
    
    public Boolean insert() throws Exception {
        
        try {
            
            CallableStatement cs = getCallableStatement();
            
            int index = 1;
            
            for (StoredProcedureParameter param : Parametros) {
                
                setValue(cs, param, index);
                index++;
            }
            
            return !cs.execute();
            
        } catch (Exception ex) {
            
            throw ex;
        }
    }
    
    private void setValue(CallableStatement cs, StoredProcedureParameter param, int index) throws SQLException, Exception {
        
        try {
            
            Object valor = param.getValor();
            String nombreParam = param.getNombre();
            int tipoValor = param.obtenerTipoValor();

            switch (tipoValor) {

                case Types.NULL:                
                {
                    cs.setNull(index, tipoValor);
                    break;
                }

                case Types.VARCHAR:                
                {
                    cs.setString(index, (String) valor);
                    break;
                }

                case Types.INTEGER:                
                {
                    cs.setInt(index, (Integer) valor);
                    break;
                }

                case Types.DOUBLE:                
                {
                    cs.setDouble(index, (Double) valor);
                    break;
                }

                case Types.DECIMAL:                
                {
                    cs.setDouble(index, (Double) valor);
                    break;
                }

                case Types.DATE:                
                {
                    cs.setDate(index, (Date) valor);
                    break;
                }

                case Types.VARBINARY:                
                {
                    cs.setBinaryStream(index, (InputStream) valor);
                    break;
                }

                case Types.BINARY:                
                {
                    cs.setBinaryStream(index, (InputStream) valor);
                    break;
                }

                case Types.BLOB:                
                {
                    cs.setBlob(index, (InputStream) valor);
                    break;
                }

                case Types.BIT:                
                {
                    cs.setBoolean(index, (Boolean) valor);
                    break;
                }
                
                default:
                {
                    throw new Exception("No existe una configuración para el "
                            + "tipo de valor");
                }

            }
            
        } catch (SQLException ex) {
            
            throw ex;
        }
    }
}

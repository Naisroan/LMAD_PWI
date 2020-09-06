package Class;

import java.awt.Image;
import java.sql.Date;
import java.sql.Types;
import java.text.DecimalFormat;
import java.time.LocalTime;

/**
 *
 * @author ianso
 */
public class StoredProcedureParameter {
    
    // atributos
    private String Nombre;
    private Object Valor;
    
    // constructor
    public StoredProcedureParameter(String nombre, Object valor) {
        
        Nombre = nombre;
        Valor = valor;
    }

    // metodos
    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public Object getValor() {
        return Valor;
    }

    public void setValor(Object Valor) {
        this.Valor = Valor;
    }
    
    public int obtenerTipoValor() {
        
        if (Valor == null) {
            
            return Types.NULL;
        }
        
        if (Valor.getClass() == String.class) {
            
            return Types.VARCHAR;
        }
        
        if (Valor.getClass() == Integer.class) {
            
            return Types.INTEGER;
        }
        
        if (Valor.getClass() == double.class) {
            
            return Types.DOUBLE;
        }
        
        if (Valor.getClass() == DecimalFormat.class) {
            
            return Types.DECIMAL;
        }
        
        if (Valor.getClass() == Date.class) {
            
            return Types.DATE;
        }
        
        if (Valor.getClass() == LocalTime.class) {
            
            return Types.DATE;
        }
        
        if (Valor.getClass() == Byte[].class) {
            
            return Types.VARBINARY;
        }
        
        if (Valor.getClass() == Byte.class) {
            
            return Types.BINARY;
        }
        
        if (Valor.getClass() == Image.class) {
            
            return Types.BLOB;
        }
        
        if (Valor.getClass() == Boolean.class) {
            
            return Types.BIT;
        }
        
        return Types.VARCHAR;
    }
}

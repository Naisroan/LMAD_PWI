package Interfaces;

import java.sql.ResultSet;
import java.util.List;

/**
 *
 * @author ianso
 */
public interface IEntity<T> {
    
    public Boolean Create(T nodo) throws Exception;
    
    public T Read(String id) throws Exception;
    
    public List<T> ReadAll() throws Exception;
    
    public Boolean Update(T nodo) throws Exception;
    
    public Boolean Delete(String id) throws Exception;
    
    public T Parse(ResultSet rs) throws Exception;
}

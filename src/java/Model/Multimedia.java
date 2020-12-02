
package Model;

/**
 *
 * @author ianso
 */
public class Multimedia {
    
    private int id_noticia_multimedia;
    private int id_noticia;
    private String ruta;
    private String tipo_contenido;

    /**
     * @return the id_noticia_multimedia
     */
    public int getId_noticia_multimedia() {
        return id_noticia_multimedia;
    }

    /**
     * @param id_noticia_multimedia the id_noticia_multimedia to set
     */
    public void setId_noticia_multimedia(int id_noticia_multimedia) {
        this.id_noticia_multimedia = id_noticia_multimedia;
    }

    /**
     * @return the id_noticia
     */
    public int getId_noticia() {
        return id_noticia;
    }

    /**
     * @param id_noticia the id_noticia to set
     */
    public void setId_noticia(int id_noticia) {
        this.id_noticia = id_noticia;
    }

    /**
     * @return the ruta
     */
    public String getRuta() {
        return ruta;
    }

    /**
     * @param ruta the ruta to set
     */
    public void setRuta(String ruta) {
        this.ruta = ruta;
    }

    /**
     * @return the tipo_contenido
     */
    public String getTipo_contenido() {
        return tipo_contenido;
    }

    /**
     * @param tipo_contenido the tipo_contenido to set
     */
    public void setTipo_contenido(String tipo_contenido) {
        this.tipo_contenido = tipo_contenido;
    }
}

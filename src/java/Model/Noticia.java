package Model;

/**
 *
 * @author ianso
 */
public class Noticia {
    
    private int id_noticia;
    private String titulo;
    private String desc_corta;
    private String noticia;
    private int id_categoria;
    private int id_usuario;
    private String thumbnail;
    private Boolean aprobada;
    private String comentario_aprobacion;

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
     * @return the titulo
     */
    public String getTitulo() {
        return titulo;
    }

    /**
     * @param titulo the titulo to set
     */
    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    /**
     * @return the desc_corta
     */
    public String getDesc_corta() {
        return desc_corta;
    }

    /**
     * @param desc_corta the desc_corta to set
     */
    public void setDesc_corta(String desc_corta) {
        this.desc_corta = desc_corta;
    }

    /**
     * @return the noticia
     */
    public String getNoticia() {
        return noticia;
    }

    /**
     * @param noticia the noticia to set
     */
    public void setNoticia(String noticia) {
        this.noticia = noticia;
    }

    /**
     * @return the id_categoria
     */
    public int getId_categoria() {
        return id_categoria;
    }

    /**
     * @param id_categoria the id_categoria to set
     */
    public void setId_categoria(int id_categoria) {
        this.id_categoria = id_categoria;
    }

    /**
     * @return the id_usuario
     */
    public int getId_usuario() {
        return id_usuario;
    }

    /**
     * @param id_usuario the id_usuario to set
     */
    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    /**
     * @return the thumbnail
     */
    public String getThumbnail() {
        return thumbnail;
    }

    /**
     * @param thumbnail the thumbnail to set
     */
    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    /**
     * @return the aprobada
     */
    public Boolean getAprobada() {
        return aprobada;
    }

    /**
     * @param aprobada the aprobada to set
     */
    public void setAprobada(Boolean aprobada) {
        this.aprobada = aprobada;
    }

    /**
     * @return the comentario_aprobacion
     */
    public String getComentario_aprobacion() {
        return comentario_aprobacion;
    }

    /**
     * @param comentario_aprobacion the comentario_aprobacion to set
     */
    public void setComentario_aprobacion(String comentario_aprobacion) {
        this.comentario_aprobacion = comentario_aprobacion;
    }
}

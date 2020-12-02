/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.util.Date;

/**
 *
 * @author fer_2
 */
public class Valoracion {
    private int id_valoracion;
    private int id_noticia;
    private int id_comentario;
    private int id_usuario;
    private boolean favorito_noticia;
    private int valoracion_noticia;
    private boolean valoracion_comentario;
    private Date fecha_hora;
    private int tipo_valoracion;

    /**
     * @return the id_valoracion
     */
    public int getId_valoracion() {
        return id_valoracion;
    }

    /**
     * @param id_valoracion the id_valoracion to set
     */
    public void setId_valoracion(int id_valoracion) {
        this.id_valoracion = id_valoracion;
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
     * @return the id_comentario
     */
    public int getId_comentario() {
        return id_comentario;
    }

    /**
     * @param id_comentario the id_comentario to set
     */
    public void setId_comentario(int id_comentario) {
        this.id_comentario = id_comentario;
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
     * @return the favorito_noticia
     */
    public boolean isFavorito_noticia() {
        return favorito_noticia;
    }

    /**
     * @param favorito_noticia the favorito_noticia to set
     */
    public void setFavorito_noticia(boolean favorito_noticia) {
        this.favorito_noticia = favorito_noticia;
    }

    /**
     * @return the valoracion_noticia
     */
    public int getValoracion_noticia() {
        return valoracion_noticia;
    }

    /**
     * @param valoracion_noticia the valoracion_noticia to set
     */
    public void setValoracion_noticia(int valoracion_noticia) {
        this.valoracion_noticia = valoracion_noticia;
    }

    /**
     * @return the valoracion_comentario
     */
    public boolean isValoracion_comentario() {
        return valoracion_comentario;
    }

    /**
     * @param valoracion_comentario the valoracion_comentario to set
     */
    public void setValoracion_comentario(boolean valoracion_comentario) {
        this.valoracion_comentario = valoracion_comentario;
    }

    /**
     * @return the fecha_hora
     */
    public Date getFecha_hora() {
        return fecha_hora;
    }

    /**
     * @param fecha_hora the fecha_hora to set
     */
    public void setFecha_hora(Date fecha_hora) {
        this.fecha_hora = fecha_hora;
    }

    /**
     * @return the tipo_valoracion
     */
    public int getTipo_valoracion() {
        return tipo_valoracion;
    }

    /**
     * @param tipo_valoracion the tipo_valoracion to set
     */
    public void setTipo_valoracion(int tipo_valoracion) {
        this.tipo_valoracion = tipo_valoracion;
    }
}

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
public class Comentario {
    private int id_comentario;
    private Date fecha_hora;
    private String descripcion;
    private int id_usuario;
    private int id_noticia;
    private int id_comentario_padre;

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
     * @return the descripcion
     */
    public String getDescripcion() {
        return descripcion;
    }

    /**
     * @param descripcion the descripcion to set
     */
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
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
     * @return the id_comentario_padre
     */
    public int getId_comentario_padre() {
        return id_comentario_padre;
    }

    /**
     * @param id_comentario_padre the id_comentario_padre to set
     */
    public void setId_comentario_padre(int id_comentario_padre) {
        this.id_comentario_padre = id_comentario_padre;
    }
   

}

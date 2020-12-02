$(document).ready(function() {
});

function enviarSubComentario(url_pattern, idComentarioPadre, esPadre) {
    
    let comentario = esPadre ? $('#nuevo_comentario').val() : $('#nuevo_sub_comentario_' + idComentarioPadre).val();
    window.location = url_pattern + '&nuevo_comentario=' + comentario;
}

function enviarLikeComentario(url_pattern, like) {
    window.location = url_pattern + '&like=' + like;
}

function marcarNoticiaFavorita(url_pattern, favorita) {
    window.location = url_pattern + '&favorito=' + favorita;
}
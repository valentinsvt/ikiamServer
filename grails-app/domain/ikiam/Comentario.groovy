package ikiam

class Comentario {

    String texto
    Usuario usuario
    Date fecha
    int likes = 0

    static constraints = {
        texto(size: 1..255)
    }
}

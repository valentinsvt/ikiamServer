package ikiam

class Comentario {

    String texto
    Usuario usuario
    Date fecha
    int likes = 0

    static mapping = {
        columns {
            texto type: 'text'
        }
    }

    static constraints = {
        texto(size: 1..255)
    }
}

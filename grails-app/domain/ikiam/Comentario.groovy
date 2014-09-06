package ikiam

class Comentario {

    /* los comentarios principales no tienen padre y tienen entry
       las respuestas a un comentario tienen padre pero no entry
     */
    Entry entry
    String texto
    Usuario usuario
    Date fecha
    int likes = 0
    Comentario padre

    static mapping = {
        columns {
            texto type: 'text'
        }
    }

    static constraints = {
        texto(size: 1..255)
        padre blank: true, nullable: true
        entry blank: true, nullable: true
    }
}

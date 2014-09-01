package ikiam

class Ruta {

    String descripcion
    Date fecha
    Usuario usuario


    static mapping = {
        columns {
            descripcion type: 'text'
        }
    }

    static constraints = {
        descripcion(size: 1..50)
    }
}

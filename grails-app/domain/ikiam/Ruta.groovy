package ikiam

class Ruta {

    String descripcion
    Date fecha
    Usuario usuario

    static constraints = {
        descripcion(size:1..50)
    }
}

package ikiam

class Paper {
    Especie especie
    String titulo
    Date fecha
    String path

    static constraints = {
        titulo(size: 1..500)
        path(size: 1..500)
    }
}

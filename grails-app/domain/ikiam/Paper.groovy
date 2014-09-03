package ikiam

class Paper {
    Especie especie
    String titulo
    String autor
    Date fecha
    String path

    static constraints = {
        titulo(size: 1..500)
        path(size: 1..500)
        autor(size: 1..150)
    }
}

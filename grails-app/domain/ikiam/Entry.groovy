package ikiam

class Entry {

    Usuario usuario
    Especie especie
    Date fecha
    String observaciones


    static constraints = {
        observaciones(size: 1..255)
        usuario(nullable: true, blank: true)
    }
}

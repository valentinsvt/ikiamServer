package ikiam

class Entry {

    Usuario usuario
    Especie especie
    Date fecha
    Foto foto
    String observaciones


    static constraints = {
        observaciones(size: 1..255)
    }
}

package ikiam

class Genero {
    Familia familia
    String nombre

    static constraints = {
        nombre(size: 1..75)
    }
}

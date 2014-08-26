package ikiam

class Familia {

    String nombre

    static constraints = {
        nombre(size: 1..75)
    }

    String toString() {
        return nombre.decodeURL()
    }
}

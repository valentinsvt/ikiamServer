package ikiam

class FormaDeVida {

    String descripcion

    static constraints = {
        descripcion(size: 1..100)
    }
}

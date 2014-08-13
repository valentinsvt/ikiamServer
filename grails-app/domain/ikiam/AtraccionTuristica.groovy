package ikiam

class AtraccionTuristica {

    Coordenada coordenada
    String nombre
    int likes = 0
    Date fecha = new Date()


    static constraints = {
        nombre(blank: false,nullable: false,size: 1..200)

    }

}

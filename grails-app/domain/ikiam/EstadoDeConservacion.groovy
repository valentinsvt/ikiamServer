package ikiam

class EstadoDeConservacion {
    String descripcion


    static constraints = {
        descripcion(blank:false,nullable: false,size: 1..100)

    }
}

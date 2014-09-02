package ikiam

class EstadoDeConservacion {
    String descripcion
    String codigo
    String color


    static constraints = {
        descripcion(blank:false,nullable: false,size: 1..100)
        codigo(blank:false,nullable: false,size: 1..2)
        color(blank:false,nullable: false,size: 1..10)

    }
}

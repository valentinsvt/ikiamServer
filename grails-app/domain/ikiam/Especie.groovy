package ikiam

class Especie {
    Genero genero
    String nombre
    String nombreComun;
    String featured
    String descripcion
    String distribucion
    String etimologia
    String texto
    int likes=0;
    Color color1;
    Color color2;
    EstadoDeConservacion estado
    static hasMany = [entries: Entry, fotos: Foto]

    static mapping = {
        descripcion type: "text"
        distribucion type: "text"
        etimologia type: "text"
        texto type: "text"
    }

    static constraints = {
        nombre(size: 1..75)
        nombreComun(blank: true, nullable: true)
        color1(blank: true, nullable: true)
        color2(blank: true, nullable: true)
        featured(blank: true, nullable: true)
        descripcion(blank: true, nullable: true)
        distribucion(blank: true, nullable: true)
        etimologia(blank: true, nullable: true)
        texto(blank: true, nullable: true)
        estado(blank: true, nullable: true)
    }

    String toString() {
        return nombreComun.decodeURL()
    }
}

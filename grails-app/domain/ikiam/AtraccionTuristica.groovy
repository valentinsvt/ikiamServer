package ikiam

class AtraccionTuristica {

    Coordenada coordenada
    String nombre
    String url
    int likes = 0
    Date fecha = new Date()
    String descripcion

    static hasMany = [fotos: Foto]

    static constraints = {
        nombre(blank: false, nullable: false, size: 1..200)
        descripcion(blank: false, nullable: false, maxSize: 5000)
        url(blank: true, nullable: true, size: 1..200, url: true)
    }

}

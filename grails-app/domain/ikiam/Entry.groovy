package ikiam

class Entry {

    Usuario usuario
    Especie especie
    Date fecha
    String observaciones

    static hasMany = [fotos: Foto]

    static constraints = {
        observaciones(blank:true,nullable: true)
        usuario(nullable: true, blank: true)
        especie(blank: true, nullable: true)
    }
}

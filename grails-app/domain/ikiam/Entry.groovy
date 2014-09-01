package ikiam

class Entry {

    Usuario usuario
    Especie especie
    Date fecha
    String observaciones

    static hasMany = [fotos: Foto]

    static mapping = {
        columns {
            observaciones type: 'text'
        }
    }

    static constraints = {
        observaciones(blank:true,nullable: true)
        usuario(nullable: true, blank: true)
        especie(blank: true, nullable: true)
    }
}

package ikiam

class Entry {

    Usuario usuario
    Especie especie
    Date fecha
    String observaciones
    String cautiverio = "N"/*S--> si N--> no*/
    int reportado = 0 /* Cuenta cuantas veces ha sido reportada */

    int deleted = 0

    static hasMany = [fotos: Foto, comentarios: Comentario, reportes: ReporteEntry]

    static mapping = {
        columns {
            observaciones type: 'text'
        }
    }

    static constraints = {
        observaciones(blank: true, nullable: true)
        usuario(nullable: true, blank: true)
        especie(blank: true, nullable: true)
        cautiverio(blank: true, nullable: true, size: 1..1)
        reportado(blank: true, nullable: true, size: 1..1)
    }
}

package ikiam

class ReporteEntry {

    Entry entry
    Usuario usuario
    String razon
    Date fecha = new Date()

    static constraints = {
        razon blank: true, nullable: true
    }
}

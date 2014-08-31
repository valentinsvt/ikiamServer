package ikiam

class Especie {
    Genero genero
    String nombre
    String nombreComun;
    String featured
    int likes=0;
    Color color1;
    Color color2;

    static hasMany = [entries: Entry, fotos: Foto]

    static constraints = {
        nombre(size: 1..75)
        nombreComun(blank: true, nullable: true)
        color1(blank: true, nullable: true)
        color2(blank: true, nullable: true)
        featured(blank: true, nullable: true)
    }

    String toString() {
        return nombreComun.decodeURL()
    }
}

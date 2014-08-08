package ikiam

class Especie {
    Genero genero
    String nombre
    String nombreComun;
    Color color1;
    Color color2;

    static constraints = {
        nombre(size: 1..75)
        color2(blank: true, nullable: true)
    }
}

package ikiam

class Foto {

    String path;
    String keyWords
    Coordenada coordenada;
    int likes = 0
    Usuario usuario
    Entry entry
    Especie especie
    AtraccionTuristica atraccion

    static constraints = {
        path(size: 1..255)
        usuario(nullable: true, blank: true)
        coordenada(nullable: true, blank: true)
        keyWords(blank: true, nullable: true, size: 1..100)
        atraccion(blank:true,nullable: true)
        entry(blank:true,nullable: true)
        especie(blank:true,nullable: true)
    }
}

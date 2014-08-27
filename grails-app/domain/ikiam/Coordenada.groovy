package ikiam

class Coordenada {

    double latitud
    double longitud
    double altitud = 0
    Ruta ruta


    static constraints = {
        ruta(nullable: true, blank: true)
    }

    String toString() {
        return "${this.latitud}; ${this.longitud}; ${this.altitud}"
    }
}

package ikiam

class Coordenada {

    double latitud
    double longitud
    Ruta ruta


    static constraints = {
        ruta(nullable: true,blank:true)
    }
    String toString(){
        return "${this.latitud} - ${this.longitud}"
    }
}

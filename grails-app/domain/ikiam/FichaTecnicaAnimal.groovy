package ikiam

class FichaTecnicaAnimal {
    Especie especie
    double tallaMin=0
    double tallaMax=0
    double pesoMin=0
    double pesoMax=0
    String alimentacion
    String social
    String comportamiento
    int longevidad=0
    int longevidadCautiverio=0

    static mapping = {
        alimentacion type: "text"
        social type: "text"
        comportamiento type: "text"
    }
}

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
    String conservacion
    String etimologia
    String taxonomia
    String habitat
    int longevidad=0
    int longevidadCautiverio=0
    double alturaMin=0
    double alturaMax=0
    double temperaturaMin=0
    double temperaturaMax=0

    static mapping = {
        alimentacion type: "text"
        social type: "text"
        comportamiento type: "text"
        conservacion type: "text"
        etimologia type: "text"
        taxonomia type: "text"
        habitat type: "text"

    }
    static constraints = {
        alimentacion(blank: true,nullable: true)
        social(blank: true,nullable: true)
        comportamiento(blank: true,nullable: true)
        etimologia(blank: true,nullable: true)
        conservacion(blank: true,nullable: true)
        habitat(blank: true,nullable: true)
        taxonomia(blank: true,nullable: true)
        alturaMin(blank: true,nullable: true)
        alturaMax(blank: true,nullable: true)
        temperaturaMax(blank: true,nullable: true)
        temperaturaMin(blank: true,nullable: true)
    }
}

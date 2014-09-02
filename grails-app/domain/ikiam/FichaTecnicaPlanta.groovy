package ikiam

class FichaTecnicaPlanta {
    Especie especie
    FormaDeVida forma1
    FormaDeVida forma2

    String fenologia
    String flor
    String fruto
    String semilla
    String hojas
    String tronco
    String factoresLimitantesCrecimiento
    /*CARACTERÍSTICAS EDAFOCLIMÁTICAS*/
    double alturaMin=0
    double alturaMax=0
    double temperaturaMin=0
    double temperaturaMax=0
    double precipitacionMin=0
    double precipitacionMax=0
    /*Requerimientos edáficos.*/
    String edaficos
    static mapping = {
        fenologia type: "text"
        flor type: "text"
        fruto type: "text"
        semilla type: "text"
        hojas type: "text"
        tronco type: "text"
        edaficos type: "text"
    }
    static constraints = {
         forma1(blank:true,nullable: true)
         forma2(blank:true,nullable: true)
         fenologia(blank:true,nullable: true)
         flor(blank:true,nullable: true)
         fruto(blank:true,nullable: true)
         semilla(blank:true,nullable: true)
         hojas(blank:true,nullable: true)
         tronco(blank:true,nullable: true)
         factoresLimitantesCrecimiento(blank:true,nullable: true)

    }
}

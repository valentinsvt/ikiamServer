package ikiam

class Usuario {
    String facebookId
    String nombre
    String apellido
    String password
    String esAdmin = "N" /*N o S*/
    String esCientifico = "N" /*N o S*/
    String email
    String tipo /*facebook o ikiam*/

    static constraints = {

        email(email: true, blank: true, nullable: true)
        password(size: 1..255, nullable: true,blank: true)
        esAdmin(size: 1..1)
        esCientifico(size: 1..1)
        nombre(size: 1..100, blank: false)
        apellido(size: 1..100, blank: false)
        facebookId(size: 1..30, blank: true, nullable: true)
        tipo(size: 1..10, blank: true, nullable: false)
    }
}

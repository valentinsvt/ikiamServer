package ikiam

class Usuario {

    String nombre
    String Apellido
    String login
    String password
    String esAdmin
    String esCientifico
    String email

    static constraints = {
        login(unique: true)
        email(email: true,blank: true,nullable: true)
        password(size: 1..255,nullable: false)
        login(size: 1..10,nullable: false,blank: false)
        esAdmin(size: 1..1)
        esCientifico(size: 1..1)
        nombre(size: 1..100,blank: false)
        apellido(size:1..100,blank:false)
    }
}

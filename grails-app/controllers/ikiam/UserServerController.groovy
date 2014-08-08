package ikiam

class UserServerController {

    def createUser(){
        println "params "+params
        def usu = new Usuario()
        usu.tipo=params.tipo
        if(params.tipo=="facebook"){
            usu.facebookId=params.id
            usu.nombre=params.nombre
            usu.apellido = params.apellido
        }else{
            def comp = Usuario.findAllByEmail(params.email)
            if(comp.size()>0){
                render "El email "+params.email+" ya esta registrado."
                return
            }else{
                usu.email=params.email
                usu.nombre=params.nombre
                usu.apellido = params.apellido
                usu.password=params.pass
                usu.esAdmin="N";
            }
            if(usu.save(flush: true)){
                render usu.id
                return
            }else {
                println "error save "+usu.errors
                render "error en el save"
                return
            }

        }
    }

    def login(){
        println "params "+params
        def usu = Usuario.findByEmailAndPassword(params.email,params.pass)
        if(usu){
            render ""+usu.id+";"+usu.email+";"+usu.nombre+";"+usu.apellido
        }else{
            response.sendError(404)
        }
    }


}

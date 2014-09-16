package ikiam

class EnciclopediaController {

    def index() {}

    def show() {
    }

    def show_arbol() {
    }

    def infoFamilia() {
        return [familia: Familia.get(params.id.toLong())]
    }

    def infoGenero() {
        return [genero: Genero.get(params.id.toLong())]
    }

    def infoEspecie() {
        return [especie: Especie.get(params.id.toLong())]
    }
}

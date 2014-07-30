package ikiam

class Color {

    String color
    String colorIngles

    static constraints = {
        color(size: 1..20)
        colorIngles(size: 1..20)
    }
}

package ikiam

class Color {

    String color

    static constraints = {
        color(size: 1..20)
    }

    String toString() {
        return color
    }
}

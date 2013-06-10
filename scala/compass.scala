class Compass {
  val directions = List("north", "east", "south", "west")
  var bearing = 0

  print("Initial bearing : ")
  println(direction)

  def direction() = directions(bearing)

  def inform(turnDirection: String) {
    println("Turinig " + turnDirection + ". Now bearing " + direction)
  }

  def turnRight() {
    bearing = (bearing + 1) % direction.size
    inform("right")
  }
}

val myCompass = new Compass

myCompass.turnRight
myCompass.turnRight



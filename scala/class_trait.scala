
class Person(val name: String) {
  def talk(message: String) = println(name + "say" + message)
  def id(): String = name
}

class Employee(override val name: String, val number: Int) extends Person(name) {
  override def talk(message: String) {
    println(name + " with number " + number + " says " + message)
  }
  override def id(): String = number.toString
}

object Person {
  def rule = println("hgeeeeee")
}

trait Nice {
  def greet() = println("Howdily doodily.")
}

class Charactor(override val name: String) extends Person(name) with Nice

class TestPerson extends Nice

//object TestPerson extends Nice

val test = new TestPerson
test.greet

//val test = new Charactor("hoge")
//test.greet

//Person.rule
//val employee = new Employee("yoda", 4)
//employee.talk("Extend or extend not. There is try.")



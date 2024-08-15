// class Person {
//   // Default constructor
//   Person() {
//     print("Person created");
//   }
// }

// void main() {
//   Person p = Person(); // Calls the default constructor
// }
//Parameterize const
// class Person{
//   String name;
//   int age;
//   Person(this.name,this.age);
// }
// void main(){
//   Person p = Person("John", 20);
//   print("Name: ${p.name}, Age: ${p.age}");
// }
//=== Name const
// class Person {
//   String name;
//   int age;

//   // Named constructor
//   Person.namedConstructor(this.name, this.age);

//   Person.anotherNamedConstructor(this.name) :
//     this.age = 0; // Default value for age
  
// }

// void main() {
//   Person p1 = Person.namedConstructor("John", 30);
//   Person p2 = Person.anotherNamedConstructor("Doe");
//   print("Name: ${p1.name}, Age: ${p1.age}");
//   print("Name: ${p2.name}, Age: ${p2.age}");
// }
 //Factory Constructor:==================
//  class Singelton{
//   static final Singelton _singelton = Singelton._internal();
//   factory Singelton(){
//     return _singelton;
//   }
//   Singelton._internal();// private constructor
//  }
//  void main(){
//   Singelton s1 = Singelton();
//   Singelton s2 = Singelton();
//   print(s1==s2); // true, both are the same instance
//  }

// optional Paramater.........
// void greet([String? name]){
//   if(name != null){
//     print("Hello, $name");
//   }else{
//     print("Hello!");
//   }
// }
// void main(){
//   greet();
//   greet('Alice');
// }
// Named Parameter.................

// void greet({String? firstName, String? lastName}){
//   if(firstName != null && lastName != null){
//     print("Hello $firstName $lastName");
//   }else if(firstName != null){
//     print('Hello $firstName');
//   }else if(lastName != null){
//     print('Hello $lastName');
//   }else{
//     print('Hello');
//   }
// }
// void main(){
//   greet();
//  greet(firstName: 'Alice');
//  greet(firstName: 'Alice', lastName: 'Smith');
// }

// interface.................
// Define an interface using a class
class Animal {
  void eat(){}
  void sleep(){}
}

// Implement the interface in another class
class Dog implements Animal {
  @override
  void eat() {
    print('Dog is eating');
  }

  @override
  void sleep() {
    print('Dog is sleeping');
  }
}

void main() {
  Dog myDog = Dog();
  myDog.eat(); // Output: Dog is eating
  myDog.sleep(); // Output: Dog is sleeping
}

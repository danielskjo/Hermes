abstract class User {
  String id;
  String name;
  String username;
  String email;
  String password;
  String address;
  String university;
  String image;
  DateTime date;
}

class Student extends User {
  Student(String id, String name, String username, String email, String password, String university, String image, DateTime date) {
    this.id = id;
    this.name = name;
    this.username = username;
    this.email = email;
    this.password = password;
    this.university = university;
    this.image = image;
    this.date = date;
  }
}

class Donor extends User {
  Donor(String id, String name, String username, String email, String password, String address, String image, DateTime date) {
    this.id = id;
    this.name = name;
    this.username = username;
    this.email = email;
    this.password = password;
    this.university = university;
    this.image = image;
    this.date = date;
  }
}
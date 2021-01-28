class User {
  String id;
  String name;
  String username;
  String email;
  String password;
  String image;
  String type;
  String address;
  String university;
  // DateTime date;

  // Donor constructor
  User.donor(String id, String name, String username, String email, String password, String image, String address) {
    this.id = id;
    this.name = name;
    this.username = username;
    this.email = email;
    this.password = password;
    this.image = image;
    this.type = "Donor";
    this.address = address;
    // this.date = date;
  }
  // Student constructor
  User.student(String id, String name, String username, String email, String password, String image, String university) {
    this.id = id;
    this.name = name;
    this.username = username;
    this.email = email;
    this.password = password;
    this.image = image;
    this.type = "Student";
    this.university = university;
    // this.date = date;
  }
}
class Request {
  final String id;
  final String title;
  final String desc;
  final DateTime date;
  // final Student student;

  Request(
    this.id,
    this.title,
    this.desc,
    this.date,
  );

  bool contains(String query) {
    if (this.title.toLowerCase().contains(query.toLowerCase())) {
      return true;
    }
    else if (this.desc.toLowerCase().contains(query.toLowerCase())) {
      return true;
    }
    return false;
  }
}

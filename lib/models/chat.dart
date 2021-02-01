class Chat {
  final String id;
  final String sender;
  final String message;
  final DateTime date;

  Chat(this.id, this.sender, this.message, this.date);

  bool contains(String query) {
    if (this.sender.toLowerCase().contains(query.toLowerCase())) {
      return true;
    }
    else if (this.message.toLowerCase().contains(query.toLowerCase())) {
      return true;
    }
    return false;
  }
}

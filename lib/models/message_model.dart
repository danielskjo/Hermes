import 'user_model.dart';

class Message {
  final User sender;
  final String time;
  final String text;
  final bool isLiked;
  final bool unread;

  Message({this.sender, this.time, this.text, this.isLiked, this.unread});
}

//US - current user
final User currentUser = User(
  id: 0,
  name: "Current User",
  imageUrl: 'assets/images/meme1.jpg',
);

//USERS
final User person1 = User(
  id: 1,
  name: "Rachel",
  imageUrl: 'assets/images/meme2.jpg',
);

final User person2 = User(
  id: 2,
  name: "Justin",
  imageUrl: 'assets/images/meme3.jpg',
);

final User person3 = User(
  id: 3,
  name: "Martin",
  imageUrl: 'assets/images/meme4.jpg',
);

//FAVORITE CONTACTS
List<User> favorites = [person1, person2, person3];

//MESSAGES
List<Message> chats = [
  Message(
    sender: person1,
    time: '7:30pm',
    text: "I want chicken.",
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '7:30pm',
    text: "Ka-boom",
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: person2,
    time: '7:00am',
    text: "This is an example text.",
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: person3,
    time: '7:00am',
    text: "This is an example text.",
    isLiked: false,
    unread: false,
  ),
];

import 'package:intl/intl.dart';

class Message {
  final String title;
  final String body;
  final DateTime createdAt;
  final String room;
  final String type;

  Message({
    required this.title,
    required this.body,
    required this.createdAt,
    required this.room,
    required this.type,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      title: json['title'],
      body: json['body'],
      createdAt: DateTime.parse(json['createdAt']),
      room: json['room'],
      type: json['type']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      "createdAt": DateFormat('yyyy-MM-dd HH:mm').format(createdAt),
      "room": room,
      "tyoe": type
    };
  }

  @override
  String toString() {
    return 'Message{title: $title, body: $body, createdAt: $createdAt, room: $room, type: $type}';
  }
}

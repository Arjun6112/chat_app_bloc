import 'package:firebase_auth/firebase_auth.dart';

class Chat {
  final String id;
  final String message;
  final User sender;
  final DateTime timestamp;

  Chat({
    required this.id,
    required this.message,
    required this.sender,
    required this.timestamp,
  });

  Chat copyWith({
    String? id,
    String? message,
    User? sender,
    DateTime? timestamp,
  }) {
    return Chat(
      id: id ?? this.id,
      message: message ?? this.message,
      sender: sender ?? this.sender,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'sender': sender,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'],
      message: map['message'],
      sender: map['sender'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }
}

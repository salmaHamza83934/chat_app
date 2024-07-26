class Message {
  static const String collectionName = 'messages';
  String id;
  String roomId;
  String content;
  String senderId;
  String senderName;
  int dateTime;

  Message(
      {this.id = '',
      required this.roomId,
      required this.content,
      required this.senderId,
      required this.senderName,
      required this.dateTime});

  Message.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          content: json['content'],
          roomId: json['room_id'],
          senderId: json['sender_id'],
          senderName: json['sender_name'],
          dateTime: json['date_time'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'room_id':roomId,
      'content': content,
      'sender_name': senderName,
      'sender_id': senderId,
      'date_time': dateTime,
    };
  }
}

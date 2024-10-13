class Room {
  static const String collectionName='rooms';
  String roomId;
  String title;
  String description;
  String categoryId;

  Room({required this.roomId,required this.title, required this.description, required this.categoryId});

  Room.fromJson(Map<String, dynamic> json) :this(
    roomId: json['roomId'],
    title: json['title'],
    description: json['description'],
    categoryId: json['categoryId'],

  );

  Map<String,dynamic> toJson(){
    return {
      'roomId':roomId,
      'title':title,
      'description':description,
      'categoryId':categoryId
    };
  }
}
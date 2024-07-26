class MyUser {
  static const String collectionName='users';
  String id;
  String userName;
  String email;

  MyUser(
      {required this.id,
      required this.userName,
      required this.email,});

  MyUser.fromJson(Map<String, dynamic> data)
      : this(
          id: data['id'],
          userName: data['userName'],
          email: data['email'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
    };
  }
}

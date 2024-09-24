class UserModel {
  final String id;
  final String email;
  final String name;
  final String photoUrl;
  final bool isVerified = false;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
    };
  }

  static UserModel instance = UserModel(
    id: '',
    email: '',
    name: '',
    photoUrl: '',
  );

  void updateUser(
      {required String uid,
      required String email,
      required String displayName,
      required String photoURL}) {
    instance = UserModel(
      id: uid,
      email: email,
      name: displayName,
      photoUrl: photoURL,
    );
  }
}

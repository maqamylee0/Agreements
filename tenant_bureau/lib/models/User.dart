class UserModel {
  String? uid;
  String? email;
  String? name;
  String? nin;

  UserModel({this.uid, this.email, this.name, this.nin});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      nin: map['nin'],
    );
  }
  factory UserModel.fromJson(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      nin: map['nin'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'nin': nin,
    };
  }
}
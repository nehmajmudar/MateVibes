class UserModel {
  String? uid;
  String? email;
  String? username;
  int? phoneNumber;

  UserModel({this.uid, this.email, this.username, this.phoneNumber});

  //receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      username: map['username'],
      phoneNumber: map['phoneNmber'],
    );
  }
  // sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'phoneNumber': phoneNumber,
    };
  }
}
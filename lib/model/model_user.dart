class UserModel {
  String userid;
  String username;
  String email;


  UserModel(
      {required this.userid,
        required this.username,
        required this.email,
 });
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        userid: map['userid'],
        username: map['username'],
        email: map['email'],
  );
  }
  Map<String, dynamic> tomap() {
    return {
      'userid': userid,
      'username': username,
      'email': email,

    };
  }
}

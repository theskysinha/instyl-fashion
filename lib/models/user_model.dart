class UserModel{
  String firstname;
  String lastname;
  String username;
  String phoneNumber;
  String uid;

  UserModel({
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.phoneNumber,
    required this.uid,
  });

  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
      firstname: map["firstname"],
      lastname: map["lastname"],
      username: map["username"],
      phoneNumber: map["phoneNumber"],
      uid: map["uid"],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      "firstname": firstname,
      "lastname": lastname,
      "username": username,
      "phoneNumber": phoneNumber,
      "uid": uid,
    };
  }
}
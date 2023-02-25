class UserModel {
  String? uid;
  String? userEmail;
  String? userPassword;
  String? userFName;
  String? userLName;
  String? userPNumber;
  String? userDOB;
  String? userPicture;
  String? gender;
  String? desc;
  String? location;
  String? followers;
  String? following;

  UserModel(
      {this.uid,
      this.userEmail,
      this.userPassword,
      this.userFName,
      this.userLName,
      this.userPNumber,
      this.userDOB,
      this.userPicture,
      this.gender,
      this.location,
      this.followers,
      this.following,
      this.desc});

  UserModel.fromMap(map) {
    gender = map["gender"];
    userEmail = map["userEmail"];
    uid = map["uid"];
    userPassword = map["userPassword"];
    userFName = map["userFName"];
    userLName = map["userLName"];
    userPNumber = map["userPNumber"];
    userDOB = map["userDOB"];
    userPicture = map["userPicture"];
    location = map["location"];
    desc = map["desc"];
    followers = map["followers"];
    following = map["following"];
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "userFName": userFName,
      "userLName": userLName,
      "userEmail": userEmail,
      "userPassword": userPassword,
      "userPNumber": userPNumber,
      "userDOB": userDOB,
      "userPicture": userPicture,
      "gender": gender,
      "location": location,
      "desc": desc,
      "followers": followers,
      "following": following,
    };
  }
}

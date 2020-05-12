class User {
  String uid;
  String name;
  String email;
  String username;
  String status;
  int state;
  String profilePhoto;
  String id;
  String coin,binded,vip,phone_no,followers,following,gender,bio,country,callrate,age,onlinetime;

  User({
    this.id,
    this.uid,
    this.name,
    this.email,
    this.profilePhoto,
    this.coin,
    this.binded,
    this.followers,
    this.following,
    this.phone_no,
    this.gender,
    this.bio,
    this.country,
    this.callrate,
    this.age,
    this.onlinetime
  });

  Map toMap(User user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['id'] = user.id;
    data["binded"] = user.binded;
    data["followers"] = user.followers;
    data["following"] = user.following;
    data["profile_photo"] = user.profilePhoto;
    data["coin"] = user.coin;
    data["phone_no"] = user.phone_no;
    data["vip"] = user.vip;
    return data;
  }

  User.fromMap(Map<String, dynamic> mapData) {
    this.id=mapData['Id'];
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.email = mapData['email'];
    this.phone_no=mapData['phone_no'];
    this.profilePhoto = mapData['profile_pic'];
    this.following=mapData['following'];
    this.followers=mapData['followers'];
    this.binded=mapData['binded'];
    this.coin=mapData['Coins'];
    this.vip=mapData['vip'];
    this.gender=mapData['gender'];
    this.bio=mapData['bio'];
    this.country=mapData['country'];
    this.callrate=mapData['callrate'];
    this.age=mapData['age'];
    this.onlinetime=mapData['onlinetime'];
    this.callrate=mapData['callrate'];
  }
}
 class User {
  late final String name;
  late final String picturePath;
  late final String email;
  final String id;

  User({
    required this.name,
    required this.picturePath,
    required this.email,
    required this.id
  });

  User.fromJson(Map <String, dynamic> json)
      : name = json['name'],
        picturePath = json['picturePath'],
        email = json['email'],
        id = json['_id'];


  Map<String, dynamic> toJson(){
    return {
      "name" : this.name,
      "email" : this.email,
      "_id" : this.id,
      "picturePath" : this.picturePath,
    };
  }
}
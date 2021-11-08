 import 'dart:convert';

 class Pet {
  late final String name;
  late final String gender;
  late final String age;
  late final String breed;
  late final String description;
  late final String profileImg;
  final List<ObjectImage> objIMG;
  final DateTime date;
  final String id;

  Pet({
    required this.name,
    required this.gender,
    required this.age,
    required this.breed,
    required this.description,
    required this.profileImg,
    required this.objIMG,
    required this.date,
    required this.id,
  });

  Pet.fromJson(Map <String, dynamic> json)
      : name = json['name'],
        gender = json['gender'],
        age = json['age'],
        breed = json['breed'],
        description = json['description'],
        profileImg = json['profileImg'],
        objIMG = json['objIMG'],
        date = json['date'],
        id = json['_id'];

  Map<String, dynamic> toJson(){
  return {
    "name" : this.name,
    "gender" : this.gender,
    "age" : this.age,
    "breed" : this.breed,
    "description" : this.description,
    "profileImg" : this.profileImg,
    "objIMG" : jsonEncode(this.objIMG),
    "date" : this.date.toString(),
    "id" : this.id,
  };
}
}

class ObjectImage{
  final String name;
  final String token;

  ObjectImage({
    required this.name,
    required this.token
  });

  ObjectImage.fromJson( Map <String, dynamic> json)
    : name = json['name'],
      token = json['token'];

  Map<String, dynamic> toJson(){
    return {
      "name" : this.name,
      "token" : this.token,
    };
  }
}
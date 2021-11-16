 import 'dart:convert';

import 'package:flutterapp2/models/user.dart';

 class Pet {
  late final String name;
  late final String gender;
  late final String age;
  late final String breed;
  late final String description;
  late final String profileImg;
  final List<ObjectImage> objIMG;
  final User user;
  final DateTime date;
  final String id;
  final bool isLost;

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
    required this.user,
    required this.isLost
  });

  Pet.fromJson(Map <String, dynamic> json)
      : name = json['name'],
        gender = json['gender'],
        age = json['age'].toString(),
        breed = json['breed'],
        description = json['description'],
        profileImg = json['profileImg'],
        objIMG = List<ObjectImage>.from(jsonDecode(json["objIMG"]).map((model)=> ObjectImage.fromJson(model))), 
        date = DateTime.parse(json['date']), 
        // jsonDecode(json['date']),
        user = User.fromJson(json['user']),
        isLost = json['isLost'],
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
    "user" :  jsonEncode(this.user),
    "isLost": this.isLost,
    "id" : this.id,
  };
}

  void add(Pet pet) {}
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
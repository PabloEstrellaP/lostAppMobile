import 'dart:convert';

import 'package:flutterapp2/models/pet.dart';
import 'package:flutterapp2/models/user.dart';

class Report {
  final String id; 
  final String description;
  late final Pet pet;
  late final User user;
  final DateTime date;
  final bool isCheked;

  Report({
    required this.id,
    required this.description,
    required this.pet,
    required this.date,
    required this.user,
    required this.isCheked,
  });

  Report.fromJson(Map <String, dynamic> json)
    : id = json['_id'],
      description = json['description'],
      pet = Pet.fromJson(json['pet']),
      user = User.fromJson(json['msgUser']),
      date = DateTime.parse(json['date']), 
      isCheked = json['isCheked'];


  Map<String, dynamic> toJson(){
    return {
      "id" : this.id,
      "description" : this.description,
      "pet" :  jsonEncode(this.pet),
      "user" : jsonEncode(this.user),
      "date" : this.date.toString(),
      "isCheked": this.isCheked.toString(),
    };
  }

}

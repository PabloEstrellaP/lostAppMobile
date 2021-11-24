import 'dart:convert';

import 'package:flutterapp2/models/pet.dart';
import 'package:flutterapp2/models/user.dart';

class Report {
  final String id; 
  final String description;
  late final Pet pet;
  late final User to;
  late final User from;
  final DateTime date;
  final bool isCheked;

  Report({
    required this.id,
    required this.description,
    required this.pet,
    required this.date,
    required this.to,
    required this.from,
    required this.isCheked,
  });

  Report.fromJson(Map <String, dynamic> json)
    : id = json['_id'],
      description = json['description'],
      pet = Pet.fromJson(json['pet']),
      to = User.fromJson(json['to']),
      from = User.fromJson(json['from']),
      date = DateTime.parse(json['date']), 
      isCheked = json['isCheked'];


  Map<String, dynamic> toJson(){
    return {
      "id" : this.id,
      "description" : this.description,
      "pet" :  jsonEncode(this.pet),
      "to" : jsonEncode(this.to),
      "from" : jsonEncode(this.from),
      "date" : this.date.toString(),
      "isCheked": this.isCheked.toString(),
    };
  }

}

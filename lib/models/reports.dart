import 'dart:convert';

import 'package:flutterapp2/models/pet.dart';

class Report {
  final String id; 
  final String description;
  late final Pet pet;
  final DateTime date;
  final bool isCheked;

  Report({
    required this.id,
    required this.description,
    required this.pet,
    required this.date,
    required this.isCheked,
  });

  Report.fromJson(Map <String, dynamic> json)
    : id = json['_id'],
      description = json['description'],
      pet = Pet.fromJson(json['pet']),
      date = DateTime.parse(json['date']), 
      isCheked = json['isCheked'];


  Map<String, dynamic> toJson(){
    return {
      "id" : this.id,
      "description" : this.description,
      "pet" :  jsonEncode(this.pet),
      "date" : this.date.toString(),
      "isCheked": this.isCheked.toString(),
    };
  }

}

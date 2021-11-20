import 'package:flutter/material.dart';

import 'package:flutterapp2/models/reports.dart';

class NotificationItem extends StatelessWidget {
  
  final Report report;
  final Size size;

  const NotificationItem({
    Key? key,
    required this.report,
    required this.size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(251, 242, 240, 1),
      height: 70,
      child: InkWell(
        onTap: (){
          print(this.report.pet.id);
        },
        child: Card(
          color: Color.fromRGBO(251, 242, 240, 1),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(this.report.pet.profileImg),
            ),
            title: Text(this.report.pet.name),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:flutterapp2/models/reports.dart';
import 'package:flutterapp2/pages/chatPage.dart';

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
          Navigator.push(context, PageRouteBuilder(
            pageBuilder: ( _, __, ___ ) => ChatPage(littleReport: this.report),
            transitionDuration: Duration(milliseconds: 0)
          ));
        },
        child: Card(
          color: Color.fromRGBO(251, 242, 240, 1),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(this.report.pet.profileImg),
            ),
            title: Text(this.report.pet.name),
            subtitle: Text(this.report.from.name),
          ),
        ),
      ),
    );
  }
}
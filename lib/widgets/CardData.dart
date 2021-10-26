import 'package:flutter/material.dart';

class CardData extends StatelessWidget {
  final String title;
  final String SubTitle;
  const CardData({Key? key, required this.title, required this.SubTitle }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        // margin: const EdgeInsets.only( ),
        // padding: const EdgeInsets.only( top: 0, bottom: 0),
        width: MediaQuery.of(context).size.width * 0.4,
        // height: MediaQuery.of(context).size.height * 0.092,
        // padding: const EdgeInsets.all(7),
        child: Column(  
          mainAxisSize: MainAxisSize.min,  
          children: <Widget>[  
            Container(
              height: MediaQuery.of(context).size.height * 0.076,
              child: ListTile(  
                leading: Icon( Icons.pets ),  
                title:  Text(this.title,),
                subtitle: Text(this.SubTitle, style: TextStyle( fontSize: 12),),
              ),
            ),  
          ],  
        ),
      ), 
    );
  }
}
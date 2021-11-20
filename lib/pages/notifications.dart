import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';

import 'package:flutterapp2/models/reports.dart';
import 'package:flutterapp2/services/reportsService.dart';
import 'package:flutterapp2/widgets/SideMenu.dart';
import 'package:flutterapp2/widgets/notificationItem.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutterapp2/widgets/curvePainter.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Report> data = [];
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: NavDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                Container(
                  height: size.height * 0.15,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: CurvedPainter(),
                    child: Container(
                      margin: const EdgeInsets.only( top: 2, left: 20, right: 20),
                      child: Column(
                        children: [
                          BorderedText(
                            strokeWidth: 2,
                            strokeColor: Colors.black,
                            child: Text('Notifications', style: GoogleFonts.pacifico(
                                textStyle: TextStyle(
                                  color: Colors.white, 
                                  fontSize: size.height * 0.04,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),                  
                ),
                Container(
                  height: size.height * 0.85,
                  child: FutureBuilder(
                    future: _getReports(),
                    builder:(context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                      } else {
                        return Container(
                            child: ListView.builder(                                                  
                              itemCount: data.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                return NotificationItem( report: data[index], size: size, );                               
                              }, 
                            )
                        );
                      }
                    }
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  Future<Object> _getReports() async {
    data = [];
    final response = await ReportsService.getReports();
    for( var dataJson in response['msg']){
      data.add(new Report.fromJson(dataJson));
    }
    return data;
  }
}
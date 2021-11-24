import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutterapp2/models/reports.dart';
import 'package:flutterapp2/models/user.dart';
import 'package:flutterapp2/services/googleSignInService.dart';
import 'package:flutterapp2/services/reportsService.dart';
import 'package:flutterapp2/widgets/chatMessage.dart';




class ChatPage extends StatefulWidget{

  final Report? littleReport;

  ChatPage({
    Key? key, 
    this.littleReport
  }) : super(key: key);


  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  
 

  List<ChatMessage> _messages = [];
  User? user;
  Report? stateReport;
  Report? newReport;

  bool _estaEscribiendo = false;

  @override
  void initState() {
    stateReport = widget.littleReport; 
    _getAllUserDataRegister();
    super.initState();
    _cargarHistorial();
  } 
  
  Future<User?> _getAllUserDataRegister() async {
    user = await GoogleSignInService.getAllUserData(); 
    return user;
  }
  void _cargarHistorial( /*String usuarioID*/ ) async {
    List<Report> chat = [];
    final response = await ReportsService.getChat( stateReport! );
    for( var dataJson in response['msg']){
      chat.add(new Report.fromJson(dataJson));
    }

    final history = chat.map((m) => new ChatMessage(
      texto: m.description,
      uid: m.from.id,
      myUser: user!,
      animationController: new AnimationController(vsync: this, duration: Duration( milliseconds: 0))..forward(),
    ));

    setState(() {
      _messages.insertAll(0, history);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(stateReport!.from.picturePath),
              maxRadius: 14,
            ),
            SizedBox( height: 3 ),
            Text( stateReport!.from.name, style: TextStyle( color: Colors.black87, fontSize: 12))
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),

      body: Container(
        child: Column(
          children: <Widget>[
            
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
              )
            ),

            Divider( height: 1 ),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
   );
  }

  Widget _inputChat() {

    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric( horizontal: 8.0 ),
        child: Row(
          children: <Widget>[

            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit ,
                onChanged: ( texto ){
                  setState(() {
                    if ( texto.trim().length > 0 ) {
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar mensaje'
                ),
                focusNode: _focusNode,
              )
            ),

            // Botón de enviar
            Container(
              margin: EdgeInsets.symmetric( horizontal: 4.0 ),
              child: Platform.isIOS 
              ? CupertinoButton(
                child: Text('Enviar'), 
                onPressed: _estaEscribiendo 
                  ? () => _handleSubmit( _textController.text.trim() )
                  : null,
              )
              
              : Container(
                margin: EdgeInsets.symmetric( horizontal: 4.0 ),
                child: IconTheme(
                  data: IconThemeData( color: Colors.blue[400] ),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon( Icons.send ),
                    onPressed: _estaEscribiendo 
                      ? () => _handleSubmit( _textController.text.trim() )
                      : null,
                  ),
                ),
              ),
            )

          ],
        ),
      )
    );

  }


  _handleSubmit(String texto ) async{

    if ( texto.length == 0 ) return;
    _textController.clear();
    _focusNode.requestFocus();

    newReport = Report(
      id: 'Ejemplo', 
      description: texto, 
      pet: stateReport!.pet, 
      date: new DateTime.now(), 
      to: stateReport!.from, 
      from: user!,
      isCheked: true
    );
    
    final newMessage = new ChatMessage(
      uid: user!.id, 
      texto: texto,
      myUser: user!,
      animationController: AnimationController(vsync: this, duration: Duration( milliseconds: 200 )),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() { _estaEscribiendo = false; });

    final repsonse = await ReportsService.addReports( newReport! );
  }

  @override
  void dispose() {
    super.dispose();
  }

}
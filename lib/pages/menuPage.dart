import 'package:flutter/material.dart';
import 'package:flutterapp2/models/pet.dart';
import 'package:flutterapp2/pages/petDetails.dart';
import 'package:flutterapp2/services/petsService.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key? key,}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Pet> data = [];
  // final List<User> data = <User>[];
 
  // @override
  // void initState (){
  //   super .initState ();
  //   _getUsers();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu page'),
      ),
      body: FutureBuilder(
      future: _getUsers(),
      builder:(context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
          } else {
            return Container(
                child: ListView.builder(                                                  
                  itemCount: data.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(  
                        mainAxisSize: MainAxisSize.min,  
                        children: <Widget>[  
                          ListTile(
                            onTap: () async{
                              print(data[index].id);
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PetDetailsPage( littlePet: data[index] )));
                              Navigator.pushNamed(context, 'edit');
                            },  
                            leading: Image.network(data[index].profileImg),  
                            title:  Text( '${ data[index].name}'),  
                            subtitle: Text( data[index].gender ),  
                          ),  
                        ],  
                      ),  
                    );                                       
                  }
                )
            );
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, 'petRegi');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<Object> _getUsers() async {
    data = [];
    final response = await PetService.getPets();
    for( var dataJson in response['msg']){
      data.add(Pet.fromJson(dataJson));
    }
    return data.toList();
  }
}
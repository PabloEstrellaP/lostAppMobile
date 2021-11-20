import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage('https://i.pinimg.com/564x/af/8d/63/af8d63a477078732b79ff9d9fc60873f.jpg')
              )
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Menú'),
            onTap: () => {Navigator.pushReplacementNamed(context, '/')},
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notificaciones'),
            onTap: () => {Navigator.pushReplacementNamed(context, 'notifications')},
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Perfil'),
            onTap: () => {Navigator.pushReplacementNamed(context, 'profile')},
          ),
        ],
      ),
    );
  }
}
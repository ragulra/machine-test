
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  User user;
  MenuDrawer(this.user);
  @override

  Widget _header(){
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(),
      child: 
      Padding(
        padding: new EdgeInsets.only(top:20.0),
        child: Center(
          child: Column(children: <Widget>
            [
              Text( this.user.email != null ? '${this.user.email}' : '${this.user.phoneNumber}' ,  style: TextStyle(color: Colors.white, fontSize: 14.0,  fontWeight: FontWeight.w500)),
              Text( "${user.uid}" ,  style: TextStyle(color: Colors.white, fontSize: 13.0,  fontWeight: FontWeight.w500))
            ]
          ),
        ),
      )
    );
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: Colors.green,
              child: _header()
              ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout), 
              title: Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut().then((value){
                    Navigator.pushReplacementNamed(context, "/login");
                });
              },
            ),
          ],
        ),
      ),
    );
  }
  
  }
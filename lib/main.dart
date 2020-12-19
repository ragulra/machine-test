import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './view%20models/menudata_list_view_model.dart';
import './routes.dart' as route ;
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(
      MultiProvider(providers:
      [
        ChangeNotifierProvider<MenuListViewModel>(create: (context) =>  MenuListViewModel()),
      ],
        child: MeachineTestApp()
      ),
    );
  } 

class MeachineTestApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      title: "Machine Test",  
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primarySwatch: Colors.green,
      accentColor: Colors.white,
      fontFamily: 'Georgia',
      textTheme: TextTheme(
        headline: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
        title: TextStyle(fontSize: 30.0, fontStyle: FontStyle.italic),
        body1: TextStyle(fontSize: 12.0, fontFamily: 'Hind'),
       )
      ),
       onGenerateRoute: route.generateRoute
    );
  }
}
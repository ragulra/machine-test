import 'package:flutter/material.dart';
import './pages/orderSummary.dart';
import './pages/login.dart';


Route<dynamic> generateRoute(RouteSettings settings){

  switch (settings.name){
    case '/':
      return MaterialPageRoute(builder: (context) => LoginPage());
    case '/login':
      return MaterialPageRoute(builder: (context) => LoginPage());
    case '/orderSummary':
        return MaterialPageRoute(builder: (context) => OrderSummaryPage());
    default:
      return MaterialPageRoute(builder: (context) => LoginPage());
  }
}

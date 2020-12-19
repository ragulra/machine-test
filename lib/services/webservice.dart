import 'dart:convert';
import 'package:meachine_test/models/tableMeanuList.dart';
import 'package:http/http.dart' as http; 

class Webservice {

  Future<MenusList> fetchMenListData() async {
    final JsonDecoder _decoder = new JsonDecoder();

    final url = "https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad";
    final response = await http.get(url);
    if(response.statusCode == 200)
    {
      final rawData = _decoder.convert(response.body);
      return MenusList.fromJson(rawData[0]);
    }
     else 
    {
      throw Exception("Unable to perform request!");
    }
  }
}

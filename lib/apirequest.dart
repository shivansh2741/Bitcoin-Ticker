import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String api_key = '89c556b92e2297f14faed3f9ddc160cfe58942cb';
String api = 'af25e68d-f6c6-42bc-87ee-9942c6a7fa90';

class MakeRequest {
  Future<dynamic> getdata(String currency) async {
    Uri url = Uri.parse(
        'https://api.nomics.com/v1/currencies/ticker?key=$api_key&ids=BTC&convert=$currency');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var fetcheddata = jsonDecode(response.body);
      print(response.statusCode);
      print(fetcheddata[0]['price']);
      return fetcheddata[0]['price'];
    } else {
      print(response.statusCode);
    }
  }
}

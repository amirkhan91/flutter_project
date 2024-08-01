import 'dart:convert';

import 'package:test_proj/dependency_injection/dependency_model.dart';
import 'package:http/http.dart' as http;

class QuoteApi{
  Future<DependencyModel> getData()async{
    var url = "https://some-random-api.ml/animu/quote";
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    Map<String,dynamic> singleQuoteJson = jsonDecode(response.body);
    return DependencyModel.fromJson(singleQuoteJson);
  }
}
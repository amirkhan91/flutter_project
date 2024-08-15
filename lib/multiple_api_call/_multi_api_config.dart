import 'package:test_proj/multiple_api_call/multi_api_model1.dart';
import 'package:http/http.dart' as http;
import 'package:test_proj/multiple_api_call/multi_api_model2.dart';

class MultiApiCall {
  Future<ApiCall1> fetchData1() async {
    var url = "https://reqres.in/api/users?page";
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      return apiCall1FromJson(response.body.toString());
    } else {
      throw "Something went wrong: ${response.statusCode}";
    }
  }

  Future<ApiCall2> fetchData2() async {
    var url = "https://dummy.restapiexample.com/api/v1/employees";
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      return apiCall2FromJson(response.body.toString());
    } else {
      throw "Something went wrong: ${response.statusCode}";
    }
  }

  Future<List<dynamic>> fetchMultipleApi() async {
    try {
      final results = await Future.wait([fetchData1(), fetchData2()]);
      return results;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

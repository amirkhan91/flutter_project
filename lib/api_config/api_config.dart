import 'package:test_proj/phone_bloc/phone_model.dart';
import 'package:http/http.dart' as http;

class ApiCongig {
  Future<List<PhoneModel>> getPhoneData() async {
    var url = "https://api.restful-api.dev/objects";
    var uri = Uri.parse(url);
    var response = await http.get(uri).timeout(const Duration(seconds: 20));
    if (response.statusCode == 200) {
      return phoneModelFromJson(response.body.toString());
    } else {
      throw "Something Went Wrong: ${response.statusCode}";
    }
  }
}

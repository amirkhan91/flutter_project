import 'package:http/http.dart' as http;
import 'package:test_proj/unit_test/employee_model.dart';

class UserApi {
  Future<EmployeeModel> fetchEmpData() async {
    var url = "https://dummy.restapiexample.com/api/v1/employees";
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      return employeeModelFromJson(response.body.toString());
    } else {
      throw "Something went worng: ${response.statusCode}";
    }
  }
}

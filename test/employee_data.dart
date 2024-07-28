import 'package:flutter_test/flutter_test.dart';
import 'package:test_proj/unit_test/employee_model.dart';
import 'package:test_proj/unit_test/user_api.dart';

void main(){
 late  UserApi userApi ;
  setUp((){
    userApi = UserApi();
  });
 group('User Repository - ', (){
  group('getUser fucntion', (){
    test('given UserRepository class when getUserfucntion is called and status code is 200 then a usermodel should be returned', 
    ()async{
      // Arrange
      // Act
      final user = await userApi.fetchEmpData();
      // Assert
      expect(user, isA<EmployeeModel>());
    });
    test('given UserRepository class when getUser function is called and status code is not 200 then and exception should be thrown', 
    ()async{
   // Arrange
   // Act
   final user = await userApi.fetchEmpData();
    // Assert
    expect(user, throwsException);
    });
  });
 });
}
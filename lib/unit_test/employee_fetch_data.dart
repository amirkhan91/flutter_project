import 'package:flutter/material.dart';
import 'package:test_proj/unit_test/employee_model.dart';
import 'package:test_proj/unit_test/user_api.dart';

class EmployeeData extends StatefulWidget {
  const EmployeeData({super.key});

  @override
  State<EmployeeData> createState() => _EmployeeDataState();
}

class _EmployeeDataState extends State<EmployeeData> {
  Future<EmployeeModel> empModel = UserApi().fetchEmpData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Data'),
      ),
      body: FutureBuilder(
          future: empModel,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: Text('${snapshot.data}'),
            );
          }),
    );
  }
}

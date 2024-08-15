import 'package:flutter/material.dart';
import 'package:test_proj/multiple_api_call/_multi_api_config.dart';
import 'package:test_proj/multiple_api_call/multi_api_model1.dart';
import 'package:test_proj/multiple_api_call/multi_api_model2.dart';

class MultiResponsePage extends StatefulWidget {
  const MultiResponsePage({super.key});

  @override
  State<MultiResponsePage> createState() => _MultiResponsePageState();
}

class _MultiResponsePageState extends State<MultiResponsePage> {
  MultiApiCall multiApiCall = MultiApiCall();
  ApiCall1? apiCall1 ;
  ApiCall2? apiCall2;
  bool isLoading = true;
  String errorMessage = '';
  @override
  void initState() {
    super.initState();
    fetchMultiApiData();
  }
  Future<void> fetchMultiApiData()async{
    try{
      final results = await multiApiCall.fetchMultipleApi();
      setState(() {
        apiCall1 = results[0] as ApiCall1?;
        apiCall2 = results[1] as ApiCall2?;
        isLoading =false;
      });
    }catch(e){}
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiple API Calls'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text('Error: $errorMessage'))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      apiCall1 != null
                          ? DataTable(
                              columns: const [
                                DataColumn(label: Text('ID')),
                                DataColumn(label: Text('Email')),
                                DataColumn(label: Text('First Name')),
                                DataColumn(label: Text('Last Name')),
                              ],
                              rows: apiCall1!.data!
                                  .map(
                                    (datum) => DataRow(cells: [
                                      DataCell(Text(datum.id.toString())),
                                      DataCell(Text(datum.email ?? '')),
                                      DataCell(Text(datum.firstName ?? '')),
                                      DataCell(Text(datum.lastName ?? '')),
                                    ]),
                                  )
                                  .toList(),
                            )
                          : Container(),
                      apiCall2 != null
                          ? DataTable(
                              columns: const [
                                DataColumn(label: Text('ID')),
                                DataColumn(label: Text('Name')),
                                DataColumn(label: Text('Salary')),
                                DataColumn(label: Text('Age')),
                              ],
                              rows: apiCall2!.data!
                                  .map(
                                    (datum) => DataRow(cells: [
                                      DataCell(Text(datum.id.toString())),
                                      DataCell(Text(datum.employeeName ?? '')),
                                      DataCell(Text(datum.employeeSalary.toString())),
                                      DataCell(Text(datum.employeeAge.toString())),
                                    ]),
                                  )
                                  .toList(),
                            )
                          : Container(),
                    ],
                  ),
                ),
    );
  }
}

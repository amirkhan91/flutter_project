import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class HomePageData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/details'),
          child: Text('Go to Details'),
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details Page')),
      body: Center(child: Text('Details Page')),
    );
  }
}
//.................................
// import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ApiCallsScreen(),
    );
  }
}

class ApiCallsScreen extends StatefulWidget {
  @override
  _ApiCallsScreenState createState() => _ApiCallsScreenState();
}

class _ApiCallsScreenState extends State<ApiCallsScreen> {
  bool isLoading = true;
  String data1 = '';
  String data2 = '';
  String data3 = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Simulate multiple API calls
      Future<String> apiCall1 = Future.delayed(Duration(seconds: 2), () => 'Data from API 1');
      Future<String> apiCall2 = Future.delayed(Duration(seconds: 3), () => 'Data from API 2');
      Future<String> apiCall3 = Future.delayed(Duration(seconds: 1), () => 'Data from API 3');

      // Wait for all API calls to complete
      List<String> results = await Future.wait([apiCall1, apiCall2, apiCall3]);

      setState(() {
        data1 = results[0];
        data2 = results[1];
        data3 = results[2];
        isLoading = false;
      });
    } catch (e) {
      // Handle errors if needed
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Multiple API Calls')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('API 1: $data1'),
                  SizedBox(height: 8.0),
                  Text('API 2: $data2'),
                  SizedBox(height: 8.0),
                  Text('API 3: $data3'),
                ],
              ),
            ),
    );
  }
}

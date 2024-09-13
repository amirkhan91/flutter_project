// import 'dart:async';
// import 'package:flutter/material.dart';



// class StreamBuilderExample extends StatelessWidget {
//   // A stream that emits an integer every second
//   Stream<int> numberStream() {
//     return Stream.periodic(Duration(seconds: 1), (count) => count).take(10);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('StreamBuilder Example')),
//         body: Center(
//           child: StreamBuilder<int>(
//             stream: numberStream(),
//             builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator(); // Show a loader while waiting for data
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else if (snapshot.hasData) {
//                 return Text('Number: ${snapshot.data}');
//               } else {
//                 return Text('Stream ended');
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HomePageSHPR extends StatefulWidget {
  @override
  _HomePageSHPRState createState() => _HomePageSHPRState();
}

class _HomePageSHPRState extends State<HomePageSHPR> {
  final TextEditingController _controller = TextEditingController();
  String _savedValue = '';

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('key', _controller.text);
  }

  Future<void> _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedValue = prefs.getString('key') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SharedPreferences Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter value'),
            ),
            ElevatedButton(
              onPressed: () {
                _saveData();
              },
              child: Text('Save'),
            ),
            SizedBox(height: 20),
            Text('Saved value: $_savedValue'),
          ],
        ),
      ),
    );
  }
}

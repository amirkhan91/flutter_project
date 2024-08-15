import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DesignPage extends StatefulWidget {
  const DesignPage({super.key});

  @override
  State<DesignPage> createState() => _DesignPageState();
}

class _DesignPageState extends State<DesignPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.star),
                    Text("Save"),
                    Text("Rs.500"),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.star),
                    Text("Save"),
                    Text("Rs.500"),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.star),
                    Text("Save"),
                    Text("Rs.500"),
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [Colors.red, Colors.blue],
                  radius: 1,
                ),
              ),
            ),
            const Divider(
              thickness: 5,
              color: Colors.red,
            ),
            const Column(
              children: [
                Icon(Icons.star),
                Text("Save"),
                Text("Rs.500"),
              ],
            ),
            const Column(
              children: [
                Icon(Icons.star),
                Text("Save"),
                Text("Rs.500"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_proj/bloc_send_data_one_sec/first_bloc/first_event.dart';
import 'package:test_proj/bloc_send_data_one_sec/second_bloc/second_event.dart';

class MergeBlocDataq extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloc Data"),
      ),
      body: Center(
        child:Container(
          width: 300,
          height: 300,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops:[0.1,0.7],
              colors: [
                Colors.red,
                Colors.green
              ]
            )
          )
        )
      )
    );
  }
}

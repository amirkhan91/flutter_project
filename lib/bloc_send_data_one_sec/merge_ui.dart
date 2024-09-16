

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_proj/bloc_send_data_one_sec/first_bloc/first_event.dart';
import 'package:test_proj/bloc_send_data_one_sec/second_bloc/second_event.dart';

class MergeBlocData extends StatelessWidget {
  const MergeBlocData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloc Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                // Trigger event in FirstBloc to send data to SecondBloc
                context.read<FirstBloc>().add(SendDataToSecondBlocEvent(
                    name: 'John',
                    number: "1234567890",
                    email: "john@gmail.com"));
              },
              child: const Text("Send Data to SecondBloc"),
            ),
            const SizedBox(height: 20),
            // BlocListener to listen for state changes in FirstBloc
            BlocListener<FirstBloc, FirstState>(
              listener: (context, state) {
                if (state is FirstDataSentState) {
                  // When data is sent from FirstBloc, trigger the event in SecondBloc
                  context.read<SecondBloc>().add(ReceiveDataFromFirstBlocEvent(
                      name: state.name,
                      number: state.number,
                      email: state.email));
                }
              },
              child: BlocBuilder<SecondBloc, SecondState>(
                builder: (context, state) {
                  // Show loader while data is being processed
                  if (state is SecondLoadingState) {
                    return const CircularProgressIndicator();
                  }

                  // Show the received data once SecondBloc has processed it
                  if (state is SecondDataReceivedState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${state.name}'),
                        Text('Number: ${state.number}'),
                        Text('Email: ${state.email}'),
                      ],
                    );
                  }

                  // Initially, just show a placeholder before any action
                  return const Text('Click the button to send data');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// git remote add origin https://github.com/amirkhan91/flutter_project.git
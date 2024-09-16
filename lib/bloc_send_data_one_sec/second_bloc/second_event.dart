// Second Event

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SecondEvent {}

class ReceiveDataFromFirstBlocEvent extends SecondEvent {
  final String name;
  final String number;
  final String email;
  ReceiveDataFromFirstBlocEvent(
      {required this.name, required this.number, required this.email});
}

//Second State

abstract class SecondState {}

class SecondInitialState extends SecondState {}
class SecondLoadingState extends SecondState {}

class SecondDataReceivedState extends SecondState {
  final String name;
  final String number;
  final String email;
  SecondDataReceivedState(
      {required this.name, required this.number, required this.email});
}


// SecondBloc implementation

class SecondBloc extends Bloc<SecondEvent, SecondState> {
  SecondBloc() : super(SecondInitialState()) {
    on<ReceiveDataFromFirstBlocEvent>(_onReceiveDataFromFirstBlocEvent);
  }

  void _onReceiveDataFromFirstBlocEvent(
      ReceiveDataFromFirstBlocEvent event, Emitter<SecondState> emit) async {
    // Emit a loading state before fetching the data
    emit(SecondLoadingState());

    // Simulate some delay to mimic data fetching
    await Future.delayed(const Duration(seconds: 2));

    // Emit the state with the received data after the delay
    emit(SecondDataReceivedState(
      name: event.name,
      number: event.number,
      email: event.email,
    ));
  }
}

// First Event
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FirstEvent {}

class SendDataToSecondBlocEvent extends FirstEvent {
  final String name;
  final String number;
  final String email;
  SendDataToSecondBlocEvent(
      {required this.name, required this.number, required this.email});
}

// First State
abstract class FirstState {}

class FirstInitialState extends FirstState {}

class FirstDataSentState extends FirstState {
  final String name;
  final String number;
  final String email;
  FirstDataSentState(
      {required this.name, required this.number, required this.email});
}

//First Bloc Implementation

class FirstBloc extends Bloc<FirstEvent, FirstState> {
  FirstBloc() : super(FirstInitialState()) {
    on<SendDataToSecondBlocEvent>(_onSendDataToSecondBlocEvent);
  }

  void _onSendDataToSecondBlocEvent(
      SendDataToSecondBlocEvent event, Emitter<FirstState> emit) {
    emit(FirstDataSentState(
        name: event.name, number: event.number, email: event.email));
  }
}

import 'package:test_proj/phone_bloc/phone_model.dart';

abstract class PhoneState {}

class PhoneInitialState extends PhoneState {}

class PhoneLoadingState extends PhoneState {}

class PhoneErrorState extends PhoneState {
  final String msg;
  PhoneErrorState(this.msg);
}

class PhoneResponseState extends PhoneState {
  final List<PhoneModel> phoneModel;
  PhoneResponseState(this.phoneModel);
}

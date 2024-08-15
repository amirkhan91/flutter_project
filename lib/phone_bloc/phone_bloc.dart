import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_proj/api_config/api_config.dart';
import 'package:test_proj/phone_bloc/phone_emit.dart';
import 'package:test_proj/phone_bloc/phone_state.dart';

class PhoneBloc extends Bloc<PhoneEmit, PhoneState>{
  final ApiCongig _apiCongig;
  PhoneBloc(this._apiCongig):super(PhoneInitialState());
  Future<void> fetchPhoneData()async{
    emit(PhoneInitialState());
    try{
      final response = await _apiCongig.getPhoneData();
      emit(PhoneResponseState(response));
    }catch(e){
      emit(PhoneErrorState(e.toString()));
    }
  }
}
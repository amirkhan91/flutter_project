import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_proj/api_config/api_config.dart';
import 'package:test_proj/phone_bloc/phone_bloc.dart';
import 'package:test_proj/phone_bloc/phone_state.dart';
import 'package:test_proj/phone_bloc/phone_model.dart';

// Mock class for ApiConfig
class MockApiConfig extends Mock implements ApiCongig {}

void main() {
  late MockApiConfig mockApiConfig;
  late PhoneBloc phoneBloc;

  setUp(() {
    mockApiConfig = MockApiConfig();
    phoneBloc = PhoneBloc(mockApiConfig);
  });

  tearDown(() {
    phoneBloc.close();
  });

  group('PhoneBloc', () {
    final phoneModels = [
      PhoneModel(id: '1', name: 'Phone 1'), 
      PhoneModel(id: '2', name: 'Phone 2')
    ];

    blocTest<PhoneBloc, PhoneState>(
      'emits [PhoneInitialState, PhoneResponseState] when fetchPhoneData is successful',
      build: () {
        when(mockApiConfig.getPhoneData()).thenAnswer((_) async => phoneModels);
        return phoneBloc;
      },
      act: (bloc) => bloc.fetchPhoneData(),
      expect: () => [
        PhoneInitialState(),
        PhoneResponseState(phoneModels),
      ],
      verify: (_) {
        verify(mockApiConfig.getPhoneData()).called(1);
      },
    );

    blocTest<PhoneBloc, PhoneState>(
      'emits [PhoneInitialState, PhoneErrorState] when fetchPhoneData fails',
      build: () {
        when(mockApiConfig.getPhoneData()).thenThrow(Exception('Failed to fetch data'));
        return phoneBloc;
      },
      act: (bloc) => bloc.fetchPhoneData(),
      expect: () => [
        PhoneInitialState(),
        PhoneErrorState('Exception: Failed to fetch data'),
      ],
      verify: (_) {
        verify(mockApiConfig.getPhoneData()).called(1);
      },
    );
  });
}

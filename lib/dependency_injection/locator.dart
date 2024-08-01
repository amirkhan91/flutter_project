import 'package:get_it/get_it.dart';
import 'package:test_proj/dependency_injection/dependency_api.dart';
import 'package:test_proj/dependency_injection/quote_controller.dart';

final locator = GetIt.instance;
void setupLocator(){
  locator.registerLazySingleton<QuoteApi>(()=> QuoteApi());
  locator.registerLazySingleton<QuoteController>(()=> QuoteController());
}
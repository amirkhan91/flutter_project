import 'package:test_proj/dependency_injection/dependency_api.dart';
import 'package:test_proj/dependency_injection/dependency_model.dart';
import 'package:test_proj/dependency_injection/locator.dart';

class QuoteController{
  Future<DependencyModel> getQuote()async{
    return locator.get<QuoteApi>().getData();
  }
}
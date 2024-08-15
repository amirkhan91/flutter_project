import 'package:flutter/material.dart';
import 'package:test_proj/dependency_injection/dependency_model.dart';
import 'package:test_proj/dependency_injection/locator.dart';
import 'package:test_proj/dependency_injection/quote_controller.dart';
class QuoteView extends StatefulWidget {
  const QuoteView({super.key});

  @override
  State<QuoteView> createState() => _QuoteViewState();
}

class _QuoteViewState extends State<QuoteView> {
  DependencyModel? dependencyModel;
  Future<void> _changeQuote()async{
    DependencyModel model = await locator.get<QuoteController>().getQuote();
    setState(() {
      dependencyModel = model;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Quote View'),
      ),
      body: Center(
        child: dependencyModel ==null
        ?const Text("No Data")
        : Padding(padding: EdgeInsets.symmetric(horizontal: 15),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('"${dependencyModel?.sentence?? ""}"',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontStyle: FontStyle.normal),),
          const  SizedBox(
              height: 10,
            ),
            Text("- ${dependencyModel?.character?? ""}")
          ],
        ),)
      ),
    );
  }
}

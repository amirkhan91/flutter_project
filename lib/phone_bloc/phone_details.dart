import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_proj/phone_bloc/phone_bloc.dart';
import 'package:test_proj/phone_bloc/phone_state.dart';

class PhoneDetailPage extends StatefulWidget {
  const PhoneDetailPage({super.key});

  @override
  State<PhoneDetailPage> createState() => _PhoneDetailPageState();
}

class _PhoneDetailPageState extends State<PhoneDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final bloc = context.read<PhoneBloc>();
      bloc.fetchPhoneData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PhoneBloc, PhoneState>(
        builder: (context, state) {
          if (state is PhoneInitialState || state is PhoneLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PhoneResponseState) {
            final response = state.phoneModel;
            return ListView.builder(
                itemCount: response.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [Text(response[index].id.toString()),
                      Text(response[index].name.toString()),
                      
                      ],
                    ),
                  );
                });
          } else if (state is PhoneErrorState) {
            return Text(state.msg);
          }
          return Center(
            child: Text(state.toString()),
          );
        },
      ),
    );
  }
}

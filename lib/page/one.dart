import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigator_2_test2/cubit/navigator.dart';

class One extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('1'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<NavigatorCubit>().pushNamed('/two');
          },
          child: Text('跳转第二页'),
        ),
      ),
    );
  }
}

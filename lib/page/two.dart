import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigator_2_test2/cubit/navigator.dart';

class Two extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('2'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<NavigatorCubit>().pushNamed('/three/2?a=2&xx=cc', data: {"aaa": 222});
          },
          child: Text('携带参数跳转第三页'),
        ),
      ),
    );
  }
}

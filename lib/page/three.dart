import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigator_2_test2/cubit/navigator.dart';

class Three extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('我是path参数${context.read<NavigatorCubit>().current.pathParameters}'),
                Text('我是query参数${context.read<NavigatorCubit>().current.queryParameters}'),
                Text('我是data参数${context.read<NavigatorCubit>().current.data}'),
                ElevatedButton(
                  onPressed: () {
                    context.read<NavigatorCubit>().pushNamed('/three/44?oo=pp');
                  },
                  child: Text('携带pathParameters和queryParameters再次跳转本页'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

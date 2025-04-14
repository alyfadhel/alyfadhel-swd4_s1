import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swd4_s1/features/counter/presentation/controller/cubit/cubit.dart';
import 'package:swd4_s1/features/counter/presentation/controller/cubit/state.dart';
import 'package:swd4_s1/features/counter/presentation/screens/page_one.dart';

// 1- constructor
//2- init state
//3- build
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {
          if (state is CounterIncreaseState) {
            debugPrint('Counter Increase');
          }

          if (state is CounterDecreaseState) {
            debugPrint('Counter Decrease');
          }
        },
        builder: (context, state) {
          var cubit = CounterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          cubit.counterDecrease();
                        },
                        icon: Icon(Icons.remove, size: 50, color: Colors.blue),
                      ),
                      SizedBox(width: 20.0),
                      Text(
                        '${cubit.count}',
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 20.0),
                      IconButton(
                        onPressed: () {
                          cubit.counterIncrease();
                        },
                        icon: Icon(Icons.add, size: 50, color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => PageOne()),
                      );
                    },
                    color: Colors.blue,
                    child: Text(
                      'Tap',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

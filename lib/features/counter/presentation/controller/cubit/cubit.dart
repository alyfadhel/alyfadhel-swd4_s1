import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swd4_s1/features/counter/presentation/controller/cubit/state.dart';

class CounterCubit extends Cubit<CounterStates>
{
  CounterCubit():super(CounterInitialState());

  static CounterCubit get(context)=>BlocProvider.of(context);

  int count = 0;

  void counterDecrease()
  {
    count --;
    emit(CounterDecreaseState());
  }

  void counterIncrease()
  {
    count ++;
    emit(CounterIncreaseState());
  }
}
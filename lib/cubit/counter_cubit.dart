import 'counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterCubitState>{
  CounterCubit() : super(CounterInitCubitState(0));

  void increment() async {
    int counter = state.counter;
    counter++;

    emit(CounterResultCubitState(counter));
  }

  void decrement() async {
    int counter = state.counter;
    counter--;

    emit(CounterResultCubitState(counter));
  }
}

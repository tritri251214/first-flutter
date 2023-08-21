import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutters/BloC/counter_event.dart';
import 'package:flutters/BloC/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterBlocState>{
  CounterBloc() : super(CounterInitBlocState(0)) {
    on<CounterIncrementEvent>((event, emit) {
      int counter = state.counter;
      counter++;
      emit(CounterResultBlocState(counter));
    });

    on<CounterDecrementEvent>((event, emit) {
      int counter = state.counter;
      counter--;
      emit(CounterResultBlocState(counter));
    });
  }
}

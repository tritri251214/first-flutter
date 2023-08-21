abstract class CounterCubitState {
  late final int counter;

  @override
  CounterCubitState(this.counter);
}

class CounterInitCubitState extends CounterCubitState {
  CounterInitCubitState(int counter) : super(0);
}

class CounterResultCubitState extends CounterCubitState {
  CounterResultCubitState(int counter) : super(counter);
}

abstract class CounterBlocState {
  late final int counter;

  @override
  CounterBlocState(this.counter);
}

class CounterInitBlocState extends CounterBlocState {
  CounterInitBlocState(int counter) : super(0);
}

class CounterResultBlocState extends CounterBlocState {
  CounterResultBlocState(int counter) : super(counter);
}

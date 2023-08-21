import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutters/BloC/counter_bloc.dart';
import 'package:flutters/BloC/counter_event.dart';
import 'package:flutters/BloC/counter_state.dart';
import 'package:flutters/cubit/counter_state.dart';
import 'package:flutters/cubit/counter_cubit.dart';
import 'package:flutters/widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CounterBloc counterBloc = CounterBloc();
  final CounterCubit counterCubit = CounterCubit();

  void _onDecrement() {
    counterBloc.add(CounterDecrementEvent());
    counterCubit.decrement();
  }

  void _onIncrement() {
    counterBloc.add(CounterIncrementEvent());
    counterCubit.increment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Home Screen'),
        )
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.grey[200],
        child: Column(
          children: [
            const ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              child: Image(image: AssetImage('assets/images/bg_home.png')),
            ),
            const SizedBox(height: 20),
            CubitContainer(counterCubit: counterCubit),
            const SizedBox(height: 20),
            BlocContainer(counterBloc: counterBloc),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: UniqueKey(),
            tooltip: 'Decrement',
            onPressed: _onDecrement,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: UniqueKey(),
            tooltip: 'Increment',
            onPressed: _onIncrement,
            child: const Icon(Icons.add),
          ),
        ]
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(
        selectedMenu: 'home'
      ),
    );
  }
}

class CubitContainer extends StatelessWidget {
  const CubitContainer({
    super.key,
    required this.counterCubit,
  });

  final CounterCubit counterCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (_) => counterCubit,
      child: BlocBuilder<CounterCubit, CounterCubitState>(
        builder: (context, state) => Text(
          'Count use Cubit: ${state.counter}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
        ),
      ),
    );
  }
}

class BlocContainer extends StatelessWidget {
  const BlocContainer({
    super.key,
    required this.counterBloc,
  });

  final CounterBloc counterBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (_) => counterBloc,
      child: BlocBuilder<CounterBloc, CounterBlocState>(
        builder: (context, state) => Text(
          'Count use BloC: ${state.counter}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
        ),
      ),
    );
  }
}

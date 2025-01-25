import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/counter_cubit.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shape: const Border(
          bottom: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.purple.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BlocConsumer<CounterCubit, CounterState>(
          listener: (context, state) {
            if (state.counterValue == 10 || state.counterValue == -10) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Counter Alert'),
                  content: Text('Counter reached ${state.counterValue}'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
            if (state.counterValue == -1) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Negative Value Alert'),
                  content: const Text('Counter has reached a negative value!'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      '${state.counterValue}',
                      key: ValueKey<int>(state.counterValue),
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color:
                            state.counterValue < 0 ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: state.counterValue < 0 ? 70 : 60,
                        height: state.counterValue < 0 ? 70 : 60,
                        decoration: BoxDecoration(
                          color:
                              state.counterValue < 0 ? Colors.red : Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () =>
                              context.read<CounterCubit>().decrement(),
                          icon: const Icon(Icons.remove, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 20),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: state.counterValue > 10 ? 70 : 60,
                        height: state.counterValue > 10 ? 70 : 60,
                        decoration: BoxDecoration(
                          color: state.counterValue > 10
                              ? Colors.green
                              : Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () =>
                              context.read<CounterCubit>().increment(),
                          icon: const Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

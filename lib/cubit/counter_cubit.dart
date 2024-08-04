import 'package:bloc/bloc.dart';
import 'package:r3_app1/cubit/counter_state.dart';

class CounterCubit extends Cubit<CounterState>{ 
  CounterCubit() : super(const CounterState(0));
  
  void increment() {
    emit(CounterState(state.count + 1));
  }
   void decrement() {
    emit(CounterState(state.count - 1));
  }
}

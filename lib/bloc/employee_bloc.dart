import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:r3_app1/models/employee.dart';
import 'package:r3_app1/repository/employee_repository.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository _employeeRepository;
  EmployeeBloc(this._employeeRepository) : super(EmployeeLadingState()) {
    // print('>>>>>>>>>bloc init');
    on<LoadEmployeeEvent>(loadEmployee);
  }

  FutureOr<void> loadEmployee(
    LoadEmployeeEvent event,Emitter<EmployeeState> emit) async{
    emit(EmployeeLadingState());
   await _employeeRepository.getEmployees().then((employees) {
      emit(EmployeeLoadedState(employees!));
    }).catchError((error) {
      emit(EmployeeErrorState(error.toString()));
    });
  }
}

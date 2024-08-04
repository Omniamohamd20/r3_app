import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r3_app1/bloc/employee_bloc.dart';
import 'package:r3_app1/cubit/counter_cubit.dart';
import 'package:r3_app1/cubit/counter_state.dart';
import 'package:r3_app1/repository/employee_repository.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => CounterCubit(),
      ),
      BlocProvider(
        create: (context) => EmployeeBloc(EmployeeRepository()),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    context.read<EmployeeBloc>().add(LoadEmployeeEvent());
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<EmployeeBloc, EmployeeState>(
              builder: (context, state) {
                if (state is EmployeeLadingState) {
                  return const CircularProgressIndicator();
                }
                if (state is EmployeeLoadedState) {
                  return ListView.builder(
                      itemCount: state.employees.length,
                      itemBuilder: (context, index) => ListTile(
                            title: Text(state.employees[index].name?.first ??
                                'no name'),
                            subtitle: Text(
                                state.employees[index].email ?? 'no email'),
                          ));
                }
                if (state is EmployeeErrorState) {
                  return Text('Employees: ${state.error}');
                }
                return SizedBox
                    .shrink(); // This will return an empty widget if none of the above conditions are met
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

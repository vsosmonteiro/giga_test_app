import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giga_test_app/bloc/user/user_bloc.dart';
import 'package:giga_test_app/bloc/user/user_state.dart';
import 'package:giga_test_app/models/user_model.dart';
import 'package:giga_test_app/repositories/user_repository.dart';
import 'package:giga_test_app/services/sql_service.dart';
import 'package:giga_test_app/singletons.dart';
import 'package:giga_test_app/views/home_screen.dart';
import 'package:giga_test_app/views/user_screen.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  db = await SqLiteService.initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (BuildContext context)=>UserBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/':(_) => HomeScreen(),
          '/user':(_) => UserScreen(),
          '/teste':(_) => MyHomePage()

        },
        initialRoute:'/',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('a'),
      ),
      body: Center(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

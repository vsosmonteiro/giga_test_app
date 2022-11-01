import 'package:flutter/material.dart';
import 'package:giga_test_app/models/user_model.dart';
import 'package:giga_test_app/repositories/user_repository.dart';
import 'package:giga_test_app/services/sql_service.dart';
import 'package:giga_test_app/singletons.dart';
import 'package:giga_test_app/views/home_screen.dart';
import 'package:giga_test_app/views/user_screen.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  db = await SqLiteService().initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(_) => HomeScreen(),
        '/user':(_) => UserScreen(),
        '/teste':(_) => MyHomePage()

      },
      initialRoute:'/teste',
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<void> _incrementCounter() async {

    Result teste = await UsersRepository().repoFetchUser(page: 1, gender: 'male', db: db!);
    SqLiteService().insertUser(db!, teste.users![0]);
    SqLiteService().getUsers(db!, 1, 0);
    SqLiteService().deleteUser(db!, teste.users![0].email!);
    Result teste2=  await UsersRepository().repoFetchUser(page: 1, gender: 'male', db: db!);
  }

  @override
  void initState() {
    _incrementCounter();
  }

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

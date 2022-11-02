import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giga_test_app/bloc/user/user_bloc.dart';
import 'package:giga_test_app/providers/user_provider.dart';
import 'package:giga_test_app/services/sql_service.dart';
import 'package:giga_test_app/singletons.dart';
import 'package:giga_test_app/views/home_screen.dart';
import 'package:giga_test_app/views/user_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  // ensure its initialized before init the db
  WidgetsFlutterBinding.ensureInitialized();
  db = await SqLiteService.initDB();
  //locks orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // uses provider and bloc
    return BlocProvider<UserBloc>(
      create: (BuildContext context) => UserBloc(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => UserProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // define routes
          routes: {
            '/': (_) => HomeScreen(),
            '/user': (_) => UserScreen(),
          },
          initialRoute: '/',
        ),
      ),
    );
  }
}

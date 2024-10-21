import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/auth_provider.dart';
import 'package:todo/ui/home/home_screen.dart';
import 'package:todo/ui/login/login_screen.dart';
import 'package:todo/ui/register/register_screen.dart';

import 'firebase_options.dart';
void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) =>AuthinProvider(),
  child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: FToastBuilder(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          headline4: TextStyle(
            fontSize: 32,
            color: Colors.black,
          )
        ),
         primarySwatch: Colors.grey,
        scaffoldBackgroundColor: const Color(0xFFDFECDB),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        )
      ),
      routes:
       {
         RegisterScreen.routeName : (_)=> RegisterScreen(),
         LoginScreen.routeName : (_)=> LoginScreen(),
         HomeScreen.routeName:(_)=> HomeScreen(),
       },
      initialRoute: LoginScreen.routeName,
    );
  }
}
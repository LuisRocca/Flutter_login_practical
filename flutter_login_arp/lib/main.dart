import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_arp/helpers/dependency_injection.dart';
import 'package:flutter_login_arp/pages/home_page.dart';
import 'package:flutter_login_arp/pages/login_page.dart';
import 'package:flutter_login_arp/pages/register_page.dart';
import 'package:flutter_login_arp/pages/splash_page.dart';

void main() {
  DependencyInjection.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      routes: {
        'register': (context) => RegisterPage(),
        'login': (context) => LoginPage(),
        'home': (context) => HomePage(),
      },
    );
  }
}

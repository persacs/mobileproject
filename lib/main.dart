import 'package:flutter/material.dart';
import 'sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login With Google',
      home: SignInScreen(),
    );
  }
}

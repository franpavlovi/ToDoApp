import 'package:flutter/material.dart';
import 'prijava.dart';
import 'registracija.dart';
import 'zadaci.dart';


void main() => runApp(MojaAplikacija());

class MojaAplikacija extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.purple,
        scaffoldBackgroundColor: Colors.grey,
      ),

      home: Prijava(),

    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'zadaci.dart';
import 'registracija.dart';

class Prijava extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _lozinkaController = TextEditingController();

  Future<void> _prijaviSe(BuildContext context) async {
    final email = _emailController.text;
    final lozinka = _lozinkaController.text;

    final response = await http.post(
      Uri.parse('http://localhost:8080/api/auth/prijava'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'lozinka': lozinka,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Zadaci()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Prijava nije uspjela: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'TO DO APP',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _lozinkaController,
              decoration: InputDecoration(labelText: 'Lozinka'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _prijaviSe(context),
              child: Text('Prijava'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Registracija()),
                );
              },
              child: Text('Registracija'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'prijava.dart';

class Registracija extends StatelessWidget {
  final TextEditingController _imeController = TextEditingController();
  final TextEditingController _prezimeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _lozinkaController = TextEditingController();
  final TextEditingController _potvrdaLozinkeController = TextEditingController();

  Future<void> _registrirajSe(BuildContext context) async {
    final ime = _imeController.text;
    final prezime = _prezimeController.text;
    final email = _emailController.text;
    final lozinka = _lozinkaController.text;
    final potvrdaLozinke = _potvrdaLozinkeController.text;

    if (lozinka != potvrdaLozinke) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lozinke se ne podudaraju')),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('http://localhost:8080/api/auth/registracija'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'ime': ime,
        'prezime': prezime,
        'email': email,
        'lozinka': lozinka,
        'potvrdaLozinke': potvrdaLozinke,
      }),
    );

    if (response.statusCode == 201) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Prijava()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registracija nije uspjela: ${response.body}')),
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
              controller: _imeController,
              decoration: InputDecoration(labelText: 'Ime'),
            ),
            TextField(
              controller: _prezimeController,
              decoration: InputDecoration(labelText: 'Prezime'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _lozinkaController,
              decoration: InputDecoration(labelText: 'Lozinka'),
              obscureText: true,
            ),
            TextField(
              controller: _potvrdaLozinkeController,
              decoration: InputDecoration(labelText: 'Potvrda lozinke'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _registrirajSe(context),
              child: Text('Registracija'),
            ),
          ],
        ),
      ),
    );
  }
}

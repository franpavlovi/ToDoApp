import 'package:flutter/material.dart';
import 'prijava.dart';

class Registracija extends StatelessWidget {
  final TextEditingController _imeController = TextEditingController();
  final TextEditingController _prezimeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _lozinkaController = TextEditingController();
  final TextEditingController _potvrdaLozinkeController = TextEditingController();

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
              onPressed: () {
                // Implementiraj logiku za registraciju
              },
              child: Text('Registracija'),
            ),
          ],
        ),
      ),
    );
  }
}

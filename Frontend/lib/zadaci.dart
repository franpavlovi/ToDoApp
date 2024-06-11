import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Zadatak {
  final int id;
  final String naziv;
  bool zavrsen;

  Zadatak({required this.id, required this.naziv, required this.zavrsen});

  factory Zadatak.fromJson(Map<String, dynamic> json) {
    return Zadatak(
      id: (json['id'] as num).toInt(),
      naziv: json['naziv'] as String,
      zavrsen: json['status'] as bool,
    );
  }
}

class Zadaci extends StatefulWidget {
  @override
  _ZadaciState createState() => _ZadaciState();
}

class _ZadaciState extends State<Zadaci> {
  List<Zadatak> _zadaci = [];

  @override
  void initState() {
    super.initState();
    _fetchZadaci();
  }

  Future<void> _fetchZadaci() async {
    final response = await http.get(Uri.parse('http://localhost:8080/api/zadaci'));

    if (response.statusCode == 200) {
      final List<dynamic> zadaciJson = jsonDecode(response.body);
      setState(() {
        _zadaci = zadaciJson.map((json) => Zadatak.fromJson(json)).toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ne mogu dohvatiti zadatke: ${response.body}')),
      );
    }
  }

  Future<void> _toggleZadatak(Zadatak zadatak) async {
    final response = await http.put(
      Uri.parse('http://localhost:8080/api/zadaci/${zadatak.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'naziv': zadatak.naziv,
        'status': !zadatak.zavrsen,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        zadatak.zavrsen = !zadatak.zavrsen;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ne mogu ažurirati zadatak: ${response.body}')),
      );
    }
  }

  Future<void> _obrisiZadatak(int id) async {
    final response = await http.delete(
      Uri.parse('http://localhost:8080/api/zadaci/$id'),
    );

    if (response.statusCode == 204) {
      setState(() {
        _zadaci.removeWhere((zadatak) => zadatak.id == id);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ne mogu obrisati zadatak: ${response.body}')),
      );
    }
  }

  Future<void> _dodajZadatak(String naziv) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/zadaci'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'naziv': naziv,
        'status': false,
      }),
    );

    if (response.statusCode == 200) {
      _fetchZadaci();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ne mogu dodati zadatak: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nazivController = TextEditingController();

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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _zadaci.length,
              itemBuilder: (context, index) {
                final zadatak = _zadaci[index];
                return ListTile(
                  title: Text(zadatak.naziv),
                  trailing: Checkbox(
                    value: zadatak.zavrsen,
                    onChanged: (_) => _toggleZadatak(zadatak),
                  ),
                  onTap: () => _obrisiZadatak(zadatak.id),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nazivController,
                    decoration: InputDecoration(labelText: 'Novi zadatak'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    final naziv = _nazivController.text;
                    if (naziv.isNotEmpty) {
                      _dodajZadatak(naziv);
                      _nazivController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: Zadaci()));

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DIGIMON LIST',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Digimonlist(),
    );
  }
}

class Digimonlist extends StatelessWidget {
  final String apiUrl = "https://digimon-api.vercel.app/api/digimon";

  const Digimonlist({key});

  Future<List<dynamic>> _fecthDigimonlist() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digimon List'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fecthDigimonlist(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 3,
                    color: Color.fromARGB(255, 242, 234, 224),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Color.fromARGB(255, 242, 234, 224),
                        backgroundImage: NetworkImage(
                          snapshot.data[index]['img'],
                        ),
                      ),
                      title: Text(
                        snapshot.data[index]['name'],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        snapshot.data[index]['level'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

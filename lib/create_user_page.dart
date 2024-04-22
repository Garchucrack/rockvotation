import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NewUserPage extends StatelessWidget {
  NewUserPage({Key? key});

  final nombreController = TextEditingController();
  final albumController = TextEditingController();
  final anioController = TextEditingController();
  final votoController = TextEditingController();
  final almacenamiento = FirebaseStorage.instance;
  final instance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String?;
    if (args != null) {
      instance.collection('bandas').doc(args).get().then((value) {
        nombreController.text = value['Nombre de la banda'];
        albumController.text = value['Nombre del album'];
        anioController.text = value['Año de lanzamiento'].toString();
        votoController.text = value['Votos'].toString();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agregar banda nueva',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: nombreController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre de la banda',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: albumController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Album de la banda',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: anioController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Año de lanzamiento',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: votoController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Votos',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  final data = {
                    'Nombre de la banda': nombreController.text,
                    'Nombre del album': albumController.text,
                    'Año de lanzamiento': int.parse(anioController.text),
                    'Votos': int.parse(votoController.text),
                  };
                  final respuesta = await instance.collection('bandas').add(data);
                  print(respuesta);
                  Navigator.pushNamed(context, '/home');
                },
                child: Text(
                  'Agregar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}

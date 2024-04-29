import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class NewUserPage extends StatelessWidget {
  NewUserPage({Key? key});

  final nombreController = TextEditingController();
  final albumController = TextEditingController();
  final anioController = TextEditingController();
  final votoController = TextEditingController();
  final almacenamiento = FirebaseStorage.instance;
  final instance = FirebaseFirestore.instance;

  Future<String> subirFoto(String path) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imagen = File(path);
    final random = Random();
    final nombreImagen = nombreController.text + '${random.nextInt(1000000)}.jpg';
    final referenciaFotoPerfil =
        storageRef.child("bandas/imagenAlbum/$nombreImagen");
    final uploadTask = await referenciaFotoPerfil.putFile(imagen);
    final url = await uploadTask.ref.getDownloadURL();

    return url;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String?;
    if (args != null) {
      instance.collection('bandas').doc(args).get().then((value) {
        nombreController.text = value['Nombre de la banda'];
        albumController.text = value['Nombre del album'];
        anioController.text = value['Año del lanzamiento'].toString();
        votoController.text = value['Votos'].toString();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agregar Banda Nueva',
          style: TextStyle(color: Colors.white), // Cambiar color del texto del título
        ),
        backgroundColor: Colors.deepPurpleAccent, // Cambiar color de la barra de navegación
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre de la banda',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: albumController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Album de la banda',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: anioController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Año de lanzamiento',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: votoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
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
                child: const Text('Agregar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent, // Cambiar color del botón
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();

                  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

                  if (image == null) {
                    final url = await subirFoto('assets/images/goku.jpg');
                    print(url);
                    return;
                  }
                  final url = await subirFoto(image.path);
                  print(url);
                },
                child: const Text('Subir foto'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent, // Cambiar color del botón
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

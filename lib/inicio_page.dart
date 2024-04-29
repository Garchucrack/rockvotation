import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:online_store_tk/create_user_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final users = firestore.collection('bandas').snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent, // Cambiar color de la barra de navegación
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white), // Cambiar color del texto del título
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: users,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final listaBandas = snapshot.data!.docs;

            return ListView.builder(
              itemCount: listaBandas.length,
              itemBuilder: (context, index) {
                final user = listaBandas[index];
                return Card( // Envolver en un Card para un mejor diseño
                  elevation: 3, // Agregar sombra al card
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Margen del card
                  child: ListTile(
                    title: Text(
                      user['Nombre de la banda'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${user['Nombre del album']}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    leading: Text(
                      '${user['Año de lanzamiento']}',
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: Text(
                      'Votos:  ${user['Votos']}',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    onTap: () async {
                      final id = user.id;
                      await firestore.collection('bandas').doc(id).update({
                        'Votos': FieldValue.increment(1),
                      });
                      setState(() {});
                    },
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple, // Cambiar color del indicador de carga
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new_user');
        },
        backgroundColor: Colors.deepPurpleAccent, // Cambiar color del botón flotante
        tooltip: 'Agregar nueva banda',
        child: Icon(Icons.add),
      ),
    );
  }
}

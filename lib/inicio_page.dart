import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final users = firestore.collection('bandas').snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
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

                return ListTile(
                  title: Text(
                    user['Nombre de la banda'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(user['Nombre del album']),
                  leading: Text(
                    '${user['Año de lanzamiento']}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    'Votos: ${user['Votos']}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () async {
                    final id = user.id;
                    await firestore.collection('bandas').doc(id).update({
                      'Votos': FieldValue.increment(1),
                    });
                    setState(() {});
                  },
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new_user');
        },
        tooltip: 'Agregar nueva banda',
        child: Icon(Icons.add),
      ),
    );
  }
}

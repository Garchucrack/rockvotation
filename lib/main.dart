import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:online_store_tk/create_user_page.dart';
import 'package:online_store_tk/inicio_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bandas de rock',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 232, 16, 9), // Change primary color to deepPurple
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple), // Use deepPurple swatch
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple, // Set app bar background color to deepPurple
        ),
      ),
      home: const MyHomePage(title: 'Rock votation'), // Set home page title
      routes: {
        '/new_user': (context) => NewUserPage(),
        '/home': (context) => const MyHomePage(
              title: 'Rock desde firebase', // Adjusted home page title
            ),
      },
    );
  }
}


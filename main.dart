import 'package:flutter/material.dart';

import 'Flutter3/screens/contact_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Título actualizado para el enunciado 
      title: 'EduPlatform - Registro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, 
      ),
      home: const ContactForm(),
    );
  }
}


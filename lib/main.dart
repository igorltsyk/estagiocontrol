import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/view/telaLogin.dart';
import 'app/view/telaCadastro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBJciQeJw3UZwYDLow8VAxTa1lHBrhE_m8",
      appId: "1:259463650827:web:1723880b114a6366a2b10e",
      messagingSenderId: "259463650827",
      projectId: "estagio-control",
      databaseURL: "https://estagio-control-default-rtdb.firebaseio.com",
      storageBucket: "estagio-control.firebasestorage.app",
    ),
  ); 

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CadastroScreen(), 
  ));
}
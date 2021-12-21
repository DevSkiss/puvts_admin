import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:puvts_admin/features/login/presentation/screens/login_screen.dart';
import 'package:puvts_admin/core/app/locator_injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyBMCfoQ3lUloZrZqNb52cVGHPIsA9M3aTA',
      appId: '1:443660945774:web:cc9c18b5e3cc2fd867597f',
      messagingSenderId: '443660945774',
      projectId: 'puvts-f56e4',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PUVTS Admin',
      home: LoginScreen(),
    );
  }
}

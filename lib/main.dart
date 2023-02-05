import 'pages/mainPage.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OpenAI Image Generator',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MainPage(),
    );
  }
}

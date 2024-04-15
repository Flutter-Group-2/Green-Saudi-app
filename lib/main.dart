
import 'package:flutter/material.dart';
import 'package:green_saudi_app/views/login_view.dart';
import 'package:green_saudi_app/views/reset_password_view.dart';

void main() {
  runApp(
    const MainApp(), 
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginView(),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:green_saudi_app/locators/data_injection.dart';
import 'package:green_saudi_app/service/supabase/supabase_services.dart';
import 'package:green_saudi_app/views/bottom_nav_bar/view/bottom_nav_bar.dart';
import 'package:lottie/lottie.dart';



class FutureDelayedWidget extends StatefulWidget {
  const FutureDelayedWidget({super.key});

  @override
  _FutureDelayedWidgetState createState() => _FutureDelayedWidgetState();
}

class _FutureDelayedWidgetState extends State<FutureDelayedWidget> {
    final serviceLocator = DataInjection().locator.get<DBServices>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBar()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: Lottie.asset('assets/icons/Animation1713616803149.json')
      ),
    );
  }
}

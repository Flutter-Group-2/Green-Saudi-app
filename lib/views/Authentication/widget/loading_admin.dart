import 'package:flutter/material.dart';

import 'package:green_saudi_app/views/Admin/bottom_nav_bar_admin/view/bottom_nav_bar_admin.dart';
import 'package:lottie/lottie.dart';

class FutureDelayedAdmin extends StatefulWidget {
  const FutureDelayedAdmin({super.key});

  @override
  FutureDelayedAdminState createState() => FutureDelayedAdminState();
}

class FutureDelayedAdminState extends State<FutureDelayedAdmin> {
 
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => 
                 BottomNavBarAdmin()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Lottie.asset('assets/icons/Animation1713616803149.json')),
    );
  }
}

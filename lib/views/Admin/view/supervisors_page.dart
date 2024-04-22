import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:green_saudi_app/resources/extensions/screen_handler.dart';
import 'package:green_saudi_app/resources/localization/localization.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/views/Admin/bottom_nav_bar_admin/view/bottom_nav_bar_admin.dart';

class SupervisorsPage extends StatelessWidget {
  const SupervisorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List supervisorsInfo =[
      {
      'name':"Abdulwahab",
      'city':"Eastern",},
      {
      'name':"mohammed",
      'city':"Al-Baha",},
      {
      'name':"saad",
      'city':"Makkah",},
      {
      'name':"sultan",
      'city':"Riyadh",},
      {
      'name':"khalid",
      'city':"Al-Madinah",},
      {
      'name':"mohammed",
      'city':"Tabuk",},
      {
      'name':"saud",
      'city':"Makkah",},
      {
      'name':"mohammed",
      'city':"Makkah",},
      ];
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.push(view:  BottomNavBarAdmin(), isPush: false);
            },
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: green,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppLocale.supervisors.getString(context),
              style:const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: context.getHeight(),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: supervisorsInfo.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                    color: green, borderRadius: BorderRadius.circular(14)),
                height: 60,
                width: 356,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/adminlogo.png"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        "${AppLocale.supervisorsName.getString(context)} :${supervisorsInfo[index]['name']}",
                        style:const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        "${AppLocale.supervisorsCity.getString(context)} :${supervisorsInfo[index]['city']}",
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:green_saudi_app/extensions/screen_handler.dart';
import 'package:green_saudi_app/utils/colors.dart';
import 'package:green_saudi_app/utils/spacing.dart';
import 'package:green_saudi_app/views/Drawer/widget/drawer_widget.dart';
import 'package:green_saudi_app/views/profile/view/profile_user.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth() * .7,
      decoration: BoxDecoration(
          color: green,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
      padding: const EdgeInsets.only(top: 50, bottom: 70, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Row(
            children: [
              const CircleAvatar(),
              width16,
              Text(
                'Sultan Alotaibi',
                style: TextStyle(
                  color: pureWhite,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Column(
            children: [
              const DrawerItem(
                icon: Icons.eco,
                title: 'Sustainability',
              ),
              const DrawerItem(
                icon: Icons.nature,
                title: 'Nature',
              ),
              const DrawerItem(
                icon: Icons.waves,
                title: 'Water Conservation',
              ),
              const DrawerItem(
                icon: Icons.info,
                title: 'من نحن',
              ),
              DrawerItem(
                icon: Icons.person,
                title: 'الحساب',
                onTap: () {
                  context.push(view: ProfileUser(), isPush: false);
                },
              ),
            ],
          ),
          Row(
            children: [
               Icon(Icons.settings, color: pureWhite),
              width8,
               Text(
                'الاعدادات',
                style:
                    TextStyle(color: pureWhite, fontWeight: FontWeight.bold),
              ),
              width8,
              Container(width: 2, height: 20, color: pureWhite),
              width8,
               Text(
                'تسجيل الخروج',
                style:
                    TextStyle(color: pureWhite, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
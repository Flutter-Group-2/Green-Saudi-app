import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:green_saudi_app/resources/localization/localization.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/resources/utils/spacing.dart';
import 'package:green_saudi_app/views/Drawer/view/drawer_view.dart';
import 'package:green_saudi_app/widgets/golas_widget.dart';
import 'package:green_saudi_app/widgets/slider_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/logo.jpg'),
            ),
          ),
        ],
      ),
      drawer: const DrawerScreen(),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppLocale.currentEvent.getString(context),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 20,
                    color: green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SliderWidget(),
              height20,
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/about-sgi-bg-web.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AnimateList(
                    interval: 400.ms,
                    effects: [FadeEffect(duration: 300.ms)],
                    children: [
                      Divider(
                        color: green,
                        height: 0,
                        thickness: 4,
                      ),
                      height100,
                      height100,
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          AppLocale.dutiesInitiatives.getString(context),
                          // textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 30,
                            color: green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GoalsWidget(
                        img: 'assets/images/one-removebg-preview.png',
                        text: AppLocale.dutiesInitiatives1.getString(context),
                      ),
                      GoalsWidget(
                        img: 'assets/images/spinner-removebg-preview.png',
                        text: AppLocale.dutiesInitiatives2.getString(context),
                      ),
                      GoalsWidget(
                        img: 'assets/images/Growth-removebg-preview.png',
                        text: AppLocale.dutiesInitiatives3.getString(context),
                      ),
                      GoalsWidget(
                        img: 'assets/images/Plant-removebg-preview.png',
                        text: AppLocale.dutiesInitiatives4.getString(context),
                      ),
                      GoalsWidget(
                        img:
                            'assets/images/Screenshot_2024-04-11_224327-removebg-preview.png',
                        text: AppLocale.dutiesInitiatives5.getString(context),
                        isDivider: false,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

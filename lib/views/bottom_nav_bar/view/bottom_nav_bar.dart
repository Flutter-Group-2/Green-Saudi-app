
import 'package:flutter/material.dart';
import 'package:green_saudi_app/extensions/screen_handler.dart';
import 'package:green_saudi_app/utils/colors.dart';
import 'package:green_saudi_app/utils/spacing.dart';
import 'package:green_saudi_app/views/bottom_nav_bar/cubit/nav_bar_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

 
   final List<Map<String, dynamic>> navItems = [
    {"icon": 'assets/icons/home1.svg', "label": "Home"},
    {"icon": 'assets/icons/event.svg', "label": "Event"},
    {"icon": 'assets/icons/reward.svg', "label": "Reward"},
    {"icon": 'assets/icons/history.svg', "label": "MyEvent"},
  ];

  @override
  Widget build(BuildContext context) {
    final navCubit = context.read<NavBarCubit>();
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        return Scaffold(
          body: navCubit.pages[navCubit.selectIndex],
          bottomNavigationBar: Container(
            margin: const EdgeInsets.all(10),
            height: context.getHeight() * .100,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.15),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
              borderRadius: BorderRadius.circular(50),
            ),
            child: ListView.builder(
              itemCount: navItems.length,
              scrollDirection: Axis.horizontal,
              padding:
                  EdgeInsets.symmetric(horizontal: context.getWidth() * .024),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  navCubit.changeNavItem(index);
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      margin: EdgeInsets.only(
                        bottom: index == navCubit.selectIndex
                            ? 0
                            : context.getWidth() * .029,
                        right: context.getWidth() * .0422,
                        left: context.getWidth() * .0422,
                      ),
                      width: context.getWidth() * .128,
                      height: index == navCubit.selectIndex
                          ? context.getWidth() * .014
                          : 0,
                      decoration: BoxDecoration(
                        color: green,
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(10),
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      navItems[index]['icon'],
                      width: context.getWidth() * .056,
                      height: context.getWidth() * .056,
                      color: index == navCubit.selectIndex
                          ? green
                          : Colors.black38,
                    ),
                    Text(
                      navItems[index]['label'],
                      style: TextStyle(
                        fontSize: 12,
                        color: index == navCubit.selectIndex
                            ? green
                            : Colors.black38,
                      ),
                    ),
                    height10,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_saudi_app/locators/data_injection.dart';
import 'package:green_saudi_app/resources/extensions/screen_handler.dart';
import 'package:green_saudi_app/resources/localization/localization.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/resources/utils/spacing.dart';

import 'package:green_saudi_app/service/supabase_services.dart';
import 'package:green_saudi_app/views/Authentication/bloc/auth_bloc.dart';
import 'package:green_saudi_app/views/HoursHistory/view/Hours_history.dart';

import 'package:green_saudi_app/views/bottom_nav_bar/view/bottom_nav_bar.dart';
import 'package:green_saudi_app/views/profile/view/settings_user.dart';
import 'package:green_saudi_app/views/profile/widget/text_profile.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(LoadProfileEvent());

    final serviceLocator = DataInjection().locator.get<DBServices>();
    final user = serviceLocator.user;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.push(view: BottomNavBar(), isPush: false);
            },
            icon: Icon(
              Icons.arrow_back,
              color: pureWhite,
            )),
        actions: [
          IconButton(
              onPressed: () {
                context.push(view: const SettingsUser(), isPush: true);
              },
              icon: Icon(
                Icons.settings,
                color: pureWhite,
              )),
        ],
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        title: Text(
          AppLocale.account.getString(context),
          style: TextStyle(color: pureWhite, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AuthLoadProfileState) {
            return LayoutBuilder(builder: (_, constraints) {
              return SingleChildScrollView(
                // head container
                child: Column(
                  children: [
                    Container(
                      width: context.getWidth(),
                      height: context.getHeight() * .22,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(200),
                            bottomRight: Radius.circular(200)),
                        color: green,
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            bottom: constraints.minHeight - 40,
                            left: 50,
                            right: 50,
                            child: Container(
                              width: context.getWidth() * .14,
                              height: context.getHeight() * .14,
                              decoration: BoxDecoration(
                                color: pureWhite,
                                shape: BoxShape.circle,
                                border: Border.all(width: 10, color: pureWhite),
                              ),
                              child: Center(
                                child: CircleAvatar(
                                  radius: 140,
                                  child: Image.network(serviceLocator
                                          .userImageUrl ??
                                      "https://image.movieglu.com/7772/GBR_007772h0.jpg"), // Image
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          height40,
                          Text(
                            state.user.name ?? "Name",
                            style: TextStyle(height: 0.1, fontSize: 20),
                          ), // name
                          height16,
                          Divider(
                            color: grey,
                            indent: 20,
                            endIndent: 20,
                            thickness: 2,
                            height: 0.2,
                          ),
                          height32,
                          InkWell(
                            onTap: () {
                              context.push(
                                  view: HoursHistoryView(), isPush: false);
                            },
                            child: TextProfile(
                              title:
                                  AppLocale.volunteerHours.getString(context),
                              data:
                                  "${user.volunteerHours ?? "0"} ${AppLocale.hours.getString(context)}",
                              icon: FontAwesomeIcons.userClock,
                              isClickable: true,
                            ),
                          ),
                          TextProfile(
                            title: AppLocale.email.getString(context),
                            icon: Icons.mail,
                            data: serviceLocator.email,
                          ),
                          TextProfile(
                            title: AppLocale.city.getString(context),
                            data: serviceLocator.user.city ?? "الرياض",
                            icon: FontAwesomeIcons.city,
                          ),
                          TextProfile(
                            title: AppLocale.phoneNumber.getString(context),
                            data:
                                serviceLocator.user.phoneNumber ?? "0500500505",
                            icon: FontAwesomeIcons.phone,
                          ),
                          height26,
                          QrImageView(
                            data: serviceLocator.userID,
                            size: 200,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
          } else {
            //TODO: filed to display Prfile
            return Text("Error: Profile");
          }
        },
      ),
    );
  }
}

/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:green_saudi_app/locators/data_injection.dart';
import 'package:green_saudi_app/resources/extensions/screen_handler.dart';
import 'package:green_saudi_app/resources/localization/localization.dart';
import 'package:green_saudi_app/service/supabase_services.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/resources/utils/spacing.dart';
import 'package:green_saudi_app/views/Authentication/bloc/auth_bloc.dart';
import 'package:green_saudi_app/views/HoursHistory/view/Hours_history.dart';
import 'package:green_saudi_app/views/bottom_nav_bar/view/bottom_nav_bar.dart';
import 'package:green_saudi_app/views/Profile/view/settings_user.dart';
import 'package:green_saudi_app/views/Profile/widget/text_profile.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(LoadProfileEvent());
    final serviceLocator = DataInjection().locator.get<DBServices>();
    final user = serviceLocator.user;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.push(view: const BottomNavBar(), isPush: false);
            },
            icon: Icon(
              Icons.arrow_back,
              color: pureWhite,
            )),
        actions: [
          Text(
            AppLocale.account.getString(context),
            style: TextStyle(color: pureWhite, fontSize: 25),
          )
        ],
        backgroundColor: green,
        automaticallyImplyLeading: true,
        title: IconButton(
            onPressed: () {
              context.push(view:  SettingsUser(), isPush: true);
            },
            icon: Icon(
              Icons.settings,
              color: pureWhite,
            )),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AuthLoadProfileState) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 125,
                    width: 125,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: CachedNetworkImage(
                          imageUrl: serviceLocator.userImageUrl ??
                              "https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg",
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  Text(state.user.name ?? "Name"),
                  InkWell(
                    onTap: () {
                      context.push(view: HoursHistoryView(), isPush: false);
                    },
                    child: TextProfile(
                      title: AppLocale.volunteerHours.getString(context),
                      data: "ساعة${user.volunteerHours ?? "0"}",
                      icon: Icons.arrow_back_ios_new,
                    ),
                  ),
                  TextProfile(
                    title: AppLocale.email.getString(context),
                    //TODO : fix this
                    data: "",
                    // data: serviceLocator.email,
                  ),
                  TextProfile(
                    title: AppLocale.city.getString(context),
                    data: state.user.city ?? "الرياض",
                  ),
                  TextProfile(
                    title: AppLocale.phoneNumber.getString(context),
                    data: state.user.phoneNumber ?? "0500500505",
                  ),
                  height26,
                  QrImageView(
                    data: serviceLocator.userID,
                    size: 200,
                  ),
                ],
              ),
            );
          } else {
            //TODO: filed to display Prfile
            return Text("Error: Profile");
          }
        },
      ),
    );
  }
}

*/

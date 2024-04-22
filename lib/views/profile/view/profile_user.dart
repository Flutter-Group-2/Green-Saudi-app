import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_saudi_app/locators/data_injection.dart';
import 'package:green_saudi_app/resources/extensions/screen_handler.dart';
import 'package:green_saudi_app/resources/localization/localization.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/resources/utils/spacing.dart';
import 'package:green_saudi_app/service/supabase_services.dart';
import 'package:green_saudi_app/views/Authentication/bloc/auth_bloc.dart';
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
              context.push(view: const BottomNavBar(), isPush: false);
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
        backgroundColor: green,
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  1000), // large enough to make a circle
                              child: Container(
                                width: context.getWidth() * .14,
                                height: context.getHeight() * .14,
                                decoration: BoxDecoration(
                                  color: pureWhite,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(width: 10, color: pureWhite),
                                ),
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Image.network(
                                      serviceLocator.userImageUrl, 
                                      fit: BoxFit.cover, 
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.network(
                                            "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png"); 
                                      },
                                    ),
                                  ),
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
                            style: const TextStyle(height: 0.1, fontSize: 20),
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
                          TextProfile(
                            title:
                                AppLocale.volunteerHours.getString(context),
                            data:
                                "${user.volunteerHours ?? "0"} ${AppLocale.hours.getString(context)}",
                            icon: FontAwesomeIcons.userClock,
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
                            data: state.user.phoneNumber ?? "0500500505",
                            icon: FontAwesomeIcons.phone,
                          ),
                          height26,
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: pureWhite,
                            ),
                            child: QrImageView(
                              data: serviceLocator.userID,
                              size: 200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                      "assets/icons/Computer troubleshooting-pana.svg"),
                  height16,
                  Text(
                    'Filed to Display Profile Page',
                    style: TextStyle(fontSize: 25, color: green),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

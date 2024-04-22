import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_saudi_app/locators/data_injection.dart';
import 'package:green_saudi_app/resources/extensions/screen_handler.dart';
import 'package:green_saudi_app/resources/localization/localization.dart';
import 'package:green_saudi_app/service/supabase_services.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/resources/utils/spacing.dart';
import 'package:green_saudi_app/views/Admin/bottom_nav_bar_admin/view/bottom_nav_bar_admin.dart';
import 'package:green_saudi_app/views/Authentication/bloc/auth_bloc.dart';
import 'package:green_saudi_app/views/Authentication/view/login_view.dart';
import 'package:green_saudi_app/views/Drawer/widget/drawer_widget.dart';
import 'package:green_saudi_app/views/Profile/view/profile_user.dart';
import 'package:green_saudi_app/views/Profile/view/settings_user.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri url =
        Uri.parse('https://www.greeninitiatives.gov.sa/ar-sa/sgi-initiatives/');
    final Uri url1 =
        Uri.parse('https://www.greeninitiatives.gov.sa/ar-sa/about-sgi/');
    final Uri urlTwitter = Uri.parse('https://twitter.com/gi_saudi');
    final Uri urlFacebook =
        Uri.parse('https://www.facebook.com/SaudiGreenInitiative');
    final Uri urlInstagram = Uri.parse('https://www.instagram.com/gi_saudi/');
    final Uri urlYoutube =
        Uri.parse('hhttps://www.greeninitiatives.gov.sa/ar-sa/about-sgi/#');
    final serviceLocator = DataInjection().locator.get<DBServices>();
    final user = serviceLocator.user;
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLogoutSuccessState) {
            context.getMessagesBar(msg: state.message, color: green);
            context.push(view: const LoginView(), isPush: false);
          } else if (state is AuthLogoutErrorState) {
            context.getMessagesBar(msg: state.message, color: red);
          }
        },
        builder: (context, state) {
          return Container(
            width: context.getWidth() * .7,
            decoration: BoxDecoration(
              color: green,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.only(top: 50, bottom: 70, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    serviceLocator.userImageFile.path != ""
                        ? CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                FileImage(serviceLocator.userImageFile),
                          )
                        : CircleAvatar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            radius: 25,
                            backgroundImage:
                                NetworkImage(serviceLocator.userImageUrl),
                          ),
                    width16,
                    Text(
                      user.name ?? AppLocale.welcome.getString(context),
                      style: TextStyle(
                        color: pureWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    DrawerItem(
                      icon: Icons.person,
                      title: AppLocale.profile.getString(context),
                      onTap: () {
                        context.push(view: const ProfileView(), isPush: false);
                      },
                    ),
                    DrawerItem(
                      icon: Icons.info,
                      title: AppLocale.aboutUS.getString(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Divider(
                        color: pureWhite,
                        thickness: 0.2,
                        height: 0.2,
                      ),
                    ),
                    DrawerItem(
                      icon: Icons.eco,
                      title: AppLocale.saudi.getString(context),
                      onTap: () async {
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.inAppWebView);
                        }
                      },
                    ),
                    DrawerItem(
                      icon: Icons.nature,
                      title: AppLocale.vision.getString(context),
                      onTap: () async {
                        if (await canLaunchUrl(url1)) {
                          await launchUrl(url1, mode: LaunchMode.inAppWebView);
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Divider(
                        color: pureWhite,
                        thickness: 0.2,
                        height: 0.2,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.push(view: const SettingsUser(), isPush: true);
                      },
                      icon: Icon(Icons.settings, color: pureWhite),
                    ),
                    width8,
                    Text(
                      AppLocale.settingsTitle.getString(context),
                      style: TextStyle(
                          color: pureWhite, fontWeight: FontWeight.bold),
                    ),
                    width8,
                    Container(width: 2, height: 20, color: pureWhite),
                    width8,
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(
                              AppLocale.signOutMsg.getString(context),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  AppLocale.no.getString(context),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .unselectedWidgetColor),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(LogoutEvent());
                                  context.push(
                                      view: const LoginView(), isPush: false);
                                },
                                child: Text(
                                  AppLocale.yes.getString(context),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .unselectedWidgetColor),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text(
                        AppLocale.logoutButton.getString(context),
                        style: TextStyle(
                            color: pureWhite, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    user.typeRole == "admin"
                        ? IconButton(
                            onPressed: () {
                              context.push(
                                  view: BottomNavBarAdmin(), isPush: false);
                            },
                            icon: Icon(
                              Icons.border_color_rounded,
                              color: pureWhite,
                            ),
                          )
                        : const SizedBox(),
                    width8,
                    user.typeRole == "admin"
                        ? Text(
                            "back to Control Panel",
                            style: TextStyle(
                                color: pureWhite, fontWeight: FontWeight.bold),
                          )
                        : const SizedBox(),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          if (await canLaunchUrl(urlFacebook)) {
                            await launchUrl(urlFacebook,
                                mode: LaunchMode.inAppWebView);
                          }
                        },
                        icon: Icon(
                          Icons.facebook_outlined,
                          color: pureWhite,
                        )),
                    IconButton(
                        onPressed: () async {
                          if (await canLaunchUrl(urlInstagram)) {
                            await launchUrl(urlInstagram,
                                mode: LaunchMode.inAppWebView);
                          }
                        },
                        icon: Icon(
                          FontAwesomeIcons.instagram,
                          color: pureWhite,
                        )),
                    IconButton(
                        onPressed: () async {
                          if (await canLaunchUrl(urlYoutube)) {
                            await launchUrl(urlYoutube,
                                mode: LaunchMode.inAppWebView);
                          }
                        },
                        icon: Icon(
                          FontAwesomeIcons.youtube,
                          color: pureWhite,
                        )),
                    IconButton(
                        onPressed: () async {
                          if (await canLaunchUrl(urlTwitter)) {
                            await launchUrl(urlTwitter,
                                mode: LaunchMode.inAppWebView);
                          }
                        },
                        icon: Icon(
                          FontAwesomeIcons.twitter,
                          color: pureWhite,
                        )),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

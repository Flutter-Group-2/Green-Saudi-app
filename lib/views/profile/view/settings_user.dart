import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:green_saudi_app/locators/data_injection.dart';
import 'package:green_saudi_app/resources/extensions/screen_handler.dart';
import 'package:green_saudi_app/resources/localization/cubit/language_cubit.dart';
import 'package:green_saudi_app/resources/localization/localization.dart';
import 'package:green_saudi_app/service/appearence_service.dart';
import 'package:green_saudi_app/service/supabase_services.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/resources/utils/spacing.dart';
import 'package:green_saudi_app/views/Authentication/bloc/auth_bloc.dart';
import 'package:green_saudi_app/views/Authentication/view/login_view.dart';
import 'package:green_saudi_app/views/Authentication/view/validation_email_view.dart';
import 'package:green_saudi_app/views/bottom_nav_bar/view/bottom_nav_bar.dart';
import 'package:green_saudi_app/views/Profile/view/edit_profile_user.dart';
import 'package:green_saudi_app/views/Profile/widget/settings_button.dart';
import 'package:green_saudi_app/views/Profile/widget/settings_switch.dart';

class SettingsUser extends StatelessWidget {
  const SettingsUser({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceLocator = DataInjection().locator.get<DBServices>();
    final user = serviceLocator.user;
    final cubit = context.read<LanguageCubit>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppLocale.settingsTitle.getString(context),
          style: const TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: green,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              context.push(view: const BottomNavBar(), isPush: false);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                context.push(view: const EditProfileUser(), isPush: true);
              },
              child: Container(
                height: 100,
                width: 430,
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14))),
                child: Row(
                  children: [
                    SizedBox(
                      height: 72,
                      width: 72,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: Image.network(
                              errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                                "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png");
                          }, fit: BoxFit.cover, serviceLocator.userImageUrl)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user.name ?? "Name",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        Text(
                          AppLocale.editProfile.getString(context),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            height16,
            SettingsButton(
              title: AppLocale.changePassword.getString(context),
              icons: Icons.password,
              onTap: () {
                context.push(view: const ValidationEmailView(), isPush: true);
              },
            ),
            height16,
            SettingsButton(
                title: AppLocale.email.getString(context),
                icons: Icons.email_outlined,
                onTap: () {
                  context.push(view: const ValidationEmailView(), isPush: true);
                }),
            height16,
            SettingsSwitch(
              title: AppLocale.notification.getString(context),
              icon: Icons.notifications,
              isDarkMode: false,
            ),
            height16,
            SettingsSwitch(
              title: GetIt.I.get<AppearanceServices>().currentTheme == 'Light'
                  ? AppLocale.lightMode.getString(context)
                  : AppLocale.darkMode.getString(context),
              icon: GetIt.I.get<AppearanceServices>().currentTheme == 'Light'
                  ? Icons.sunny
                  : Icons.nightlight_round,
              isDarkMode: true,
            ),
            height16,
            SettingsButton(
                title: AppLocale.languageButton.getString(context),
                icons: Icons.language,
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title:  Text( AppLocale.changeLanguage.getString(context),),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => cubit.changeLanguage("ar"),
                          child:  Text(
                            AppLocale.arabic.getString(context),
                          style: TextStyle(color: Theme.of(context).unselectedWidgetColor),),
                        ),
                        TextButton(
                          onPressed: () => cubit.changeLanguage("en"),
                          child:  Text('english',style: TextStyle(color: Theme.of(context).unselectedWidgetColor),),
                        ),
                      ],
                    ),
                  );
                }),
            height60,
            InkWell(
              onTap: () {
                context.read<AuthBloc>().add(LogoutEvent());
                context.push(view: const LoginView(), isPush: false);
              },
              child: Container(
                height: 60,
                width: 345,
                decoration: BoxDecoration(
                    color: green, borderRadius: BorderRadius.circular(30)),
                child: Center(
                    child: Text(
                  AppLocale.logoutButton.getString(context),
                  style: TextStyle(
                      color: pureWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

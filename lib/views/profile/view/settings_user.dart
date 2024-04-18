import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:green_saudi_app/data_layer/data_layer.dart';
import 'package:green_saudi_app/extensions/screen_handler.dart';
import 'package:green_saudi_app/localistion/cubit/language_cubit.dart';
import 'package:green_saudi_app/localistion/localistion.dart';
import 'package:green_saudi_app/service/supabase_services.dart';
import 'package:green_saudi_app/utils/colors.dart';
import 'package:green_saudi_app/utils/spacing.dart';
import 'package:green_saudi_app/views/onboarding/view/onboarding_view.dart';
import 'package:green_saudi_app/views/profile/view/edit_profile_user.dart';
import 'package:green_saudi_app/views/profile/widget/settings_button.dart';
import 'package:green_saudi_app/views/profile/widget/settings_switch.dart';

class SettingsUser extends StatelessWidget {
  const SettingsUser({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LanguageCubit>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppLocale.SettingsTitle.getString(context),
          style: const TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: green,
        automaticallyImplyLeading: true,
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
                    color: Theme.of(context).colorScheme.background,
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
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "أحمد موسى",
                          style: TextStyle(
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
                context.push(view: const OnboardingView(), isPush: true);
              },
            ),
            height16,
            SettingsButton(
                title: AppLocale.email.getString(context),
                icons: Icons.email_outlined,
                onTap: () {}),
            height16,
            SettingsSwitch(
              title: AppLocale.notification.getString(context),
              icon: Icons.notifications,
              isDarkMode: false,
            ),
            height16,
            SettingsSwitch(
              title: AppLocale.darkMode.getString(context),
              icon: Icons.sunny,
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
                      title: const Text('AlertDialog Title'),
                      content: const Text('AlertDialog description'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => cubit.changeLanguage("ar"),
                          child: const Text('العربية'),
                        ),
                        TextButton(
                          onPressed: () => cubit.changeLanguage("en"),
                          child: const Text('english'),
                        ),
                      ],
                    ),
                  );
                }),
            height60,
            Container(
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
          ],
        ),
      ),
    );
  }
}

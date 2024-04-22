import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:green_saudi_app/service/appearence_service.dart';
import 'package:green_saudi_app/resources/theme/bloc/theme_bloc.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';

import 'package:green_saudi_app/views/Profile/widget/custom_switch_darkmode.dart';
import 'package:green_saudi_app/views/Profile/widget/custom_switch_notfcation.dart';

class SettingsSwitch extends StatefulWidget {
  const SettingsSwitch({
    super.key,
    required this.title,
    required this.icon,
    required this.isDarkMode,
  });
  final String title;
  final IconData icon;
  final bool isDarkMode;

  @override
  State<SettingsSwitch> createState() => _SettingsSwitchState();
}

bool isSwitched = true;
bool isSwitchedTo = true;

class _SettingsSwitchState extends State<SettingsSwitch> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ThemeBloc>();

    return Container(
      height: 60,
      width: 345,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: green,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              widget.icon,
              color: pureWhite,
            ),
            Text(
              widget.title,
              style: TextStyle(
                  color: pureWhite, fontWeight: FontWeight.bold, fontSize: 24),
            ),
            widget.isDarkMode
                ? CustomSwitchDarkMode(
                    value: GetIt.I.get<AppearanceServices>().currentTheme !=
                        'Dark',
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                        bloc.add(UpdateThemeEvent(isDark: !value));
                        bloc.add(GetThemeEvent());
                      });
                    },
                  )
                : CustomSwitchNotification(
                    value: isSwitchedTo,
                    onChanged: (value) {
                      setState(() {
                        isSwitchedTo = value;
                      });
                    },
                  )
          ],
        ),
      ),
    );
  }
}

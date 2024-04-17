import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_saudi_app/theme/bloc/theme_bloc.dart';
import 'package:green_saudi_app/utils/colors.dart';

import 'package:green_saudi_app/views/profile/widget/custom_switch_darkmode.dart';
import 'package:green_saudi_app/views/profile/widget/custom_switch_notfcation.dart';

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


class _SettingsSwitchState extends State<SettingsSwitch> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ThemeBloc>();

    return Container(
      height: 65,
      width: 345,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: green,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(widget.icon),
            const SizedBox(width: 8),
            Text(widget.title),
            const Spacer(),
            widget.isDarkMode
                ? CustomSwitchDarkMode(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                        bloc.add(UpdateThemeEvent());
                        bloc.add(GetThemeEvent());
                      });
                    },
                  )
                : CustomSwitchNotification(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                  )
          ],
        ),
      ),
    );
  }
}

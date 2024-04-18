import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:green_saudi_app/extensions/screen_handler.dart';
import 'package:green_saudi_app/service/supabase_services.dart';
import 'package:green_saudi_app/theme/theme.dart';
import 'package:green_saudi_app/utils/colors.dart';


class TimePickerWidget extends StatefulWidget {
  TimePickerWidget({required this.time, Key? key}) : super(key: key);
  late TimeOfDay time;

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectTime(context);
      },
      child: Container(
        width: context.getWidth(),
        height: 48,
        decoration: BoxDecoration(
          color: white,
          borderRadius: const BorderRadius.all(Radius.circular(14)),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.notifications_sharp,
                color: grey,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              selectedTime.format(context),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    final TimeOfDay? picked = await showTimePicker(
      cancelText:"خروج",
      confirmText: "تأكيد",
      initialTime: selectedTime,
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme.copyWith(
            timePickerTheme: customTimePicker(),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        widget.time=selectedTime;

      });
    }
  }
}
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/service/supabase_services.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatelessWidget {
  DatePickerWidget({super.key, required this.time, required this.isFires});
  String time;
  bool isFires;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide.none),
        hintText: "Enter date",
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          controller.text = formattedDate;
          time = formattedDate;
          if (isFires) {
            GetIt.I.get<DBServices>().startDateEvent = time;
          } else {
            GetIt.I.get<DBServices>().endDateEvent = time;
          }
          print(time);
        } else {
          print("Date is not selected");
        }
      },
    );
  }
}

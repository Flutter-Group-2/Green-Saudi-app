import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_saudi_app/model/personal_event.dart';
import 'package:green_saudi_app/resources/extensions/screen_handler.dart';
import 'package:green_saudi_app/service/database_configuration.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/resources/utils/spacing.dart';

class HistoryHoursWidget extends StatelessWidget {
  const HistoryHoursWidget({super.key, required this.event});
  final PersonalEvent event;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        translatorFunction(event.name!),
        translatorFunction('تم الحصول على (٨) ساعة من عمل التطوع'),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<String> translatedTexts = snapshot.data as List<String>;
          final String eventName = translatedTexts[0];
          // final String eventLocation = translatedTexts[1];
          // final String timeText = "${event.startTime!}-${event.endTime!}";
          // final String dateText = "${event.startDate!}-${event.endDate!}";
          final String hoursWorkedText = translatedTexts[1];
          return Container(
            width: context.getWidth(),
            height: context.getHeight() * .20,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: green,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        eventName,
                        style: TextStyle(
                          color: pureWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      // Text(
                      //   eventLocation,
                      //   style: const TextStyle(
                      //     color: Color.fromRGBO(240, 248, 255, 0.691),
                      //     fontWeight: FontWeight.normal,
                      //     fontSize: 12,
                      //   ),
                      // ),
                      height20,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Text(
                      //       dateText,
                      //       style: TextStyle(height: 0.1, color: pureWhite),
                      //     ),
                      //     width4,
                      //     Text(
                      //       timeText,
                      //       style: TextStyle(height: 0.1, color: pureWhite),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                Container(
                  height: 35,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: grey,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      width4,
                      Icon(
                        FontAwesomeIcons.clock,
                        color: green,
                      ),
                      width16,
                      Text(
                        hoursWorkedText,
                        style: TextStyle(
                          color: green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

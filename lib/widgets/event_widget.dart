import 'package:flutter/material.dart';
import 'package:green_saudi_app/model/event_model.dart';
import 'package:green_saudi_app/resources/extensions/screen_handler.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/service/translator_function.dart';
import 'package:green_saudi_app/views/details_event_view.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({super.key, required this.event});
  final EventModel event;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        translatorFunction(event.title ?? "No Content"),
        translatorFunction(event.location ?? "Riyadh"),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<String> translatedTexts = snapshot.data!;
          final String eventTitle = translatedTexts[0];
          final String location = translatedTexts[1];
          return InkWell(
            onTap: () {
              context.push(
                  view: EventDetailsView(
                    event: event,
                  ),
                  isPush: true);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Container(
                width: context.getWidth(),
                height: context.getHeight() * .155,
                margin: const EdgeInsets.only(
                    bottom: 50, top: 20, right: 16, left: 16),
                decoration: BoxDecoration(
                  color: green,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                   Positioned(
                      top: -40,
                      right: 60,
                      left: 60,
                      child: Container(
                        width: context.getWidth() * .640,
                        height: context.getHeight() * .1,
                        decoration: BoxDecoration(
                          image:  DecorationImage(
                            
                            image: NetworkImage(event.imageUrl  ??
                            
                             "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png",
                            
                          ),
                            fit: BoxFit.cover,
                          ),
                          color: pureWhite,
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      right: 100,
                      left: 100,
                      child: Container(
                        width: context.getWidth() * .65,
                        height: context.getHeight() * .048,
                        decoration: BoxDecoration(
                          color: pureWhite,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: Text(
                            location,
                            style: TextStyle(
                              color: green,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            eventTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: pureWhite,
                              fontSize: 22,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

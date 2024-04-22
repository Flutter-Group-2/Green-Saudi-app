
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:green_saudi_app/model/event_model.dart';
import 'package:green_saudi_app/model/personal_event.dart';
import 'package:green_saudi_app/resources/extensions/screen_handler.dart';
import 'package:green_saudi_app/resources/localization/localization.dart';
import 'package:green_saudi_app/service/database_configuration.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/resources/utils/spacing.dart';
import 'package:green_saudi_app/views/Admin/view/bloc/event_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsView extends StatelessWidget {
  const EventDetailsView({super.key, required this.event});
  final EventModel event;
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: pureWhite,
          ),
          onPressed: () {
            context.read<EventBloc>().add(EventLoadEvent());
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: pureWhite),
            onPressed: () {},
          ),
        ],
      ),
      //TODO: Time Format here
      body: FutureBuilder(
        future: Future.wait([
          translatorFunction(event.description ??
              'زراعة أشجار المانجروف للمساهمة في تنظيف مياه البحر، وإثراء التنوع البيولوجي، واستعادة الحياة المائية.'),
          translatorFunction(event.title ?? 'زراعة الاشجار'),
          translatorFunction(event.location ?? 'الرياض - حي الرمال'),
          translatorFunction(event.startTime ?? '١٢م الى ٤م'),
          translatorFunction(event.startDate ??'٤ أبريل ٢٠٢٤'),

        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: green));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final List<String> translatedTexts = snapshot.data!.cast<String>();
            final String description = translatedTexts[0];
            final String eventName = translatedTexts[1];
            final String eventLocation = translatedTexts[2];
            final String eventTime = translatedTexts[3];
            final String eventDate = translatedTexts[4];
            return Stack(
              children: [
                // Image and Description Section
                Positioned.fill(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 425,
                        child: Image.network(
                          event.imageUrl  ??
                           "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      height56,
                      // Description
                      height32,
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(
                          description,
                          style: TextStyle(
                            color: Colors.blueGrey[300],
                          ),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      
                      
                    ],
                    
                  ),
                  
                  
                ),
                Positioned(
                  bottom: 115,
                  right: 20,
                  child: FloatingActionButton(
                        mini: false,
                  onPressed: () async {
                          if (await canLaunchUrl( Uri.parse(event.locationUrl!))) {
                            await launchUrl( Uri.parse(event.locationUrl!),
                                mode: LaunchMode.inAppWebView);
                          }
                        },
                  backgroundColor: green, 
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                ),),
                // Header Info Section (Location - Time - Date)
                Positioned(
                  top: 375,
                  left: 35,
                  right: 35,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 160,
                      width: context.getWidth(),
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: green,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300]!,
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                eventName,
                                style: TextStyle(
                                  color: pureWhite,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                width24,
                                Icon(
                                  Icons.location_on_outlined,
                                  color: pureWhite,
                                ),
                                width16,
                                Text(
                                  eventLocation,
                                  style: TextStyle(
                                    color: pureWhite,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                width24,
                                Icon(
                                  Icons.access_time,
                                  color: pureWhite,
                                ),
                                width16,
                                Text(
                                  eventTime,
                                  style: TextStyle(
                                    color: pureWhite,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                width24,
                                Icon(
                                  Icons.calendar_month_outlined,
                                  color: pureWhite,
                                ),
                                width16,
                                Text(
                                  eventDate,
                                  style: TextStyle(
                                    color: pureWhite,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                 
                // Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        //TODO: Register in Event for user
                        context.read<EventBloc>().add(RegisterEvent(
                            personalEvent: PersonalEvent(
                                name: eventName,
                                stats: event.state,
                                eventId: event.id)));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        
                      ),
                      child: Container(
                        height: 60,
                        alignment: Alignment.center,
                        child: Text(
                          AppLocale.signEvent.getString(context),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
            
          }
        },
      ),
      
    );
  }
}

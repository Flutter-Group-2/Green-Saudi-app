import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:green_saudi_app/locators/data_injection.dart';
import 'package:green_saudi_app/resources/extensions/screen_handler.dart';
import 'package:green_saudi_app/resources/image_picker/bloc/image_pic_bloc.dart';
import 'package:green_saudi_app/resources/localization/localization.dart';
import 'package:green_saudi_app/model/event_model.dart';
import 'package:green_saudi_app/service/supabase_services.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/resources/utils/spacing.dart';
import 'package:green_saudi_app/views/Admin/bottom_nav_bar_admin/view/bottom_nav_bar_admin.dart';
import 'package:green_saudi_app/views/Admin/view/bloc/event_bloc.dart';
import 'package:green_saudi_app/views/Admin/view/events_admin_page.dart';
import 'package:green_saudi_app/views/Admin/widgets/date_pic.dart';
import 'package:green_saudi_app/views/Admin/widgets/name_of_row.dart';
import 'package:green_saudi_app/views/Admin/widgets/textfiled_container.dart';
import 'package:green_saudi_app/views/Admin/widgets/time_pic.dart';
import 'package:uuid/uuid.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController nameEventController = TextEditingController();
  TextEditingController descriptionEventController = TextEditingController();
  TextEditingController locationEventController = TextEditingController();
  TextEditingController locationUrlEventController = TextEditingController();
  TextEditingController capacityEventController =
      TextEditingController(text: "0");
  @override
  void dispose() {
    nameEventController.dispose();
    descriptionEventController.dispose();
    locationEventController.dispose();
    locationUrlEventController.dispose();
    capacityEventController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final serviceLocator = DataInjection().locator.get<DBServices>();
    TimeOfDay startTimeEvent = TimeOfDay.now();
    DateTime startDateEvent = DateTime.now();
    TimeOfDay endTimeEvent = TimeOfDay.now();
    DateTime endDateEvent = DateTime.now();
    String imageUrl = "";
    String imageID = const Uuid().v4();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        actionsIconTheme: IconThemeData(color: pureWhite),
        backgroundColor: green,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppLocale.addEvent.getString(context),
              style: TextStyle(
                color: pureWhite,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: BlocListener<EventBloc, EventState>(
        listener: (context, state) {
          if (state is EventSuccessState) {
            context.getMessagesBar(msg: state.msg, color: green);
            context.push(view: BottomNavBarAdmin(), isPush: false);
            //TODO: pop when add is not working
          } else if (state is EventErrorState) {
            context.getMessagesBar(msg: state.msg, color: red);
          }
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // First row
              Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(AppLocale.addImageEvent.getString(context),
                        style: const TextStyle(
                          fontSize: 24,
                        )),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        context.read<ImagePicBloc>().add(SelectImage());
                      },
                      child: BlocBuilder<ImagePicBloc, ImagePicState>(
                        builder: (context, state) {
                          if (state is ImageState) {
                            return SizedBox(
                                height: 150,
                                width: 150,
                                child: Center(
                                  child: Image.file(
                                      serviceLocator.ImageFileFromDatabase),
                                ));
                          } else {
                            return Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 100,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              NameRow(
                rowName: AppLocale.eventName.getString(context),
              ),
              height16,
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextfieldContainer(
                  hintText: AppLocale.eventName.getString(context),
                  controller: nameEventController,
                  keyboardType: TextInputType.text,
                ), //
              ),
              height26,
              NameRow(
                rowName: AppLocale.addDescription.getString(context),
              ),
              height16,
              Container(
                width: 350,
                height: 180,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(color: black),
                    borderRadius: BorderRadius.circular(40)),
                child: TextField(
                  controller: descriptionEventController,
                  maxLines: 5,
                  maxLength: 250,
                  decoration: InputDecoration(
                    hintText: AppLocale.addDescription.getString(context),
                    counterText: "",
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              height26,
              NameRow(
                rowName: AppLocale.date.getString(context),
              ),
              height16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(AppLocale.from.getString(context),
                      style: const TextStyle(fontSize: 20)),
                  Text(AppLocale.to.getString(context),
                      style: const TextStyle(fontSize: 20)),
                ],
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Container(
                        width: 150,
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: black),
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(40)),
                        child: const DatePickerWidget(),
                      ),
                    ),
                    Container(
                      width: 155,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: black),
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(40)),
                      child: const DatePickerWidget(),
                    ),
                  ],
                ),
              ),
              height48,
              NameRow(
                rowName: AppLocale.time.getString(context),
              ),
              height16,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(AppLocale.from.getString(context),
                      style: const TextStyle(fontSize: 20)),
                  Text(AppLocale.to.getString(context),
                      style: const TextStyle(fontSize: 20)),
                ],
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Container(
                        width: 150,
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: black),
                            color: pureWhite,
                            borderRadius: BorderRadius.circular(40)),
                        child: TimePickerWidget(
                          time: startTimeEvent,
                        ),
                      ),
                    ),
                    Container(
                      width: 155,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: black),
                          color: pureWhite,
                          borderRadius: BorderRadius.circular(40)),
                      child: TimePickerWidget(
                        time: endTimeEvent,
                      ),
                    ),
                  ],
                ),
              ),
              height48,
              NameRow(
                rowName: AppLocale.location.getString(context),
              ),
              height16,
              TextfieldContainer(
                hintText: AppLocale.location.getString(context),
                controller: locationEventController,
                keyboardType: TextInputType.text,
              ),
              NameRow(
                rowName: AppLocale.location.getString(context),
              ),
              height16,
              //TODO: location Url Event
              TextfieldContainer(
                hintText: AppLocale.location.getString(context),
                controller: locationUrlEventController,
                keyboardType: TextInputType.text,
              ),
              height26,
              NameRow(
                rowName: AppLocale.maximumCapacity.getString(context),
              ),
              height16,
              TextfieldContainer(
                hintText: AppLocale.maximumCapacity.getString(context),
                controller: capacityEventController,
                keyboardType: TextInputType.number,
              ),
              height70,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 175,
                    height: 60,
                    decoration: BoxDecoration(
                        color: green, borderRadius: BorderRadius.circular(30)),
                    child: TextButton(
                      onPressed: () {
                        context.push(view: const EventsAdminPage(), isPush: false);
                      },
                      child: Text(
                        AppLocale.cancel.getString(context),
                        style: TextStyle(
                            color: pureWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 34),
                      ),
                    ),
                  ),
                  Container(
                    width: 175,
                    height: 60,
                    decoration: BoxDecoration(
                        color: green, borderRadius: BorderRadius.circular(30)),
                    child: TextButton(
                      onPressed: () async {
                        if (serviceLocator
                            .ImageFileFromDatabase.path.isNotEmpty) {
                          context.read<ImagePicBloc>().add(
                              UpdateImageToDatabase("event_poster", imageID));
                          imageUrl = await serviceLocator.urlImage(
                              "event_poster", imageID);
                        }
                        EventModel event = EventModel(
                          id: imageID,
                          title: nameEventController.text,
                          description: descriptionEventController.text,
                          startDate: startDateEvent.toString(),
                          startTime: startTimeEvent.toString(),
                          endDate: endDateEvent.toString(),
                          endTime: endTimeEvent.toString(),
                          location: locationEventController.text,
                          locationUrl: locationUrlEventController.text,
                          maximumCapacity:
                              int.parse(capacityEventController.text),
                          imageUrl: imageUrl,
                        );
                        context.read<EventBloc>().add(EventAdded(event: event));
                      },
                      child: Text(
                        AppLocale.addIt.getString(context),
                        style: TextStyle(
                            color: pureWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 34),
                      ),
                    ),
                  ),
                ],
              ),
              height16,
            ],
          ),
        ),
      ),
    );
  }
}

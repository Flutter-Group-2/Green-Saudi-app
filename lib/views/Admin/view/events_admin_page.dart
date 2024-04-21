import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:green_saudi_app/resources/extensions/screen_handler.dart';
import 'package:green_saudi_app/resources/localization/localization.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/views/Admin/bottom_nav_bar_admin/view/bottom_nav_bar_admin.dart';
import 'package:green_saudi_app/views/Admin/view/add_event.dart';
import 'package:green_saudi_app/views/Admin/view/bloc/event_bloc.dart';

class EventsAdminPage extends StatelessWidget {
  const EventsAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventBloc()..add(EventLoadEvent()),
      child: BlocConsumer<EventBloc, EventState>(
        listener: (context, state) {
          if (state is EventErrorState) {
            context.getMessages(msg: state.msg, color: red);
          }       
           },
        builder: (context, state) {
                    if (state is EventLoadingState) {
            return const Center(child:CircularProgressIndicator()); //shimmerEffect();
          }
          if (state is EventLoadedState) {
            if (state.list.isNotEmpty) {
              return    Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    context.push(view: const AddEvent(), isPush: false);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.push(view: BottomNavBarAdmin(), isPush: false);
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ],
              backgroundColor: green,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppLocale.eventsAdmin.getString(context),
                    style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            body: SizedBox(
              height: context.getHeight(),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      decoration: BoxDecoration(
                          color: green,
                          borderRadius: BorderRadius.circular(14)),
                      height: 60,
                      width: 356,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/adminlogo.png"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              "${AppLocale.addressAdminEvent.getString(context)} : ${state.list[index].title}",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
            }
          }

        return AddEvent();
        },
      ),
    );
  }
}
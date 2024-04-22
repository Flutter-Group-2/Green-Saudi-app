import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_saudi_app/resources/extensions/screen_handler.dart';
import 'package:green_saudi_app/resources/localization/localization.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/resources/utils/spacing.dart';
import 'package:green_saudi_app/views/Admin/view/bloc/event_bloc.dart';
import 'package:green_saudi_app/views/Drawer/view/drawer_view.dart';
import 'package:green_saudi_app/views/HistoryEvent/widget/history_hours_widget.dart';
import 'package:green_saudi_app/views/HistoryEvent/widget/shimmer_history.dart';


class HistoryEventView extends StatelessWidget {
  const HistoryEventView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<EventBloc>().add(HistoryLoadEvent());
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/logo.jpg'),
            ),
          ),
        ],
      ),
      drawer: const DrawerScreen(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: context.getWidth() * .56,
            height: context.getHeight() * .044,
            decoration: BoxDecoration(
                color: pureWhite, borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                AppLocale.myEvent.getString(context),
                style: TextStyle(
                    color: green, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          height20,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  if (state is EventLoadingState) {
                    return ListView.builder(
                        itemCount: 4,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return const HistoryShimmer();
                        });
                  } else if (state is HistoryLoadedState) {
                    return ListView.builder(
                        itemCount: 4,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                           return const HistoryHoursWidget();
                        });
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         SvgPicture.asset(
                              "assets/icons/No data-pana.svg",height: 200, width: 200,),
                          height16,
                            Text(AppLocale.noHistory.getString(context),
                            style: TextStyle(fontSize: 30, color: green),
                          ),
                        ],
                      ),
                    );

                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

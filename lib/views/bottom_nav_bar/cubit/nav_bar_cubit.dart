import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:green_saudi_app/views/event_view.dart';
import 'package:green_saudi_app/views/history_event_view.dart';
import 'package:green_saudi_app/views/home_view.dart';
import 'package:green_saudi_app/views/reward_view.dart';
import 'package:meta/meta.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  List<Widget> pages = <Widget>[
    const HomeView(),
    const EventView(),
    const RewardView(),
    const HistoryEventView(),
  ];

  int selectIndex = 0;
  NavBarCubit() : super(NavBarInitial());

  @override // Added @override annotation
  void ChangeNavItem(int index) {
    selectIndex = index;
    emit(SuccessChangeIndex());
  }
}

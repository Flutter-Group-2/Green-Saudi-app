part of 'nav_bar_cubit.dart';

@immutable
sealed class NavBarState {}

final class NavBarInitial extends NavBarState {}

class SuccessChangeIndex extends NavBarState{}

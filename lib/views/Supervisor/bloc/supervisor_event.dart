part of 'supervisor_bloc.dart';

@immutable
sealed class SupervisorEvent {}

class ScanQR extends SupervisorEvent {
final EventModel event;
ScanQR({required this.event});}

class LoadSupervisors extends SupervisorEvent{}
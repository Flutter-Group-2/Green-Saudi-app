import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meta/meta.dart';

part 'supervisor_event.dart';
part 'supervisor_state.dart';

class SupervisorBloc extends Bloc<SupervisorEvent, SupervisorState> {
  SupervisorBloc() : super(SupervisorInitial()) {
    on<SupervisorEvent>((event, emit) {});
    on<ScanQR>(scanQR);
  }

  FutureOr<void> scanQR(ScanQR event, Emitter<SupervisorState> emit) async{
    try {
        String qrResult = await FlutterBarcodeScanner.scanBarcode(
            '#2A99CF', 'إلغاء', true, ScanMode.BARCODE);
        if (qrResult == '-1') {
          emit(SupervisorScanCanceled());
        } else {
          emit(SupervisorScanSuccess(qrResult));
        }
      } catch (e) {
        emit(SupervisorScanFailure());
      }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:green_saudi_app/resources/localization/localization.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/resources/utils/spacing.dart';
import 'package:green_saudi_app/service/supabase_services.dart';
import 'package:green_saudi_app/views/Supervisor/bloc/supervisor_bloc.dart';

class ScanView extends StatelessWidget {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SupervisorBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          
          appBar: AppBar(
            actionsIconTheme: IconThemeData(color: white),
            backgroundColor: green,
            actions: [
              Icon(
                Icons.qr_code_scanner,
                color: white,
              ),
            ],
            title: Text(
              AppLocale.scanQrCode.getString(context),
     
              
              style: TextStyle(
                color: white,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<SupervisorBloc, SupervisorState>(
                    builder: (context, state) {
                      if (state is SupervisorInitial) {
                        return Column(
                          children: [
                            Image.asset(
                              //TODO: change image
                              'assets/images/logo_2.png',
                              width: 175,
                              height: 175,
                            ),
                            Text(
                              AppLocale.letsScan.getString(context),
                              style: TextStyle(
                                color: green,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        );
                      } else if (state is SupervisorScanSuccess) {
                        //TODO: localizition
                        return AlertDialog(
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  GetIt.I.get<DBServices>().addVolunteerHours(
                                      addVolunteerHour: 8,
                                      volunteerID: state.qrString);
                                },
                                
                                child: Text(AppLocale.ok.getString(context),))
                          ],
                          title: Text("تم تسجيل الحضور"),
                        );
                      } else if (state is SupervisorScanFailure) {
                        return Column(
                          children: [
                            Image.asset(
                              //TODO: change image
                              'assets/images/logo_2.png',
                              width: 175,
                              height: 175,
                            ),
                            const Text(
                              //TODO: localizition
                              'عذرًا، لم نتمكن من قراءة الباركود. يرجى المحاولة مرة أخرى.',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        );
                      } else if (state is SupervisorScanCanceled) {
                        return Column(
                          children: [
                            Image.asset(
                              //TODO: change image
                              'assets/images/logo_2.png',
                              width: 175,
                              height: 175,
                            ),
                            Text(
                              //TODO: localizition
                              'تم إلغاء مسح الباركود',
                              style: TextStyle(
                                color: green,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  height100,
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<SupervisorBloc>(context).add(ScanQR());
                    }, 
                    child: Text(AppLocale.scanQrCode.getString(context),),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:green_saudi_app/locators/data_injection.dart';
import 'package:green_saudi_app/resources/extensions/screen_handler.dart';
import 'package:green_saudi_app/resources/localization/localization.dart';
import 'package:green_saudi_app/service/supabase_services.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/resources/utils/spacing.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:green_saudi_app/views/Authentication/bloc/auth_bloc.dart';
import 'package:green_saudi_app/views/Authentication/view/reset_password_view.dart';
import 'package:timer_count_down/timer_count_down.dart';

// ignore: must_be_immutable
class OTPView extends StatelessWidget {
  OTPView({super.key});
  bool isButtonEnabled = false;
  @override
  Widget build(BuildContext context) {
    final serviceLocator = DataInjection().locator.get<DBServices>();
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthCheckOTPVerificationState) {
          context.push(view: const ResetPasswordView(), isPush: true);
          context.getMessagesBar(
            msg: state.message,
            color: green,
          );
        } else if (state is AuthResendOTPState) {
          context.getMessagesBar(
            msg: state.message,
            color: green,
          );
        } else if (state is AuthResendOTPErrorState) {
          context.getMessagesBar(msg: state.message, color: red, success: false);
        } else if (state is AuthCheckOTPVerificationErrorState) {
          context.getMessagesBar(msg: state.message, color: red, success: false);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    height40,
                    Image.asset('assets/images/Data security.png'),
                    height40,
                    Text(
                      AppLocale.sendOTP.getString(context),
                      style: TextStyle(color: green, fontSize: 25),
                    ),
                    height20,
                    // Custom widget
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: OtpTextField(
                        numberOfFields: 6,
                        showCursor: true,
                        margin: const EdgeInsets.all(4),
                        fieldWidth: context.getWidth() * .11,
                        fieldHeight: context.getHeight() * .125,
                        borderColor: pureWhite,
                        showFieldAsBox: true,
                        fillColor: pureWhite,
                        filled: true,
                        borderRadius: BorderRadius.circular(20),
                        textStyle: TextStyle(
                            fontSize: 25,
                            color: green,
                            fontWeight: FontWeight.bold),
                        cursorColor: green,
                        focusedBorderColor: pureWhite,
                        // clearText: true,
                        onCodeChanged: (value) {
                        serviceLocator.otpToken = value;
                      },
                      onSubmit: (value) {
                        serviceLocator.otpToken = value;
                      },
                      ),
                    ),
                    height20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Countdown(
                          seconds: 60,
                          build: (BuildContext context, double time) => Expanded(
                            child: Text(
                              '${AppLocale.timer.getString(context)} ${time.toInt()} ${AppLocale.second.getString(context)}',
                              style: TextStyle(fontSize: 14, color: green),
                            ),
                          ),
                          interval: const Duration(seconds: 1),
                          onFinished: () {
                            (context as Element).markNeedsBuild();
                            isButtonEnabled = true;
                          },
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: isButtonEnabled
                            ? () {
                                context.read<AuthBloc>().add(ResendOtpEvent(
                                    email: serviceLocator.email));
                              }
                            : null,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: green,
                              ),
                            ),
                          ),
                          child: Text(
                            AppLocale.resend.getString(context),
                            style: TextStyle(
                              fontSize: 14,
                              color: green,
                            ),
                          ),
                        )),
                    height40,
                    ElevatedButton(
                      onPressed: () {
                     
                      context
                          .read<AuthBloc>()
                          .add(VerifyOtpEvent(otpToken: serviceLocator.otpToken));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: green,
                          minimumSize: Size(context.getWidth(), 55)),
                      child: Text(
                        AppLocale.verification.getString(context),
                        style: TextStyle(color: pureWhite, fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

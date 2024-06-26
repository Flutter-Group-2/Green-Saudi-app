import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:green_saudi_app/resources/extensions/screen_handler.dart';
import 'package:green_saudi_app/resources/localization/localization.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/resources/utils/spacing.dart';
import 'package:green_saudi_app/views/Authentication/bloc/auth_bloc.dart';
import 'package:green_saudi_app/views/Authentication/view/login_view.dart';
import 'package:green_saudi_app/views/Authentication/widget/custom_button.dart';
import 'package:green_saudi_app/views/Authentication/widget/input_text_felid.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthChangePasswordState) {
          context.getMessagesBar(msg: state.message, color: green);
          context.push(view: const LoginView(), isPush: false);
        } else if (state is AuthChangePasswordErrorState) {
          context.getMessagesBar(msg: state.message, color: red, success: false);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: Colors.white,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              actionsIconTheme: IconThemeData(color: white),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      SizedBox(
                          width: context.getWidth(),
                          height: context.getHeight() * 0.5,
                          child: 
                            Image.asset("assets/images/newpass.jpeg"),
                        ),
                      height10,
                      InputTextFelid(
                        controller: passwordController,
                        title: AppLocale.newPassword.getString(context),
                        hintText: AppLocale.resetPasswordHint.getString(context),
                        icon: Icons.lock,
                        isPassword: true,
                        isColorChange: true,
                      ),
                      InputTextFelid(
                        controller: confirmPasswordController,
                        title: AppLocale.confirmTitle.getString(context),
                        hintText: AppLocale.confirmPasswordHint.getString(context),
                        icon: Icons.lock,
                        isPassword: true,
                        isColorChange: true,
                      ),
                      height32,
                      CustomButton(
                        title: AppLocale.confirmEmail.getString(context),
                        backgroundColor: green,
                        onPressed: () {
                          context.read<AuthBloc>().add(ChangePasswordEvent(
                              password: passwordController.text,
                              confirmPassword: confirmPasswordController.text));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

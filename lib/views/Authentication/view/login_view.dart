import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:green_saudi_app/resources/extensions/screen_handler.dart';
import 'package:green_saudi_app/resources/localization/localization.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/resources/utils/spacing.dart';
import 'package:green_saudi_app/views/Authentication/bloc/auth_bloc.dart';
import 'package:green_saudi_app/views/Authentication/view/signup_view.dart';
import 'package:green_saudi_app/views/Authentication/view/validation_email_view.dart';
import 'package:green_saudi_app/views/Authentication/widget/custom_button.dart';
import '../widget/input_text_felid.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController =
      TextEditingController(text: 'sulta7nx7@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<AuthBloc>();
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoginSuccessState) {
                    bloc.add(CheckSessionAvailability());
                  } else if (state is SessionAvailabilityState) {
                    context.push(view: state.page, isPush: false);
                  } else if (state is AuthLoginErrorState) {
                    context.getMessagesBar(msg: state.message, color: red, success: false);
                  }
                },
                builder: (context, state) {
                  return Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/background_img_1.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        width: context.getWidth() * 0.80,
                        height: context.getHeight() * 0.70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.black.withOpacity(0.21)
                            ],
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocale.welcome.getString(context),
                                style: TextStyle(
                                    color: pureWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 48),
                              ),
                              height16,
                              InputTextFelid(
                                controller: emailController,
                                title: AppLocale.emailTitle.getString(context),
                                hintText:
                                    AppLocale.emailHint.getString(context),
                                icon: Icons.email,
                                isPassword: false,
                              ),
                              InputTextFelid(
                                controller: passwordController,
                                title:
                                    AppLocale.passwordTitle.getString(context),
                                hintText:
                                    AppLocale.passwordHint.getString(context),
                                icon: Icons.lock,
                                isPassword: true,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  width16,
                                  InkWell(
                                    onTap: () {
                                      context.push(
                                          view: const ValidationEmailView(),
                                          isPush: true);
                                    },
                                    child: Text(
                                      AppLocale.forgatPasswordTitle
                                          .getString(context),
                                      style: TextStyle(
                                        color: pureWhite,
                                        fontSize: 17,
                                        height: 0.9,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              height26,
                              CustomButton(
                                title: AppLocale.login.getString(context),
                                onPressed: () {
                                  bloc.add(LoginEvent(
                                      email: emailController.text,
                                      password: passwordController.text));
                                },
                                backgroundColor: green,
                              ),
                              InkWell(
                                  onTap: () {
                                    context.push(
                                        view: const SignUpView(), isPush: true);
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      text: AppLocale.haveAccount
                                          .getString(context),
                                      style: TextStyle(
                                        color: pureWhite,
                                        fontSize: 20,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: AppLocale.richText
                                              .getString(context),
                                          style: TextStyle(
                                            color: green,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )),
        );
      }),
    );
  }
}

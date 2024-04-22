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

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<AuthBloc>();
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSignUpSuccessState) {
                  context.getMessagesBar(msg: state.message, color: green);
                  context.push(view: const LoginView(), isPush: false);
                } else if (state is AuthSignUpErrorState) {
                  context.getMessagesBar(msg: state.message, color: red, success: false);
                }
              },
              builder: (context, state) {
                return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/background_img_2.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        width: context.getWidth() * 0.80,
                        height: context.getHeight() * 1.20,
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
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 48),
                              ),
                              height26,
                              InputTextFelid(
                                controller: nameController,
                                title: AppLocale.nameTitle.getString(context),
                                hintText: AppLocale.nameHint.getString(context),
                                icon: Icons.person_outline,
                                isPassword: false,
                              ),
                              InputTextFelid(
                                controller: emailController,
                                title: AppLocale.emailTitle.getString(context),
                                hintText: "example@email.com",
                                icon: Icons.email,
                                isPassword: false,
                              ),
                              InputTextFelid(
                                controller: phoneController,
                                title: AppLocale.phoneNumber.getString(context),
                                hintText: "0555555555",
                                icon: Icons.phone_outlined,
                                isPassword: false,
                              ),
                              InputTextFelid(
                                controller: passwordController,
                                title: AppLocale.passwordTitle.getString(context),
                                hintText: AppLocale.passwordHint.getString(context),
                                icon: Icons.lock,
                                isPassword: true,
                              ),
                              InputTextFelid(
                                controller: confirmPasswordController,
                                title: AppLocale.confirmTitle.getString(context),
                                hintText: AppLocale.confirmTitle.getString(context),
                                icon: Icons.lock,
                                isPassword: true,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  width42,
                                  InkWell(
                                    onTap: () {
                                      context.push(
                                          view: const LoginView(), isPush: false);
                                    },
                                    child: Text(
                                      AppLocale.haveAccountAlready.getString(context),
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              height20,
                              CustomButton(
                                title: AppLocale.signUp.getString(context),
                                onPressed: () {
                                  bloc.add(SignUpEvent(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                    confirmPassword: confirmPasswordController.text,
                                  ));
                                },
                                backgroundColor: green,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}

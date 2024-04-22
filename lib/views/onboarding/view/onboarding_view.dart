import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:green_saudi_app/locators/data_injection.dart';
import 'package:green_saudi_app/model/onboarding_model.dart';
import 'package:green_saudi_app/resources/extensions/screen_handler.dart';
import 'package:green_saudi_app/resources/localization/localization.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/resources/utils/spacing.dart';
import 'package:green_saudi_app/service/supabase_services.dart';
import 'package:green_saudi_app/views/Authentication/view/login_view.dart';
import 'package:green_saudi_app/views/Supervisor/view/qr_code_reader.dart';
import 'package:green_saudi_app/views/onboarding/bloc/onboarding_bloc.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceLocator = DataInjection().locator.get<DBServices>();

    List<Onboarding> onboardingItems = [
      Onboarding(
        title: AppLocale.onBoardingTitle1.getString(context),
        description: AppLocale.onBoardingText1.getString(context),
        image:
            "assets/images/354624_Saudi green with many trees  _xl-1024-v1-0.png",
      ),
      Onboarding(
        title: AppLocale.onBoardingTitle2.getString(context),
        description: AppLocale.onBoardingText1.getString(context),
        image: "assets/images/emission-target.jpg",
      ),
      Onboarding(
        title: AppLocale.onBoardingTitle3.getString(context),
        description: AppLocale.onBoardingText1.getString(context),
        image: "assets/images/ef57f528-4fd4-409a-8473-ee471d0a4fc9.png",
      ),
    ];

    return BlocProvider(
      create: (context) => OnboardingBloc(onboardingItems),
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          final onboardingBloc = BlocProvider.of<OnboardingBloc>(context);
          // ** Preload all images for smooth transaction ** \\
          for (final item in onboardingItems) {
            precacheImage(AssetImage(item.image), context);
          }
          precacheImage(
              const AssetImage("assets/images/background_img_1.png"), context);
          return Scaffold(
            body: PageView.builder(
              onPageChanged: (index) {
                if (state is! OnboardingLoadedState) {
                  onboardingBloc.add(NextViewEvent());
                }
              },
              itemCount: onboardingItems.length,
              itemBuilder: (context, index) {
                final currentIndex =
                    state is OnboardingLoadedState ? state.currentIndex : 0;
                return SafeArea(
                  child: Container(
                    width: context.getWidth(),
                    height: context.getHeight(),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(onboardingItems[currentIndex].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: context.getWidth() * .3,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.transparent,
                                  border: Border.all(width: 2, color: grey),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    context.push(
                                        view: const LoginView(), isPush: false);
                                  },
                                  child: Text(
                                    AppLocale.skip.getString(context),
                                    style: TextStyle(color: white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        height100,
                        //Titles
                        Text(
                          onboardingItems[currentIndex].title,
                          style: TextStyle(
                            fontSize: 25,
                            color: green,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        height100,
                        //Description
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: SizedBox(
                            width: context.getWidth(),
                            height: context.getHeight() * .16,
                            child: Text(
                              onboardingItems[currentIndex].description,
                              style: TextStyle(color: grey, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        height100,
                        // dots
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            onboardingItems.length,
                            (index) => AnimatedContainer(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: currentIndex == index ? green : grey,
                              ),
                              height: 7,
                              width: currentIndex == index ? 30 : 7,
                              duration: const Duration(milliseconds: 1000),
                            ),
                          ),
                        ),
                        height40,
                        // button
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          width: context.getWidth() * .9,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: green,
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (currentIndex == onboardingItems.length - 1) {
                                context.push(
                                    view: const LoginView(), isPush: false);
                              } else {
                                onboardingBloc.add(NextViewEvent());
                              }
                            },
                            child: Text(
                              currentIndex == onboardingItems.length - 1
                                  ? AppLocale.start.getString(context)
                                  : AppLocale.move.getString(context),
                              style: TextStyle(color: pureWhite, fontSize: 24),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: serviceLocator.user.typeRole == "supervisor"
                ? FloatingActionButton(onPressed: () {
                    context.push(view: const ScanView(), isPush: true);
                  })
                : const SizedBox(),
          );
        },
      ),
    );
  }
}

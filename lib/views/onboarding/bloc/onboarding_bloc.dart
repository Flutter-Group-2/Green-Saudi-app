import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_saudi_app/model/onboarding_model.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc(List<Onboarding> onboardingItems)
      : super(OnboardingInitial(onboardingItems: onboardingItems)) {
    on<NextViewEvent>(
      (event, emit) {
        if (state is OnboardingInitial) {
          emit(OnboardingLoadedState(currentIndex: 1));
        } else if (state is OnboardingLoadedState) {
          final currentState = state as OnboardingLoadedState;
          final currentIndex = currentState.currentIndex;
          final items = onboardingItems;
          if (currentIndex < items.length - 1) {
            emit(OnboardingLoadedState(currentIndex: currentIndex + 1));
          }
        }
      },
    );
  }
}

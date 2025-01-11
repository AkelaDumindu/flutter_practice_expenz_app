import 'package:flutter_expenz_app/models/onboarding_model.dart';

class OnboardingData {
  static final List<Onboarding> onboardingDataList = [
    Onboarding(
        title: "Gain total control of your money",
        description: "Become your own money manager and make every cent count",
        imagePath: "assets/images/onboard_1.png"),
    Onboarding(
        title: "Know where your money goes",
        description:
            "Track your transaction easily, with categories and financial report",
        imagePath: "assets/images/onboard_2.png"),
    Onboarding(
        title: "Planning ahead",
        description: "Setup your budget for each category so you in control",
        imagePath: "assets/images/onboard_3.png"),
  ];
}

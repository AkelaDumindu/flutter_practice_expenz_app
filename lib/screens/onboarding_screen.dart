import 'package:flutter/material.dart';
import 'package:flutter_expenz_app/data/onboarding_data.dart';
import 'package:flutter_expenz_app/screens/onboarding/front_onboarding.dart';
import 'package:flutter_expenz_app/screens/onboarding/shared_onboarding_screen.dart';
import 'package:flutter_expenz_app/screens/user_data_screen.dart';
import 'package:flutter_expenz_app/utilz/color.dart';
import 'package:flutter_expenz_app/widgets/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  bool showDetailsPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView(
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() {
                      showDetailsPage = index == 3;
                    });
                  },
                  children: [
                    const FrontPageOnboarding(),
                    SharedOnboardingScreen(
                      title: OnboardingData.onboardingDataList[0].title,
                      imagePath: OnboardingData.onboardingDataList[0].imagePath,
                      desccription:
                          OnboardingData.onboardingDataList[0].description,
                    ),
                    SharedOnboardingScreen(
                      title: OnboardingData.onboardingDataList[1].title,
                      imagePath: OnboardingData.onboardingDataList[1].imagePath,
                      desccription:
                          OnboardingData.onboardingDataList[1].description,
                    ),
                    SharedOnboardingScreen(
                      title: OnboardingData.onboardingDataList[2].title,
                      imagePath: OnboardingData.onboardingDataList[2].imagePath,
                      desccription:
                          OnboardingData.onboardingDataList[2].description,
                    ),
                  ],
                ),
                // Page dot indicator
                Container(
                  alignment: const Alignment(
                      0, 0.75), // 0 is middle, 1 is bottom, and -1 is top
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: 4,
                    effect: const WormEffect(
                      activeDotColor: kMainColor,
                      dotColor: kLightGrey,
                    ),
                  ),
                ),
                // Button
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: GestureDetector(
                      onTap: () {
                        if (showDetailsPage) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserDataScreen(),
                            ),
                          );
                        } else {
                          controller.animateToPage(
                            controller.page!.toInt() + 1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: CustomButton(
                        buttonName: showDetailsPage ? "Get Started" : "Next",
                        color: kMainColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

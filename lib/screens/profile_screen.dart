import 'package:flutter/material.dart';
import 'package:flutter_expenz_app/screens/onboarding_screen.dart';
import 'package:flutter_expenz_app/services/expense_services.dart';
import 'package:flutter_expenz_app/services/income_services.dart';
import 'package:flutter_expenz_app/services/user_data_service.dart';
import 'package:flutter_expenz_app/utilz/color.dart';
import 'package:flutter_expenz_app/widgets/profile_card.dart';

import '../utilz/constant.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "";
  String email = "";

  //open scffold messenger for logout
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: kLightGrey,
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.all(kDefalutPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Are you sure you want to log out?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kGrey,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(kMainColor),
                    ),
                    onPressed: () async {
                      // Clear the user details from shared preferences
                      await UserService.clearUserDetails();

                      //remove all expenses and incomes
                      if (context.mounted == true) {
                        await ExpenseServices().deleteAllExpenses(context);
                        await IncomeServices().deleteAllIncomes(context);
                      }

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnboardingScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                        color: kWhite,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kMainColor),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "No",
                      style: TextStyle(
                        color: kWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    //get the user details from the shared preferences
    UserService.getUserDetails().then((value) {
      //check if the user details are not null
      if (value['username'] != null && value['email'] != null) {
        //set the username and email to the state
        setState(() {
          username = value['username']!;
          email = value['email']!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefalutPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: kMainColor,
                      border: Border.all(
                        color: kMainColor,
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/images/user.jpg",
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: kGrey,
                        ),
                      ),
                      Text(
                        "Welcome $username",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kLightGrey,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: kMainColor,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const ProfileCard(
                icon: Icons.wallet,
                title: "My Wallet",
                color: kMainColor,
              ),
              const ProfileCard(
                icon: Icons.settings,
                title: "Settings",
                color: kMainColor,
              ),
              const ProfileCard(
                icon: Icons.download,
                title: "Export Data",
                color: kMainColor,
              ),
              GestureDetector(
                onTap: () {
                  _showBottomSheet(context);
                },
                child: const ProfileCard(
                  icon: Icons.logout,
                  title: "Log Out",
                  color: kRed,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

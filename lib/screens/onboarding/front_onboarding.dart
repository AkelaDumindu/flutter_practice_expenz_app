import 'package:flutter/material.dart';
import 'package:flutter_expenz_app/utilz/color.dart';

class FrontPageOnboarding extends StatelessWidget {
  const FrontPageOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/logo.png",
          width: 100,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Expenz",
          style: TextStyle(
              fontSize: 40, color: kMainColor, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

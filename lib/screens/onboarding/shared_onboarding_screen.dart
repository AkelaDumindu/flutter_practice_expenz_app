import 'package:flutter/material.dart';
import 'package:flutter_expenz_app/utilz/color.dart';
import 'package:flutter_expenz_app/utilz/constant.dart';

class SharedOnboardingScreen extends StatelessWidget {
  final String title;
  final String imagePath;
  final String desccription;
  const SharedOnboardingScreen(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.desccription});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefalutPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 300,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            desccription,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: kGrey),
          )
        ],
      ),
    );
  }
}

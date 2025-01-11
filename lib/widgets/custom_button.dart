import 'package:flutter/material.dart';
import 'package:flutter_expenz_app/utilz/color.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final Color color;
  const CustomButton(
      {super.key, required this.buttonName, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: color,
      ),
      child: Center(
        child: Text(
          buttonName,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: kWhite),
        ),
      ),
    );
  }
}

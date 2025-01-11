import 'package:flutter/material.dart';
import 'package:flutter_expenz_app/utilz/color.dart';
import 'package:flutter_expenz_app/utilz/constant.dart';

class IncomeExpenceCard extends StatefulWidget {
  final String title;
  final double amount;
  final Color color;
  final String imageUrl;
  const IncomeExpenceCard(
      {super.key,
      required this.title,
      required this.amount,
      required this.color,
      required this.imageUrl});

  @override
  State<IncomeExpenceCard> createState() => _IncomeExpenceCardState();
}

class _IncomeExpenceCardState extends State<IncomeExpenceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: widget.color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefalutPadding),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Image.asset(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  width: 30,
                ),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(fontSize: 16, color: kWhite),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.amount.toStringAsFixed(0),
                  style: const TextStyle(fontSize: 18, color: kWhite),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

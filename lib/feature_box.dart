import 'package:elaine/pallet.dart';
import 'package:flutter/material.dart';

class FeatureBox extends StatelessWidget {
  final String headerText;
  final String bodyText;
  final Color color;
  const FeatureBox({
    super.key,
    required this.headerText,
    required this.bodyText,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.07,
        vertical: screenHeight * 0.008,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20).copyWith(
          left: 15,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerText,
                style: TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Pallete.blackColor,
                  fontSize: screenHeight * 0.025,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.005,
            ),
            Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.05),
              child: Text(
                bodyText,
                style: TextStyle(
                    fontFamily: 'Cera Pro',
                    color: Pallete.blackColor,
                    fontSize: screenHeight * 0.015),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

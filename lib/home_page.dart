import 'package:elaine/pallet.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Elaine"),
        centerTitle: true,
        leading: const Icon(Icons.menu),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Center(
                child: Container(
                  height: screenHeight * 0.25,
                  width: screenWidth * 0.40,
                  margin: const EdgeInsets.only(top: 5),
                  decoration: const BoxDecoration(
                    color: Pallete.assistantCircleColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.23,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/profile.png'),
                    )),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenHeight * 0.02,
              vertical: screenWidth * 0.02,
            ),
            margin: EdgeInsets.symmetric(horizontal: screenHeight * 0.02)
                .copyWith(top: screenHeight * 0.03),
            decoration: BoxDecoration(
              border: Border.all(
                color: Pallete.borderColor,
                width: 2,
              ),
              borderRadius:
                  BorderRadius.circular(15).copyWith(topLeft: Radius.zero),
            ),
            child: Text(
              "Ara ara, How can I help you Sweetie 😘 ?",
              style: TextStyle(
                  color: Pallete.mainFontColor,
                  fontFamily: 'Cera Pro',
                  fontSize: screenHeight * 0.03),
            ),
          ),
        ],
      ),
    );
  }
}

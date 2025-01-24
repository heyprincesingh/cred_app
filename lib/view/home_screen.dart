import 'package:cred_stack/view/loan_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff0f131b),
        appBar: AppBar(
          title: Text(
            "CRED cash",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          backgroundColor: const Color(0xff0f131b),
        ),
        body: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: MediaQuery.sizeOf(context).width / 1.2,
                child: Text(
                  "Withdraw instantly from\nyour personal credit line",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 1.5, wordSpacing: 2.5),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(
                    LoanScreen(),
                    transition: Transition.downToUp,
                    duration: Duration(
                      milliseconds: 250
                    )
                  );
                },
                child: exploreButton(
                  (MediaQuery.sizeOf(context).width / 1.65) + 10,
                  "Explore now",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

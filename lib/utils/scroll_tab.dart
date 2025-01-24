import 'package:flutter/material.dart';

Widget scrollTab({
  required double height,
  required double width,
  required Widget activeTitle,
  Widget? inactiveTitle,
  required Widget centerWidget,
  required String cta_text,
  required VoidCallback onTap,
  required bool isActive,
  required Color boxColor,
}) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 300),
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: boxColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isActive ? activeTitle : (inactiveTitle ?? SizedBox.shrink()),
              if (!isActive)
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white,
                  size: 30,
                )
            ],
          ),
        ),
        Column(
          children: [
            centerWidget,
            GestureDetector(
              onTap: onTap,
              child: Container(
                height: 80,
                width: width,
                decoration: BoxDecoration(
                  color: Color(0xff335fcd),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Text(
                    cta_text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

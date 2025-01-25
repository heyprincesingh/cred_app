import 'package:flutter/material.dart';

Container exploreButton(double width, String title) {
  return Container(
    width: width,
    height: 65,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.white24,
          blurRadius: 10.0,
          spreadRadius: -3,
          offset: Offset(-6, -6),
        ),
      ],
      borderRadius: BorderRadius.circular(40.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xff0f131b),
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          width: width,
          height: 55,
          decoration: BoxDecoration(
            color: Color(0xff25407b),
            borderRadius: BorderRadius.circular(35.0),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
import 'dart:ffi';

import 'package:flutter/material.dart';

class CircleNumber extends StatelessWidget {
  int number;
  Color color;
  CircleNumber({super.key, required this.color, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

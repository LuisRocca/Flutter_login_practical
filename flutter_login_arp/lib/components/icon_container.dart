import 'dart:ui';

import 'package:flutter/material.dart';

class iconConrainer extends StatelessWidget {
  const iconConrainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 237, 243, 241),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 10, offset: Offset(0, 10))
          ]),
      padding: const EdgeInsets.all(15),
      child: Center(
        child: Image.asset('assets/linux.png'),
      ),
    );
  }
}

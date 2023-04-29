import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class AvatarIcon extends StatelessWidget {
  const AvatarIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Stack(children: [
      Container(
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: Offset(0, 10))
        ]),
        child: ClipOval(
          child: Image.asset(
            'assets/man.png',
            width: responsive.wp(23),
            height: responsive.hp(23),
          ),
        ),
      ),
      Positioned(
        bottom: 10,
        right: -16,
        child: CupertinoButton(
            // padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
            onPressed: () {}),
      ),
    ]);
  }
}

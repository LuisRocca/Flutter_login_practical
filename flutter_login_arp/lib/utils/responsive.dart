import 'package:flutter/material.dart';

import 'dart:math' as math;

class Responsive {
  late double _widht, _height, _diagonal;
  late bool isTablet;

  double get widht => _widht;
  double get height => _height;
  double get diagonal => _diagonal;

  static Responsive of(BuildContext context) => Responsive(context);

  Responsive(BuildContext context) {
    final Size diviceSeze = MediaQuery.of(context).size;
    _widht = diviceSeze.width;
    _height = diviceSeze.height;
    // c2+ a2+b2 => c amt(a2+b2) Teorema de Pitagoras
    _diagonal = math.sqrt(math.pow(_widht, 2) + math.pow(_height, 2));
    isTablet = diviceSeze.shortestSide >= 600 ? true : false;
  }
  double wp(double porcent) => _widht * porcent / 100;
  double hp(double porcent) => _height * porcent / 100;
  double dp(double porcent) => _diagonal * porcent / 100;
}

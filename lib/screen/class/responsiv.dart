import 'package:flutter/material.dart';

extension screenSize on BuildContext {
  get screenWidth => MediaQuery.of(this).size.width;
  get screenHeight => MediaQuery.of(this).size.height;
}

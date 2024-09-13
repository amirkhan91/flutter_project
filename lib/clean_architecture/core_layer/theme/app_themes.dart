import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constant/my_colors.dart';

class AppThemes{
  AppThemes._();
  static final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primaryColors,
    )
  );
  static final lidarkght = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: MyColors.secondaryColor,
    )
  );
}
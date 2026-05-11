import 'package:flutter/material.dart';
import 'package:movie/core/config/theme/app_colors.dart';

abstract class AppThemeManager {
static ThemeData getTheme ()=> ThemeData(
scaffoldBackgroundColor:AppColors.thirdTextColor,
);
}
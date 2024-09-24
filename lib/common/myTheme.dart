import 'package:fixit/common/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTheme{
  static final  darkTheme=ThemeData(
    primarySwatch: MaterialColor(0xFF039759, getSwatch(const Color(0xFF039759))),
    scaffoldBackgroundColor: ColorConstants.scaffoldDark,
    fontFamily:'Work Sans',
    appBarTheme:const AppBarTheme(
      color: ColorConstants.scaffoldDark,
    ) ,
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: ColorConstants.primaryColor,
      secondary:ColorConstants.buttonColorLight,
      primaryContainer:ColorConstants.selectedContainerDark,
      onPrimaryContainer:ColorConstants.unSelectedContainerLight,
      tertiary:  ColorConstants.headerTextDark,
      onTertiary:ColorConstants.subheadingTextDark,
      error:ColorConstants.hintTextDark,
      errorContainer: ColorConstants.containerTextLight,
    ),
  );


  static final  lightTheme=ThemeData(
    primarySwatch: MaterialColor(0xFF039759, getSwatch(const Color(0xFF039759))),
    scaffoldBackgroundColor: ColorConstants.scaffoldLight,
    fontFamily:'Work Sans',
    appBarTheme:const AppBarTheme(
      color: ColorConstants.scaffoldLight,
    ) ,
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: ColorConstants.primaryColor,
      secondary:ColorConstants.buttonColorDark,
      primaryContainer:ColorConstants.unSelectedContainerLight,
      onPrimaryContainer:ColorConstants.unSelectedContainerDark,
      tertiary:  ColorConstants.headerTextLight,
      onTertiary:ColorConstants.subheadingTextLight,
      error:ColorConstants.hintTextLight,
      errorContainer: ColorConstants.containerTextDark,
    ),
  );
}

Map<int, Color> getSwatch(Color color) {
  final hslColor = HSLColor.fromColor(color);
  final lightness = hslColor.lightness;
  const lowDivisor = 6;
  const highDivisor = 5;
  final lowStep = (1.0 - lightness) / lowDivisor;
  final highStep = lightness / highDivisor;
  return {
    50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
    100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
    200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
    300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
    400: (hslColor.withLightness(lightness + lowStep)).toColor(),
    500: (hslColor.withLightness(lightness)).toColor(),
    600: (hslColor.withLightness(lightness - highStep)).toColor(),
    700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
    800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
    900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
  };
}

class ThemeController extends GetxController{
  var themeMode=ThemeMode.dark.obs;
  final String themeModeKey = 'theme_mode_key';
  @override
  void onInit() {
    super.onInit();
    loadSavedThemeMode();
  }

  Future<void> loadSavedThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getString(themeModeKey);
    if (savedMode != null) {
      themeMode.value = (savedMode == 'dark') ? ThemeMode.dark : ThemeMode.light;
    }
  }

  void toggleTheme() {
    themeMode.value = (themeMode.value == ThemeMode.light)
        ? ThemeMode.dark
        : ThemeMode.light;
    _saveThemeMode();
  }

  Future<void> _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(themeModeKey, themeMode.value.toString().split('.').last);
  }

  ThemeMode getThemeMode() {
    return themeMode.value;
  }

}
import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

// 浅色主题
final appLightTheme = FlexThemeData.light(
  scheme: FlexScheme.money,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 7,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 10,
    blendOnColors: false,
    useTextTheme: true,
    useM2StyleDividerInM3: true,
    alignedDropdown: true,
    useInputDecoratorThemeInDialogs: true,
    appBarCenterTitle: true,
    textButtonRadius: 4.0,
    filledButtonRadius: 4.0,
    elevatedButtonRadius: 4.0,
    outlinedButtonRadius: 4.0,
    segmentedButtonRadius: 8.0,
    segmentedButtonBorderWidth: 0.5,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 18.0),
  ),
  fontFamily: SystemChineseFont.systemFont,
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
);

// 深色主题
final appDarkTheme = FlexThemeData.dark(
  scheme: FlexScheme.money,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 13,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    useTextTheme: true,
    useM2StyleDividerInM3: true,
    alignedDropdown: true,
    useInputDecoratorThemeInDialogs: true,
    appBarCenterTitle: true,
    textButtonRadius: 4.0,
    filledButtonRadius: 4.0,
    elevatedButtonRadius: 4.0,
    outlinedButtonRadius: 4.0,
    segmentedButtonRadius: 8.0,
    segmentedButtonBorderWidth: 0.5,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 18.0),
  ),
  fontFamily: SystemChineseFont.systemFont,
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
);

class MyDialogTheme {
  static const radius = 4.0;
  static const dialogWidth = 270.0;
  static const dialogContentMinHeight = 60.0;
  static const dialogBottomActionHeight = 44.0;
  static const dialogDividerWidth = 1.0;
  static const padding = 16.0;
}

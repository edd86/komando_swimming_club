import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  // The defined light theme.
  static ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.greenM3,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      elevatedButtonSchemeColor: SchemeColor.onPrimary,
      elevatedButtonSecondarySchemeColor: SchemeColor.primary,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: 22.0,
      inputDecoratorBorderWidth: 1.0,
      inputDecoratorFocusedBorderWidth: 2.0,
      listTileTileSchemeColor: SchemeColor.onPrimaryFixed,
      alignedDropdown: true,
      snackBarRadius: 14,
      snackBarElevation: 5,
      bottomSheetBackgroundColor: SchemeColor.primaryContainer,
      bottomSheetModalBackgroundColor: SchemeColor.primaryContainer,
      bottomSheetElevation: 5.0,
      bottomSheetModalElevation: 5.0,
      searchBarElevation: 5.0,
      searchViewElevation: 5.0,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
  // The defined dark theme.
  static ThemeData dark = FlexThemeData.dark(
    scheme: FlexScheme.greenM3,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      elevatedButtonSchemeColor: SchemeColor.onPrimary,
      elevatedButtonSecondarySchemeColor: SchemeColor.primary,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: 22.0,
      inputDecoratorBorderWidth: 1.0,
      inputDecoratorFocusedBorderWidth: 2.0,
      listTileTileSchemeColor: SchemeColor.onPrimaryFixed,
      alignedDropdown: true,
      snackBarRadius: 14,
      snackBarElevation: 5,
      bottomSheetBackgroundColor: SchemeColor.primaryContainer,
      bottomSheetModalBackgroundColor: SchemeColor.primaryContainer,
      bottomSheetElevation: 5.0,
      bottomSheetModalElevation: 5.0,
      searchBarElevation: 5.0,
      searchViewElevation: 5.0,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}

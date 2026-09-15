import 'package:flutter/material.dart';
import 'font_manager.dart';

// Base helper method
TextStyle _getTextStyle(double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    color: color,
  );
}

// Regular style
TextStyle getRegularStyle({double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.regular, color);
}

// Medium style
TextStyle getMediumStyle({double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.medium, color);
}

// Bold style
TextStyle getBoldStyle({double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.bold, color);
}
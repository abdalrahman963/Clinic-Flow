import 'package:flutter/material.dart';

class ColorManager {
  // --- Brand Colors ---
  static Color primary = HexColor.fromHex("#0D47A1"); // Example Dark Blue
  static Color secondary = HexColor.fromHex("#1976D2"); 
  static Color lightPrimary = HexColor.fromHex("#63A4FF");
  static Color primaryOpacity70 = HexColor.fromHex("#B30D47A1");

  // --- Map Specific Colors ---
  static Color mapPinRed = Colors.red;
  static Color mapClinicBlue = Colors.blue.shade800;

  // --- Neutrals & Backgrounds ---
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color primaryBackground = HexColor.fromHex("#F2F2F2");
  
  // --- Standard Colors ---
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color black = HexColor.fromHex("#000000");
  static Color error = HexColor.fromHex("#E61F34"); // Red for errors
}

// A handy extension to easily use standard Web Hex codes in Flutter
extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
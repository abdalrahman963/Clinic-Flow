import 'package:clinic_flow/core/theme/color_manager.dart';
import 'package:clinic_flow/core/theme/font_manager.dart';
import 'package:clinic_flow/core/theme/styles_manager.dart';
import 'package:flutter/material.dart';



class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      validator: validator,
      style: getRegularStyle(color: ColorManager.black, fontSize: FontSize.s16),
      decoration: InputDecoration(
        hintText: hintText,
        // Matching the grey hint text from the login page
        hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14), 
        prefixIcon: prefixIcon != null 
            ? Icon(prefixIcon, color: const Color(0xFF64748B)) // Grey icon matching login
            : null,
        
        // --- Identical Login Page Styling ---
        filled: true,
        fillColor: const Color(0xFFF1F5F9), // Soft grey background
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        
        // Default border matches the _TextFieldCard
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
        
        // When clicked, it highlights with the primary blue
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF0284C7), width: 2),
        ),
        
        // Error state border
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF9F1239), width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF9F1239), width: 2),
        ),
      ),
    );
  }
}
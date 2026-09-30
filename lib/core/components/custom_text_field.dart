import 'package:clinic_flow/core/theme/color_manager.dart';
import 'package:clinic_flow/core/theme/font_manager.dart';
import 'package:clinic_flow/core/theme/styles_manager.dart';
import 'package:clinic_flow/core/theme/values_manager.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller; // <-- Here is how the page controls it!
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
        hintStyle: getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        prefixIcon: prefixIcon != null 
            ? Icon(prefixIcon, color: ColorManager.primary) 
            : null,
        
        // --- Styling the borders ---
        filled: true,
        fillColor: ColorManager.white,
        contentPadding: const EdgeInsets.all(AppPadding.p16),
        
        // Default border
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
          borderSide: BorderSide(color: ColorManager.lightGrey, width: 1),
        ),
        
        // Border when the user clicks on it
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
          borderSide: BorderSide(color: ColorManager.primary, width: 2),
        ),
        
        // Border when validation fails
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
          borderSide: BorderSide(color: ColorManager.error, width: 1),
        ),
      ),
    );
  }
}
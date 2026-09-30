import 'package:clinic_flow/core/theme/color_manager.dart';
import 'package:clinic_flow/core/theme/font_manager.dart';
import 'package:clinic_flow/core/theme/styles_manager.dart' show getBoldStyle, getRegularStyle;
import 'package:clinic_flow/core/theme/values_manager.dart';
import 'package:flutter/material.dart';

class CustomTextCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData? icon;

  const CustomTextCard({
    Key? key,
    required this.title,
    required this.description,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppSize.s12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, color: ColorManager.primary, size: AppSize.s24),
            const SizedBox(width: AppSize.s12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s16),
                ),
                const SizedBox(height: AppSize.s4),
                Text(
                  description,
                  style: getRegularStyle(color: ColorManager.darkGrey, fontSize: FontSize.s14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
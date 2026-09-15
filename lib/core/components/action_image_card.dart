import 'package:advanced_clinic_management_system_flutter/core/themes/color_manager.dart';
import 'package:advanced_clinic_management_system_flutter/core/themes/font_manager.dart';
import 'package:advanced_clinic_management_system_flutter/core/themes/values_manager.dart';
import 'package:flutter/material.dart';


class ActionImageCard extends StatelessWidget {
  final String title;
  final String imagePath; // Swapped IconData for an Image Path
  final VoidCallback onTap;

  const ActionImageCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.s12),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(AppSize.s12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. The Image Widget
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain, // Ensures the image isn't stretched or cut off
                ),
              ),
            ),
            
            // 2. The Text Label
            const SizedBox(height: AppSize.s4),
            Text(
              title,
              style: getBoldStyle(
                color: ColorManager.black, 
                fontSize: FontSize.s14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSize.s12), // Padding at the bottom
          ],
        ),
      ),
    );
  }
  
  TextStyle? getBoldStyle({required Color color, required fontSize}) {
    return null;
  }
}
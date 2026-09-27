
import 'package:clinic_flow/core/components/action_image_card.dart';
import 'package:clinic_flow/core/theme/color_manager.dart';
import 'package:clinic_flow/core/theme/font_manager.dart';
import 'package:clinic_flow/core/theme/styles_manager.dart';
import 'package:clinic_flow/core/theme/values_manager.dart';
import 'package:flutter/material.dart';


class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryBackground, 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSize.s16),
              Text(
                "Advanced Clinic",
                style: getBoldStyle(
                  color: ColorManager.primary, 
                  fontSize: FontSize.s22,
                ),
              ),
              const SizedBox(height: AppSize.s8),
              Text(
                "How can we help you today?",
                style: getRegularStyle(
                  color: ColorManager.darkGrey, 
                  fontSize: FontSize.s14,
                ),
              ),
              const SizedBox(height: AppSize.s24),

              // --- UPDATED GRID VIEW ---
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2, 
                  crossAxisSpacing: AppSize.s16, 
                  mainAxisSpacing: AppSize.s16, 
                  childAspectRatio: 1.1, 
                  children: [
                    // Using the new global ActionImageCard!
                    ActionImageCard(
                      title: "Clinic Visit",
                      imagePath: "assets/images/clinic_visit.jpg", // Match your file names
                      onTap: () {},
                    ),
                    ActionImageCard(
                      title: "Home Care",
                      imagePath: "assets/images/home_care.jpg",
                      onTap: () {},
                    ),
                    ActionImageCard(
                      title: "Procedures",
                      imagePath: "assets/images/procedures.jpg",
                      onTap: () {},
                    ),
                    ActionImageCard(
                      title: "Doctor Call",
                      imagePath: "assets/images/doctor_call.jpg",
                      onTap: () {},
                    ),
                    ActionImageCard(
                      title: "Labs & Scans",
                      imagePath: "assets/images/labs_scans.jpg",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
        backgroundColor: ColorManager.white,
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: "Appointments",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
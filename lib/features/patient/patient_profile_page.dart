
import 'package:clinic_flow/core/theme/color_manager.dart';
import 'package:clinic_flow/core/theme/font_manager.dart';
import 'package:clinic_flow/core/theme/styles_manager.dart';
import 'package:clinic_flow/core/theme/values_manager.dart';
import 'package:clinic_flow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clinic_flow/features/auth/presentation/bloc/auth_event.dart';
import 'package:clinic_flow/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class PatientProfilePage extends StatelessWidget {
  const PatientProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // We ensure we only show the profile if the user is successfully authenticated
        if (state is AuthAuthenticated) {
          final user = state.session.user;

          return Scaffold(
            backgroundColor: ColorManager.primaryBackground,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'My Profile',
                style: getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s20),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: Column(
                children: [
                  // --- Avatar ---
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFFE0E7FF),
                    child: Icon(Icons.person, size: 50, color: Color(0xFF4F46E5)),
                  ),
                  const SizedBox(height: AppSize.s16),
                  
                  // --- Name & Email ---
                  Text(
                    user.name,
                    style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s22),
                  ),
                  const SizedBox(height: AppSize.s4),
                  Text(
                    user.email,
                    style: getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s16),
                  ),
                  const SizedBox(height: AppSize.s24),

                  // --- Info Cards ---
                  _ProfileInfoTile(icon: Icons.phone_outlined, title: 'Phone', value: user.phone ?? 'Not provided'),
                  const SizedBox(height: AppSize.s12),
                  _ProfileInfoTile(icon: Icons.calendar_today_outlined, title: 'Age', value: user.age != null ? '${user.age} years old' : 'Not provided'),
                  const SizedBox(height: AppSize.s12),
                  _ProfileInfoTile(icon: Icons.people_outline, title: 'Gender', value: user.gender ?? 'Not provided'),
                  const SizedBox(height: AppSize.s12),
                  _ProfileInfoTile(icon: Icons.badge_outlined, title: 'Account Type', value: user.role.name.toUpperCase()),
                  
                  const SizedBox(height: AppSize.s40),

                  // --- Logout Button ---
                  SizedBox(
                    width: double.infinity,
                    height: AppSize.s60,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Trigger the logout event
                        context.read<AuthBloc>().add(const AuthLogoutRequestedEvent());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFEE2E2), // Soft Red
                        foregroundColor: const Color(0xFF9F1239), // Dark Red Text
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                        ),
                        elevation: 0,
                      ),
                      icon: const Icon(Icons.logout),
                      label: Text(
                        'Logout',
                        style: getBoldStyle(color: const Color(0xFF9F1239), fontSize: FontSize.s16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        
        // Fallback state if something goes wrong
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

// A handy private widget just for styling the profile rows cleanly
class _ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ProfileInfoTile({required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppSize.s12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF64748B)),
          const SizedBox(width: AppSize.s16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
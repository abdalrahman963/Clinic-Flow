import 'package:clinic_flow/core/theme/color_manager.dart';
import 'package:clinic_flow/core/theme/font_manager.dart';
import 'package:clinic_flow/core/theme/styles_manager.dart';
import 'package:clinic_flow/core/theme/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc/shared_bloc.dart';
import '../bloc/shared_event.dart';
import '../bloc/shared_state.dart';

class DisplaySpecializationsPage extends StatefulWidget {
  const DisplaySpecializationsPage({super.key});

  @override
  State<DisplaySpecializationsPage> createState() => _DisplaySpecializationsPageState();
}

class _DisplaySpecializationsPageState extends State<DisplaySpecializationsPage> {
  @override
  void initState() {
    super.initState();
    // Fetch specializations if they aren't loaded yet
    if (context.read<SharedBloc>().state.specializations.isEmpty) {
      context.read<SharedBloc>().add(const FetchSpecializationsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Specializations',
          style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s20),
        ),
        iconTheme: IconThemeData(color: ColorManager.black),
      ),
      body: BlocBuilder<SharedBloc, SharedState>(
        builder: (context, state) {
          if (state.specializationsStatus == SharedStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.specializationsStatus == SharedStatus.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage ?? 'An error occurred', style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<SharedBloc>().add(const FetchSpecializationsEvent()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state.specializations.isEmpty) {
            return const Center(child: Text('No specializations available.'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(AppPadding.p20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSize.s16,
              mainAxisSpacing: AppSize.s16,
              childAspectRatio: 1.0,
            ),
            itemCount: state.specializations.length,
            itemBuilder: (context, index) {
              final spec = state.specializations[index];
              return Container(
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(AppSize.s16),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Render the mapped local image gracefully
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          spec.imagePath,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.medical_services, size: 50, color: ColorManager.grey);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        spec.name,
                        style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
import 'package:clinic_flow/core/theme/color_manager.dart';
import 'package:clinic_flow/core/theme/font_manager.dart';
import 'package:clinic_flow/core/theme/styles_manager.dart';
import 'package:clinic_flow/core/theme/values_manager.dart';
import 'package:clinic_flow/features/shared/presentation/bloc/shared_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc/shared_event.dart';
import '../bloc/shared_state.dart';

class DisplayGovernatesPage extends StatefulWidget {
  const DisplayGovernatesPage({super.key});

  @override
  State<DisplayGovernatesPage> createState() => _DisplayGovernatesPageState();
}

class _DisplayGovernatesPageState extends State<DisplayGovernatesPage> {
  @override
  void initState() {
    super.initState();
    // Only fetch if the list is empty to avoid unnecessary API calls
    if (context.read<SharedBloc>().state.governates.isEmpty) {
      context.read<SharedBloc>().add(const FetchGovernatesEvent());
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
          'Governates',
          style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s20),
        ),
        iconTheme: IconThemeData(color: ColorManager.black),
      ),
      body: BlocBuilder<SharedBloc, SharedState>(
        builder: (context, state) {
          if (state.governatesStatus == SharedStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.governatesStatus == SharedStatus.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage ?? 'An error occurred', style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<SharedBloc>().add(const FetchGovernatesEvent()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state.governates.isEmpty) {
            return const Center(child: Text('No governates available.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppPadding.p20),
            itemCount: state.governates.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSize.s12),
            itemBuilder: (context, index) {
              final governate = state.governates[index];
              return Container(
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                ),
                child: ListTile(
                  leading: Icon(Icons.location_city, color: ColorManager.primary),
                  title: Text(
                    governate.name,
                    style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:clinic_flow/core/theme/color_manager.dart';
import 'package:clinic_flow/core/theme/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/custom_text_field.dart';
import '../../../../core/components/custom_main_button.dart';
import '../../../../core/components/custom_text_card.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  
  // We can default gender to male per your JSON request
  String _selectedGender = 'male'; 

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<AuthBloc>().add(
      AuthRegisterSubmittedEvent(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        role: 'user', // Hardcoded to match your request
        phone: _phoneController.text.trim(),
        age: int.tryParse(_ageController.text.trim()) ?? 0,
        gender: _selectedGender,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // If successful, pop back so AuthGatePage can route to the dashboard
          Navigator.of(context).pop(); 
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.primaryBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(color: Colors.black87),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1E293B), // Matching colleague's theme
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Join ACMS to book your clinics easily.',
                      style: TextStyle(color: Color(0xFF64748B)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    // Display errors using our CustomTextCard
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthUnauthenticated && state.errorMessage != null) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: AppSize.s16),
                            child: CustomTextCard(
                              title: 'Registration Error',
                              description: state.errorMessage!,
                              icon: Icons.error_outline,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                    CustomTextField(
                      controller: _nameController,
                      hintText: 'Full Name',
                      prefixIcon: Icons.person_outline,
                    ),
                    const SizedBox(height: AppSize.s16),
                    
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email Address',
                      prefixIcon: Icons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppSize.s16),

                    CustomTextField(
                      controller: _phoneController,
                      hintText: 'Phone Number',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: AppSize.s16),

                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _ageController,
                            hintText: 'Age',
                            prefixIcon: Icons.calendar_month_outlined,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: AppSize.s16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedGender,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: ColorManager.white,
                              contentPadding: const EdgeInsets.all(AppPadding.p16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppSize.s12),
                                borderSide: BorderSide(color: ColorManager.lightGrey, width: 1),
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(value: 'male', child: Text('Male')),
                              DropdownMenuItem(value: 'female', child: Text('Female')),
                            ],
                            onChanged: (val) {
                              setState(() {
                                _selectedGender = val ?? 'male';
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.s16),

                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    const SizedBox(height: AppSize.s24),

                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return CustomMainButton(
                          text: 'Sign Up',
                          isLoading: state is AuthLoading,
                          onPressed: _submit,
                        );
                      },
                    ),
                    const SizedBox(height: AppSize.s20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
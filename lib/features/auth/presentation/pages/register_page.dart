import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/custom_main_button.dart';
import '../../../../core/components/custom_text_card.dart';
import '../../../../core/components/custom_text_field.dart';
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
        role: 'user', 
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
          Navigator.of(context).pop(); 
        }
      },
      child: Scaffold(
        // Matching the colleague's login page background
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  children: [
                    const SizedBox(height: 18),
                    // Identical ClinicPro Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add_box_rounded, color: Color(0xFF0284C7)),
                        SizedBox(width: 8),
                        Text(
                          'ClinicPro',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Join ACMS to book your clinics easily.',
                      style: TextStyle(color: Color(0xFF64748B)),
                    ),
                    const SizedBox(height: 18),
                    
                    // The main white card wrapping all form fields identically to LoginPage
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 20, 
                            offset: Offset(0, 10), 
                            color: Color(0x14000000),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // CustomTextCard used for error states
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthUnauthenticated && state.errorMessage != null) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
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

                          const _Label('FULL NAME'),
                          const SizedBox(height: 6),
                          CustomTextField(
                            controller: _nameController,
                            hintText: 'John Doe',
                            prefixIcon: Icons.person_outline,
                          ),
                          const SizedBox(height: 12),
                          
                          const _Label('EMAIL ADDRESS'),
                          const SizedBox(height: 6),
                          CustomTextField(
                            controller: _emailController,
                            hintText: 'user@clinicpro.com',
                            prefixIcon: Icons.mail_outline,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 12),

                          const _Label('PHONE NUMBER'),
                          const SizedBox(height: 6),
                          CustomTextField(
                            controller: _phoneController,
                            hintText: '0500000000',
                            prefixIcon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 12),

                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const _Label('AGE'),
                                    const SizedBox(height: 6),
                                    CustomTextField(
                                      controller: _ageController,
                                      hintText: '25',
                                      prefixIcon: Icons.calendar_month_outlined,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const _Label('GENDER'),
                                    const SizedBox(height: 6),
                                    DropdownButtonFormField<String>(
                                      value: _selectedGender,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsets.all(16),
                                        prefixIcon: const Icon(Icons.people_outline, color: Color(0xFF0D47A1)),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(color: Color(0xFF9E9E9E), width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(color: Color(0xFF0D47A1), width: 2),
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          const _Label('PASSWORD'),
                          const SizedBox(height: 6),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: '••••••••',
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                          ),
                          const SizedBox(height: 24),

                          // CustomMainButton handling the submission
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              return CustomMainButton(
                                text: 'Sign Up',
                                isLoading: state is AuthLoading,
                                onPressed: _submit,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? ", style: TextStyle(color: Color(0xFF64748B))),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Goes back to Login Page
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Color(0xFF0284C7), fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
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

// Reusable Label widget identical to the one in the Login Page
class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF94A3B8),
        fontWeight: FontWeight.w900,
        letterSpacing: 0.8,
        fontSize: 12,
      ),
    );
  }
}
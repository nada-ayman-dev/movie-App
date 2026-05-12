import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie/features/forgot_password/domain/usecases/forgot_password_usecase.dart';
import 'package:movie/features/forgot_password/data/repositories/forgot_password_repository_impl.dart';
import 'package:movie/features/forgot_password/data/datasources/forgot_password_remote_data_source.dart';
import 'package:movie/features/forgot_password/presentation/cubit/forgot_password_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late TextEditingController emailController;
  late ForgotPasswordCubit _forgotPasswordCubit;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();

    // Initialize the cubit with clean architecture and explicit Firestore instance
    _forgotPasswordCubit = ForgotPasswordCubit(
      ForgotPasswordUseCase(
        ForgotPasswordRepositoryImpl(
          FirebaseForgotPasswordRemoteDataSource(
            firestore: FirebaseFirestore.instance,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    _forgotPasswordCubit.close();
    super.dispose();
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        backgroundColor: Colors.red[700],
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      body: BlocProvider<ForgotPasswordCubit>(
        create: (context) => _forgotPasswordCubit,
        child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordSuccess) {
              // Show dialog with the 6-digit code
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (dialogContext) => AlertDialog(
                  backgroundColor: const Color(0xFF282A28),
                  title: const Text(
                    'Password Reset Code',
                    style: TextStyle(
                      color: Color(0xFFF6BD00),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Your 6-digit code has been sent to your email:',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1a1a1a),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFF6BD00),
                            width: 2,
                          ),
                        ),
                        child: Text(
                          state.code,
                          style: const TextStyle(
                            color: Color(0xFFF6BD00),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'This code will expire in 10 minutes',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          color: Color(0xFFF6BD00),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is ForgotPasswordFailure) {
              _showErrorMessage(state.error);
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Back Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFFF6BD00),
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Forgot Password Image
                    Image.asset(
                      'assets/images/Forgot_password.png',
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 40),
                    // Title
                    const Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Color(0xFFF6BD00),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    // Description
                    const Text(
                      'Enter your email address and we\'ll send you a link to reset your password',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    // Email Input Field
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFF282A28),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color(0xFF282A28),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: emailController,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SvgPicture.asset(
                              'assets/icons/email.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Verify Email Button with BlocBuilder
                    BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                      builder: (context, state) {
                        final isLoading = state is ForgotPasswordLoading;
                        return SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    context
                                        .read<ForgotPasswordCubit>()
                                        .sendPasswordResetEmail(
                                          emailController.text.trim(),
                                        );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF6BD00),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              disabledBackgroundColor: Colors.grey[600],
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF1a1a1a),
                                      ),
                                    ),
                                  )
                                : const Text(
                                    'Verify Email',
                                    style: TextStyle(
                                      color: Color(0xFF1a1a1a),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 40),
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

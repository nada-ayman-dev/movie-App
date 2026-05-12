import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:movie/features/signup/domain/usecases/signup_usecase.dart';
import 'package:movie/features/login/data/datasources/remote_data_source.dart';
import 'package:movie/features/signup/data/repositories/signup_repository_impl.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController phoneController;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  late SignUpUseCase signUpUseCase;
  bool _isLoading = false;
  File? _selectedImage;
  int _selectedAvatarIndex = 0; // 0=avatar1, 1=avatar2, 2=avatar3, 3=custom
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    phoneController = TextEditingController();
    // Initialize UseCase with RemoteDataSource
    signUpUseCase = SignUpUseCase(
      SignUpRepositoryImpl(FirebaseRemoteDataSource()),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _selectedAvatarIndex = 3; // Custom image selected
      });
    }
  }

  Future<void> _handleSignUp() async {
    final email = emailController.text.trim();
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final phone = phoneController.text.trim();

    // Validate inputs
    if (email.isEmpty) {
      _showErrorMessage('Please enter your email');
      return;
    }
    if (username.isEmpty) {
      _showErrorMessage('Please enter a username');
      return;
    }
    if (password.isEmpty) {
      _showErrorMessage('Please enter your password');
      return;
    }
    if (confirmPassword.isEmpty) {
      _showErrorMessage('Please confirm your password');
      return;
    }
    if (password != confirmPassword) {
      _showErrorMessage('Passwords do not match');
      return;
    }
    if (phone.isEmpty) {
      _showErrorMessage('Please enter your phone number');
      return;
    }

    setState(() => _isLoading = true);

    // Call the signup use case
    final result = await signUpUseCase.call(
      email,
      username,
      password,
      phone,
      _selectedImage,
      _selectedAvatarIndex,
    );

    setState(() => _isLoading = false);

    result.fold(
      // On failure
      (failure) {
        _showErrorMessage(failure.message);
      },
      // On success
      (user) {
        _showSuccessMessage('Account created successfully! Logging in...');
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pushReplacementNamed('/home');
        });
      },
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        backgroundColor: Colors.red[700],
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        backgroundColor: Colors.green[700],
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Back Button & Register Title
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFFF6BD00),
                        size: 24,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Register',
                      style: TextStyle(
                        color: Color(0xFFF6BD00),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 24), // For spacing
                  ],
                ),
                const SizedBox(height: 30),
                // Avatar Selection Section
                const Text(
                  'Avatar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                // Avatar Options Row - Predefined Avatars
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Avatar 1
                      _buildAvatarOption(0, 'assets/images/avatar_1.png'),
                      const SizedBox(width: 20),
                      // Avatar 2
                      _buildAvatarOption(1, 'assets/images/avatar_2.png'),
                      const SizedBox(width: 20),
                      // Avatar 3
                      _buildAvatarOption(2, 'assets/images/avatar_3.png'),
                      const SizedBox(width: 20),
                      // Upload Custom Image from Gallery
                      GestureDetector(
                        onTap: _pickImage,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: _selectedAvatarIndex == 3 ? 90 : 70,
                          height: _selectedAvatarIndex == 3 ? 90 : 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _selectedAvatarIndex == 3
                                  ? const Color(0xFFF6BD00)
                                  : Colors.grey[600]!,
                              width: 2,
                            ),
                          ),
                          child: _selectedImage != null
                              ? ClipOval(
                                  child: Image.file(
                                    _selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[400],
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 40,
                                    color: Color(0xFF282A28),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Name TextField
                _buildTextField(
                  controller: usernameController,
                  hintText: 'Name',
                  iconPath: 'assets/icons/name.svg',
                ),
                const SizedBox(height: 16),
                // Email TextField
                _buildTextField(
                  controller: emailController,
                  hintText: 'Email',
                  iconPath: 'assets/icons/email.svg',
                ),
                const SizedBox(height: 16),
                // Password TextField
                _buildPasswordTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: _obscurePassword,
                  onToggle: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Confirm Password TextField
                _buildPasswordTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: _obscureConfirmPassword,
                  onToggle: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Phone Number TextField
                _buildTextField(
                  controller: phoneController,
                  hintText: 'Phone Number',
                  iconPath: 'assets/icons/phone.svg',
                ),
                const SizedBox(height: 24),
                // Create Account Button
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF6BD00),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF1a1a1a),
                              ),
                            ),
                          )
                        : const Text(
                            'Create Account',
                            style: TextStyle(
                              color: Color(0xFF1a1a1a),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                // Already Have Account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already Have Account ? ',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFFF6BD00),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarOption(int index, String imagePath) {
    final isSelected = _selectedAvatarIndex == index;
    final size = isSelected ? 90.0 : 70.0;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAvatarIndex = index;
          _selectedImage = null;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? const Color(0xFFF6BD00) : Colors.transparent,
            width: 3,
          ),
        ),
        child: ClipOval(child: Image.asset(imagePath, fit: BoxFit.cover)),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    String? iconPath,
    IconData? icon,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF282A28),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF282A28), width: 1),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: iconPath != null
                ? SvgPicture.asset(iconPath, width: 24, height: 24)
                : Icon(icon, color: Colors.grey[400], size: 24),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF282A28),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF282A28), width: 1),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              'assets/icons/pass.svg',
              width: 24,
              height: 24,
            ),
          ),
          suffixIcon: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/unseen.svg',
              width: 24,
              height: 24,
            ),
            onPressed: onToggle,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}

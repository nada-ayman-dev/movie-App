import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19.0),
          child: Column(
            children: [
              const SizedBox(height: 67),
              // Logo
              Center(
                child: Container(
                  width: 121,
                  height: 118,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6BD00),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    size: 60,
                    color: Color(0xFF1a1a1a),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              // Email TextField
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF282A28),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xFF282A28), width: 1),
                ),
                child: TextField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.email, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Password TextField
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF282A28),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xFF282A28), width: 1),
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Login Button
              SizedBox(
                width: 392,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Connect to Firebase login
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF6BD00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                        color: Color(0xFF282A28),
                        width: 1,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xFF1a1a1a),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gasguard_mobile/ui/common/input_field.dart';

import '../../../utils/app_router.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Campo Email
        CustomInputField(
          label: 'Email',
          controller: _emailController,
          hintText: 'example@demo.com',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 24),
        // Campo Password
        CustomInputField(
          label: 'Password',
          controller: _passwordController,
          hintText: 'ejemplo123',
          obscureText: _obscurePassword,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey[400],
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
        const SizedBox(height: 24),
        // Campo Confirm Password
        CustomInputField(
          label: 'Confirm password',
          controller: _confirmPasswordController,
          hintText: 'ejemplo123',
          obscureText: _obscureConfirmPassword,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey[400],
            ),
            onPressed: () {
              setState(() {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              });
            },
          ),
        ),
        const SizedBox(height: 32),
        // Botón Register
        _buildRegisterButton(),
        const Spacer(),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          _handleRegister();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4ECDC4),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          'Create account',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _handleRegister() {
    // Lógica de registro
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showSnackBar('Por favor completa todos los campos');
      return;
    }

    if (password != confirmPassword) {
      _showSnackBar('Las contraseñas no coinciden');
      return;
    }

    _showSnackBar('Creando cuenta...');

    // Aquí implementarías el registro real
    // authProvider.register(email, password);

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, AppRouter.dashboard);
    });

  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF4ECDC4),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
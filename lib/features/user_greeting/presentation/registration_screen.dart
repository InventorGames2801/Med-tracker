import 'package:flutter/material.dart';
import 'package:medical_irkutsk/core/theme/theme.dart';
import 'package:medical_irkutsk/features/user_greeting/presentation/login_screen.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              // Header
              Text(
                'Создайте аккаунт',
                style: textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Создайте аккаунт, чтобы сохранить свои данные\nи свободно пользоваться MediMo',
                  style: textTheme.bodySmall?.copyWith(fontSize: 14, height: 1.4),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              // Form Fields
              _buildInputField(context, 'Имя'),
              const SizedBox(height: 20),
              _buildInputField(context, 'Логин'),
              const SizedBox(height: 20),
              _buildInputField(context, 'Пароль', isPassword: true),
              const SizedBox(height: 10),
              // Terms Checkbox
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (val) {},
                  ),
                  Expanded(
                    child: Text(
                      'Я согласен с политикой конфиденциальности',
                      style: textTheme.bodySmall?.copyWith(fontSize: 13),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Register Button
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradientHorizontal,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text('Зарегистрироваться'),
                ),
              ),
              const SizedBox(height: 30),
              // Divider
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'или',
                      style: textTheme.bodyMedium,
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 30),
              // Social Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon('google_icon.png'),
                  const SizedBox(width: 20),
                  _buildSocialIcon('apple_icon.png'),
                  const SizedBox(width: 20),
                  _buildSocialIcon('yandex_icon.png'),
                ],
              ),
              const SizedBox(height: 40),
              // Footer Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Уже зарегистрированы? ',
                    style: textTheme.bodySmall,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Войдите',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
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
    );
  }

  Widget _buildInputField(BuildContext context, String label, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            suffixIcon: isPassword
                ? const Icon(
                    Icons.remove_red_eye_outlined,
                    color: AppColors.primary,
                  )
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(String iconName) {
    return Container(
      width: 76,
      height: 76,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Image.asset('assets/images/social_networks/$iconName'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:medical_irkutsk/core/theme/theme.dart';
import 'package:medical_irkutsk/features/user_greeting/presentation/reset_password_screen.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              // Header
              Text(
                'Введите код подтверждения',
                style: textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Мы отправили вам на почту код подтверждения\nВведите его в поле ниже, чтобы сбросить пароль',
                  style: textTheme.bodySmall?.copyWith(fontSize: 14, height: 1.4),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              // Code inputs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Код',
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(5, (index) => _buildCodeBox(context)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Timer
              RichText(
                 textAlign: TextAlign.center,
                text: TextSpan(
                  style: textTheme.bodySmall?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                  children: const [
                    TextSpan(text: 'Отправить код повторно через '),
                    TextSpan(
                      text: '60',
                      style: TextStyle(color: AppColors.primary),
                    ),
                    TextSpan(text: ' секунд'),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              // Confirm Button
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradientHorizontal,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetPasswordScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text('Подтвердить'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCodeBox(BuildContext context) {
    return Container(
      width: 56,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: TextField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}

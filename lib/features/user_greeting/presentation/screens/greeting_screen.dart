import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GreetingScreen extends StatelessWidget {
  const GreetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              // Top Text
              Text(
                'Добро пожаловать!',
                style: textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              // Middle Illustration
              Image.asset(
                'assets/images/hello_screen/pill.png',
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),
              // Brand Logo
              Image.asset(
                'assets/images/hello_screen/text.png',
                width: 250,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),
              // Subtitle
              Text(
                'Ваш трекер лекарств\nзапущен и готов к работе',
                style: textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 3),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: ElevatedButton(
                  onPressed: () => context.go('/onboarding'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Продолжить'),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_ios, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

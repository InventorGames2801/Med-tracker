import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_irkutsk/features/user_greeting/presentation/widgets/onboarding_page.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        children: [
          OnboardingPage(
            imagePath:
                'assets/images/hello_screen/pharmacist_streamline_brooklyn.png',
            title: 'Не забывайте быть здоровыми!',
            description:
                'Контролируйте приём лекарств с MediMo: добавляйте лекарства и процедуры, настраивайте уведомления и следите за своим прогрессом!',
            footerText:
                'Сделайте ваше лечение регулярным.\nЭто шаг к вашему исцелению.',
            buttonText: 'Далее',
            onButtonPressed: _nextPage,
          ),
          OnboardingPage(
            imagePath:
                'assets/images/hello_screen/doctor_nurse_streamline_brooklyn.png',
            title: 'Одобрено специалистами!',
            description:
                'Благодаря MediMo многим пациентам удалось решить проблему с регулярным приёмом лекарств. Опытные врачи советуют и рекомендуют это приложение.',
            footerText:
                'MediMo не назначает вам лечение,\nа только помогает отслеживать прогресс.',
            buttonText: 'Начать',
            onButtonPressed: () {
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}

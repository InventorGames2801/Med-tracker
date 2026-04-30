import 'package:go_router/go_router.dart';
import 'package:medical_irkutsk/features/auth/presentation/screens/login_screen.dart';
import 'package:medical_irkutsk/features/auth/presentation/screens/registration_screen.dart';
import 'package:medical_irkutsk/features/user_greeting/presentation/screens/greeting_screen.dart';
import 'package:medical_irkutsk/features/user_greeting/presentation/screens/onboarding_flow.dart';

GoRouter goRouters = GoRouter(
  routes: [
    //Самый первый экран, преветствующий пользователей, которые впервые открыли приложение
    GoRoute(
      path: '/',
      name: 'greeting_screen',
      builder: (context, state) => const GreetingScreen(),
    ),
    //Онбординг, после первого открытия
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => OnboardingFlow(),
    ),

    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/registation',
      name: 'registation',
      builder: (context, state) => RegistrationScreen(),
    ),
  ],
  initialLocation: '/',
  debugLogDiagnostics: true,
);

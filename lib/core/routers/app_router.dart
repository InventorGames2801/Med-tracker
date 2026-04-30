import 'package:go_router/go_router.dart';
import 'package:medical_irkutsk/features/user_greeting/presentation/greeting_screen.dart';

GoRouter goRouters = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'profile',
      builder: (context, state) => const GreetingScreen(),
    ),
  ],
  initialLocation: '/',
  debugLogDiagnostics: true,
);

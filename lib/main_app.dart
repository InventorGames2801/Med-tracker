import 'package:flutter/material.dart';
import 'package:medical_irkutsk/core/routers/app_router.dart';
import 'package:medical_irkutsk/core/theme/theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: goRouters,
    );
  }
}

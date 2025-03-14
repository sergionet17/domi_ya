import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:menu_app_flutter/screens/login_screen.dart';
import 'package:menu_app_flutter/services/menu_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 🔥 Ejecutar la función para agregar almuerzos
  final menuService = MenuService();
  await menuService.addMenus(); // ⚠️ Solo ejecutar una vez

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menú de Almuerzos',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(),
    );
  }
}

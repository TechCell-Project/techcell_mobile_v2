import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_project/Providers/product_provider.dart';
import 'package:single_project/Providers/user_provider.dart';
import 'package:single_project/page/screens/main_screen.dart';
import 'package:single_project/util/constants.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dotenv_initializer.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(Duration(seconds: 2));
  await initializeDotenv();
  FlutterNativeSplash.remove();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColors),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

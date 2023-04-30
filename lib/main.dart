import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokee/provider/auth_provider.dart';
import 'package:pokee/ui/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'ui/screens/auth/signup/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      )
    );
  }
}

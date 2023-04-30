
import 'package:flutter/material.dart';
import 'package:pokee/provider/auth_provider.dart';
import 'package:pokee/ui/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: Expanded(
        child: Center(
          child: Column(
            children: [
              Text(authProvider.userModel.firstname),
              Text(authProvider.userModel.lastname),
              Text(authProvider.userModel.username),
              Text(authProvider.userModel.phoneNumber),
              Text(authProvider.userModel.uid),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: () async {
                authProvider.userSignOut().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashScreen())));
              }, child: const Text("Sign Out")
              )
            ])))
    );
  }
}
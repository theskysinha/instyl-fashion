import 'package:flutter/material.dart';
import 'package:pokee/ui/screens/home_screen.dart';
import 'package:provider/provider.dart';
import '../../../provider/auth_provider.dart';
import '../auth/phone_number.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<AuthProvider>(context, listen: false);

    return Container(
      decoration: const BoxDecoration(
         gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color.fromARGB(255, 255, 169, 119),Color(0xFFFF8B37)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Center(child: Text('pokee', style: TextStyle(color: Colors.white, fontSize: 40))),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text("CREATE ACCOUNT", style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            onPressed: () async {
              if(authprovider.isSignedIn == true){
                await authprovider.getUserDataLocally().whenComplete(() => 
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => const HomeScreen())));
              }else{
                Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => const PhoneNumberInput()
                ));
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text("SIGN IN", style: TextStyle(color: Colors.grey))),
          SizedBox(height: 20),
            Text("By continuing, you agree to Pokee's Terms and conditions and\nconfirm you have read Pokee's Privacy Policy", style: TextStyle(color: Colors.white, fontSize: 10,), textAlign: TextAlign.center,)
        ],)
      )
    );
  }
}
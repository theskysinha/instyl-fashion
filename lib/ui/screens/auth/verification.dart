import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:pokee/provider/auth_provider.dart';
import 'package:pokee/ui/screens/auth/signup/signup.dart';
import 'package:pokee/ui/screens/home_screen.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class VerifyOTP extends StatefulWidget {
  final String verificationId;
  const VerifyOTP({super.key, required this.verificationId});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  String? Otp;

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading ? Center(child: CircularProgressIndicator(
          color: primaryColor,
        )) : Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
          child: Column(
              children: [
                const Text("Enter your verification code",style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),),
                const SizedBox(height: 50),
                Pinput(
                  length: 6,
                  pinAnimationType: PinAnimationType.slide,
                  defaultPinTheme: const PinTheme(
                    width: 50,
                    height: 56,
                    textStyle: TextStyle(fontSize: 20, color: Colors.grey),
                    decoration: BoxDecoration(),
                  ),
                  showCursor: true,
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 50,
                        height: 3,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],),
                  preFilledWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 50,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                  submittedPinTheme: const PinTheme(
                    width: 50,
                    height: 56,
                    textStyle: TextStyle(fontSize: 20, color: Colors.grey),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: primaryColor))
                    ),
                  ),
                  onCompleted: (value) {
                    otpVerification(context, value);
                  },
    ),
    const SizedBox(height: 30),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
            const Text("Didn't get the code?", style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),),
            TextButton(
              onPressed: () {
              }
              , child: const Text("Resend", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),))
    ],)

          ])
        )
      ))
    );
  }

  void otpVerification(BuildContext context, String otp){
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.otpVerification(
      context: context,
      verificationId: widget.verificationId,
      smsCode: otp,
      onSuccess: () {
        authProvider.checkExistingUser().then((value) async {
          if(value == true){
            authProvider.getDataFromFirestore().then((value) => 
            authProvider.saverUserDataLocally().then((value) => 
            authProvider.setSignIn().then((value) => 
            Navigator.pushAndRemoveUntil(
              context, 
              MaterialPageRoute(
                builder: (context)=> const HomeScreen()), (route) => false),
                ),
              ),
            );
          }else{
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context)=> const SignUPs()), (route) => false);
          }
        });
      },
    );
  }
}


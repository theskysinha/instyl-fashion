import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokee/constants.dart';
import 'package:pokee/ui/screens/auth/verification.dart';
import 'package:pokee/ui/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';

class PhoneNumberInput extends StatefulWidget {
  const PhoneNumberInput({super.key});

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
          child: Column(
              children: [
                const Text("Enter your phone number",style: TextStyle(fontWeight: FontWeight.w400),),
                const SizedBox(height: 30),
                Container(
                  height: 80,
                  width: 300,
                  child: TextFormField(
                    controller: phoneController,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9,\b]')),],
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      enabled: true,
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      prefix: const Text("+91 - ", style: TextStyle(fontWeight: FontWeight.bold),),
                      suffixIcon: phoneController.text.length > 9 ? Container(
                        height: 20,
                        width: 20,
                        margin: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),
                        child: const Icon(Icons.check, color: Colors.white, size: 15,)
                      ) : null
                    ),
                  ),
                ),
                const Text("We will send you a verification code",style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),),
                const SizedBox(height: 30),
                RoundedButton(
                  onPressed: () => sendPhoneNumber(),
                )
          ]  
          )
        )
        )
      ),
    );
  }

  void sendPhoneNumber(){
    final authprovider = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    authprovider.signInWithPhone(context, phoneNumber);
  } 
}
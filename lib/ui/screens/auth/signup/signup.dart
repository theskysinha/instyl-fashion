import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokee/constants.dart';
import 'package:pokee/models/user_model.dart';
import 'package:pokee/ui/screens/home_screen.dart';
import 'package:pokee/ui/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

import '../../../../provider/auth_provider.dart';


class SignUPs extends StatefulWidget {
  const SignUPs({super.key});

  @override
  State<SignUPs> createState() => _SignUPsState();
}

class _SignUPsState extends State<SignUPs> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  int activeIndex = 0;
  int totalIndex = 3;

  @override
  void dispose(){
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyBuilder()
    );
  }

  Widget bodyBuilder(){
    switch (activeIndex){
      case 0:
        return FirstNameScreen();
      case 1:
        return LastNameScreen();
      case 2:
        return UsernameScreen();
    }
    return Container();
  }
  
  // ignore: non_constant_identifier_names
  Widget FirstNameScreen() {
    final isLoading = Provider.of<AuthProvider>(context, listen: true).isLoading;
    return SafeArea(
        child: isLoading ? Center(child: CircularProgressIndicator(
          color: primaryColor,
        )) : Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
          child: Column(
              children: [
                const Text("What's your first name?",style: TextStyle(fontWeight: FontWeight.w400),),
                const SizedBox(height: 30),
                Container(
                  height: 80,
                  width: 200,
                  child: TextFormField(
                    controller: firstNameController,
                    style: const TextStyle(fontSize: 20),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z,\b]'))],
                    decoration: const InputDecoration(
                      enabled: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    textAlign: TextAlign.center,
                    cursorColor: primaryColor,
                  ),
                ),
                const SizedBox(height: 30),
                RoundedButton(onPressed: () {
                  setState(() {
                    activeIndex = 1;
                  });
                })
          ])
        )
      )
    );
  }
  
  // ignore: non_constant_identifier_names
  Widget LastNameScreen() {
    final isLoading = Provider.of<AuthProvider>(context, listen: true).isLoading;
    return SafeArea(
        child: isLoading ? Center(
          child: CircularProgressIndicator(
          color: primaryColor,
        )) : Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
          child: Column(
              children: [
                const Text("What's your last name?",style: TextStyle(fontWeight: FontWeight.w400),),
                const SizedBox(height: 30),
                Container(
                  height: 80,
                  width: 200,
                  child: TextFormField(
                    controller: lastNameController,
                    style: const TextStyle(fontSize: 20),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z,\b]'))],
                    decoration: const InputDecoration(
                      enabled: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    textAlign: TextAlign.center,
                    cursorColor: primaryColor,
                  ),
                ),
                const SizedBox(height: 30),
                RoundedButton(onPressed: () {
                  setState(() {
                    activeIndex = 2;
                  });
                })
          ])
        )
      )
    );
  }
  
  // ignore: non_constant_identifier_names
  Widget UsernameScreen() {
    final isLoading = Provider.of<AuthProvider>(context, listen: true).isLoading;
    return SafeArea(
        child: isLoading ? Center(
          child: CircularProgressIndicator(
          color: primaryColor,
        )) : Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
          child: Column(
              children: [
                const Text("User name",style: TextStyle(fontWeight: FontWeight.w400)),
                const SizedBox(height: 30),
                Container(
                  height: 80,
                  width: 200,
                  child: TextFormField(
                    controller: userNameController,
                    style: const TextStyle(fontSize: 20),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z,\b]'))],
                    decoration: const InputDecoration(
                      enabled: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    textAlign: TextAlign.center,
                    cursorColor: primaryColor,
                  ),
                ),
                const SizedBox(height: 30),
                RoundedButton(onPressed: () {
                  storeUserDetails();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                })
          ])
        )
      )
    );
  }

  void storeUserDetails(){
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      firstname: firstNameController.text.trim(),
      lastname: lastNameController.text.trim(),
      username: userNameController.text.trim(),
      phoneNumber: "",
      uid: "");
  }
}
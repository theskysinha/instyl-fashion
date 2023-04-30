import 'package:flutter/material.dart';
import 'package:pokee/constants.dart';

class RoundedButton extends StatefulWidget {
  const RoundedButton({Key? key, required this.onPressed}) : super(key: key);

  final Function onPressed;

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  bool _clicked = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _clicked = !_clicked;
          });
          widget.onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _clicked ? primaryColor : const Color(0xFFB7AEA9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text("Next", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

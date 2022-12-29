import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupFormGlobal extends StatefulWidget {
  const SignupFormGlobal({super.key, required this.controller, required this.text, required this.textInputType, required this.obscure});
  final TextEditingController controller;
  final String text;
  final TextInputType textInputType;
  final bool obscure;

  @override
  State<SignupFormGlobal> createState() => _SignupFormGlobalState();
}

class _SignupFormGlobalState extends State<SignupFormGlobal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(top: 2, left: 15),
      decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      boxShadow: [BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 7,
      ),],
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.textInputType,
        obscureText: widget.obscure,
        decoration: InputDecoration(
          hintText: widget.text,
          border: InputBorder.none,
          contentPadding:const EdgeInsets.all(0),
          hintStyle: GoogleFonts.poppins(
              textStyle: TextStyle(
                height: 1
              )
            )
        ),
      ),
    );
  }
}
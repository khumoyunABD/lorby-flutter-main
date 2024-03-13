import 'package:flutter/material.dart';

class MyTextfieldPassword extends StatelessWidget {
  const MyTextfieldPassword({
    super.key,
    required this.controller,
    required this.passVisible,
    required this.onTap,
  });
  final controller;
  final bool passVisible;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 29, 65, 94)),
          ),
          fillColor: Colors.grey.shade100,
          filled: true,
          hintText: 'Введи пароль',
          hintStyle: const TextStyle(color: Colors.black45),
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              passVisible
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.black,
            ),
            onPressed: onTap,
          ),
        ),
        obscureText: !passVisible,
      ),
    );
  }
}

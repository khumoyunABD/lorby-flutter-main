import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.onTap,
    required this.buttonText,
  });
  final String buttonText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: Colors.black,
        //foregroundColor: Colors.green,
        //disabledBackgroundColor: Colors.black54,
        padding: const EdgeInsets.only(
          right: 154,
          left: 154,
          top: 20,
          bottom: 20,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),

      //using Container
      // child: Container(
      //   padding: const EdgeInsets.all(18),
      //   margin: const EdgeInsets.symmetric(
      //     horizontal: 15,
      //   ),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(18),
      //     color: Colors.black,
      //   ),
      //   child: Center(
      //     child: Text(
      //       buttonText,
      //       style: const TextStyle(
      //         color: Colors.white,
      //         fontWeight: FontWeight.bold,
      //         fontSize: 18,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

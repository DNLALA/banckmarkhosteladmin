import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? onPressed;
  final Color? textColor;

  const SubmitButton(
      {Key? key, this.buttonText, this.onPressed, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 160, 98, 160),
          border: Border.all(
            width: 1,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(
            5,
          ),
        ),
        child: Center(
          child: Text(
            buttonText!,
            style: TextStyle(color: textColor, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

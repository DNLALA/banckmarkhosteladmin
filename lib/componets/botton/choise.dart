import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? onPressed;
  final Color? textColor;
  final bool? isActive;

  const ChoiceButton({
    Key? key,
    this.buttonText,
    this.onPressed,
    this.textColor,
    this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: isActive ?? false
              ? const Color.fromARGB(255, 160, 98, 160)
              : Colors.transparent,
          border: Border.all(
            width: 1,
            color: isActive ?? false
                ? const Color.fromARGB(255, 160, 98, 160)
                : Colors.white,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            buttonText!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight:
                  isActive ?? false ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

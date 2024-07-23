import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final Color borderColor;
  final Widget child;
  final VoidCallback? onTap;

  const CustomContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.borderRadius,
    required this.borderColor,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor,
            width: 2.0,
          ),
        ),
        child: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';

InputDecoration inputDecoration(BuildContext context,
    {String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? labelText,
    bool isDense = true,
    // Color fillColor = const Color(0xffffa446),
    Color? borderColor,
    TextStyle? hintStyle,
    double radius = 4.0,
    bool addVPadding = false}) {
  const activeColor = Colors.white;
  return InputDecoration(
    alignLabelWithHint: true,
    hintStyle: hintStyle ??
        const TextStyle(
          color: Colors.white,
        ),
    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
    // filled: true,
    // fillColor: fillColor,

    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    //  isDense: isDense,
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(
          style: BorderStyle.solid,
          color: activeColor,
        )),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
        style: BorderStyle.solid,
        color: activeColor,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: activeColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
        color: activeColor,
      ),
    ),
    // errorBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(radius),
    //     borderSide: const BorderSide(
    //       color: Colors.red,
    //     )),
    // focusedErrorBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(radius),
    //     borderSide: const BorderSide(
    //       color: Colors.red,
    //     )),
    hintText: hintText,
    labelText: labelText,
  );
}

InputDecoration passWordInputDecoration(BuildContext context,
    {String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? labelText,
    bool isDense = true,
    Color? borderColor,
    TextStyle? hintStyle,
    double radius = 4.0,
    bool addVPadding = false}) {
  const activeColor = Color(0xFF127CF7);
  return InputDecoration(
    alignLabelWithHint: true,
    hintStyle: hintStyle ??
        const TextStyle(
          color: Colors.black,
        ),
    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
    filled: true,
    // fillColor: fillColor,

    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: activeColor,
      ),
    ),
    hintText: hintText,
    labelText: labelText,
  );
}


import 'package:flutter/material.dart';

import 'color.dart';

extension CustomInputDecoration on InputDecoration {
  static InputDecoration myCustomInputDecoration({
    String? hintText,
    IconData? prefixIcon,
    Widget? suffixIcon,
    InputBorder border = InputBorder.none,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.symmetric(vertical: 8.0),
  }) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 18),
      fillColor: Colors.white,
      hintText: hintText,
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: colors.black12, width: 2)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: colors.black12, width: 2)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: colors.black12, width: 2)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: colors.black12, width: 2),

      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
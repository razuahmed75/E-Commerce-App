import 'package:flutter/material.dart';
import 'package:online_shop_app/constants/my_colors.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool autoFocus;
  final Widget? suffixIcon;
  final void Function()? onEditingComplete;

  const InputTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.autoFocus,
    required this.onEditingComplete,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autofocus: true,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: black,
          width: 2,
        )),
        suffixIcon: suffixIcon,
      ),
    );
  }
}

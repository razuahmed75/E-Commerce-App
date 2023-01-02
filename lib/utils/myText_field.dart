import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/my_colors.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Widget? sufixIcon;
  final IconData? prefixIcon;
  final String label;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText, readOnly;
  final TextInputType keyboardType;

  const MyTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.label,
    this.obscureText = false,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.sufixIcon,
    this.prefixIcon,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: kColor.withOpacity(0.3),
        ),
      ),
      child: TextFormField(
        controller: controller,
        cursorColor: kColor,
        obscureText: obscureText,
        focusNode: focusNode,
        readOnly: readOnly,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style: GoogleFonts.actor(
          color: focusNode.hasFocus || controller.text.isNotEmpty
              ? kColor
              : Colors.grey[900],
          letterSpacing: 1.7.w,
        ),
        validator: validator ??
            (String? value) {
              if (value!.isEmpty) {
                return 'Field must not be empty!';
              } else if (!value.contains('@gmail.com')) {
                return 'Email should be @gmail.com';
              }
              return null;
            },
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: controller.text.isNotEmpty ? kColor : Colors.grey,
          )),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: kColor,
          )),
          errorStyle: GoogleFonts.actor(
            fontSize: 11.sp,
            letterSpacing: 0.7.w,
            fontWeight: FontWeight.w600,
            color: red,
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 30.w),
          prefixIcon: Icon(
            prefixIcon,
            color: focusNode.hasFocus || controller.text.isNotEmpty
                ? kColor
                : Colors.grey[500],
          ),
          suffixIcon: sufixIcon,
          label: Text(
            label,
            style: GoogleFonts.actor(
              fontSize: 16.sp,
            ),
          ),
          labelStyle: TextStyle(
            color: focusNode.hasFocus || controller.text.isNotEmpty
                ? kColor
                : Colors.grey[800],
          ),
        ),
      ),
    );
  }
}

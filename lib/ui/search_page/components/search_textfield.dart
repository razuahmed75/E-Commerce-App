import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/my_colors.dart';

class SearchField extends StatelessWidget {
  final bool autofocus;
  final String hintText;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;

  const SearchField({
    super.key,
    required this.hintText,
    required this.autofocus,
    required this.controller,
    required this.onChanged,
    required this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autofocus,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: controller.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  onPressed: () => controller.clear(),
                  icon: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                          width: 25.w,
                          height: 25.w,
                          color: Colors.blue.shade100,
                          child: Icon(
                            Icons.close,
                            size: 20.w,
                            color: Colors.grey.shade500,
                          )))),
          contentPadding: EdgeInsets.symmetric(horizontal: 10).r,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kColor),
            borderRadius: BorderRadius.circular(40).w,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kColor),
            borderRadius: BorderRadius.circular(40).w,
          )),
    );
  }
}

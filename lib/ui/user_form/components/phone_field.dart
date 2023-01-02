import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../constants/my_colors.dart';
import '../../../utils/myText_field.dart';

class PhoneField extends StatelessWidget {
  final controller;
  final node;
  const PhoneField({
    super.key,
    required this.controller,
    required this.node,
  });

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      label: 'Phone*',
      controller: controller,
      focusNode: node,
      inputFormatters: [
        LengthLimitingTextInputFormatter(11),
      ],
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Field must not be empty!';
        }
        return null;
      },
      sufixIcon: controller.text.isEmpty
          ? Container(width: 0)
          : IconButton(
              onPressed: () => controller.clear(),
              icon: Icon(
                Icons.close,
                color: controller.text.isNotEmpty ? kColor : Colors.grey[700],
              )),
    );
  }
}

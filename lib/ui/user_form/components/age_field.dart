import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/myText_field.dart';

class AgeField extends StatelessWidget {
  const AgeField({
    super.key,
    required TextEditingController ageController,
    required FocusNode ageNode,
  })  : _ageController = ageController,
        _ageNode = ageNode;

  final TextEditingController _ageController;
  final FocusNode _ageNode;

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      controller: _ageController,
      focusNode: _ageNode,
      label: 'Age*',
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Field must not be empty!';
        } else if (value.length < 2) {
          return 'Your age should be in 2 digits';
        }
        return null;
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(2),
      ],
      keyboardType: TextInputType.phone,
    );
  }
}

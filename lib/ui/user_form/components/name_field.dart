import 'package:flutter/material.dart';
import '../../../constants/my_colors.dart';
import '../../../utils/myText_field.dart';

class NameField extends StatelessWidget {
  const NameField({
    super.key,
    required TextEditingController nameController,
    required FocusNode nameNode,
  })  : _nameController = nameController,
        _nameNode = nameNode;

  final TextEditingController _nameController;
  final FocusNode _nameNode;

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      label: 'Name*',
      controller: _nameController,
      focusNode: _nameNode,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Field must not be empty!';
        }
        return null;
      },
      sufixIcon: _nameController.text.isEmpty
          ? Container(width: 0)
          : IconButton(
              onPressed: () => _nameController.clear(),
              icon: Icon(
                Icons.close,
                color:
                    _nameController.text.isNotEmpty ? kColor : Colors.grey[700],
              )),
    );
  }
}

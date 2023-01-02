import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/my_colors.dart';
import 'search_textfield.dart';

// ignore: must_be_immutable
class QuerySearchBar extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  String inputText;

  QuerySearchBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.inputText,
  });

  @override
  State<QuerySearchBar> createState() => _QuerySearchBarState();
}

class _QuerySearchBarState extends State<QuerySearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12).r,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
          SizedBox(
              width: 0.7.sw,
              height: 30.h,
              child: SearchField(
                autofocus: true,
                controller: widget.controller,
                hintText: 'Search',
                onEditingComplete: () => widget.focusNode.requestFocus(),
                onChanged: (value) => setState(() => widget.inputText = value),
              )),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                right: 12,
              ).r,
              child: Text(
                'SEARCH',
                style: GoogleFonts.actor(color: kColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}

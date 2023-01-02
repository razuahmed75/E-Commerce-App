import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop_app/constants/my_colors.dart';

appDialog({
  required BuildContext context,
  required String content,
  String rightButtonTxt = 'YES',
  String leftButtonTxt = 'CANCEL',
  required void Function()? rightPressed,
  required void Function()? leftPressed,
}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Color.fromARGB(255, 62, 58, 58),
            content: Text(
              content,
              style: GoogleFonts.poppins(color: white),
            ),
            actions: [
              TextButton(
                  onPressed: leftPressed,
                  child: Text(
                    leftButtonTxt,
                    style: GoogleFonts.poppins(color: white),
                  )),
              TextButton(
                  onPressed: rightPressed,
                  child: Text(
                    rightButtonTxt,
                    style: GoogleFonts.poppins(
                        letterSpacing: 1.7,
                        color: Color(0xFFFA555F),
                        fontWeight: FontWeight.w600),
                  )),
            ],
          ));
}

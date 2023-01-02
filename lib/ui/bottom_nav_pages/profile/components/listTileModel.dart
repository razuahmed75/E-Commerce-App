import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class myListTile extends StatelessWidget {
  final String leading, title, trailing;
  final void Function()? onTap;
  final Color? iconColor;

  const myListTile({
    Key? key,
    this.onTap,
    required this.leading,
    required this.title,
    required this.trailing,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: SvgPicture.asset(
            leading,
            height: 18.h,
          ),
          title: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.actor(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.7,
              fontSize: 14.sp,
            ),
          ),
          trailing: Container(
            width: 140.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(trailing,
                      overflow: TextOverflow.clip,
                      style: GoogleFonts.openSans(
                        fontSize: 12.sp,
                      )),
                ),
                IconButton(
                    onPressed: onTap, icon: Icon(Icons.edit, color: iconColor))
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.grey.shade400,
        ),
      ],
    );
  }
}

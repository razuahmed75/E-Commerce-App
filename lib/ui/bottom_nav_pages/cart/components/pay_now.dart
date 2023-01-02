import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PayNow extends StatelessWidget {
  final void Function()? onPressed;
  final String title;

  const PayNow({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0).w,
      child: Container(
        padding: EdgeInsets.all(24).w,
        width: 400.w,
        height: 90.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12).w, color: Colors.green),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total amount",
                  style: GoogleFonts.robotoMono(color: Colors.green[100]),
                ),
                Text(
                  'Amount',
                  style: GoogleFonts.robotoMono(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(130, 50),
                side: BorderSide(
                  width: 0.3.w,
                  color: Colors.white,
                ),
                elevation: 0,
                shadowColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30).w),
              ),
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.robotoMono(color: Colors.green[100]),
                  ),
                  SizedBox(width: 5.w),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

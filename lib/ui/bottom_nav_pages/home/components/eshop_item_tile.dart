import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../constants/my_colors.dart';

class EshopItemTile extends StatelessWidget {
  final String itemPath;
  final String itemName;
  final dynamic itemPrice;

  const EshopItemTile({
    super.key,
    required this.itemPath,
    required this.itemName,
    required this.itemPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0).w,
      child: Container(
        padding: EdgeInsets.all(12).w,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4.w,
              offset: Offset(4, 8), // Shadow position
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              itemPath,
              height: 68.h,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.error, size: 40, color: black),
            ),
            Text(
              itemName,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style:
                  GoogleFonts.robotoMono(fontSize: 12.sp, color: Colors.black),
            ),
            Text(
              '\$' + itemPrice.toString(),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style:
                  GoogleFonts.robotoMono(fontSize: 12.sp, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

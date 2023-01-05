import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../constants/my_colors.dart';

class ProductItemTiles extends StatelessWidget {
  final photo, name, price;

  const ProductItemTiles({
    super.key,
    required this.photo,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8).r,
      child: Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4.w,
              offset: Offset(4, 8), // Shadow position
            ),
          ],
        ),
        width: double.maxFinite,
        height: 80.h,
        child: ListTile(
          leading: Image.network(
            photo,
            fit: BoxFit.cover,
          ),
          title: Text(name,
              style: GoogleFonts.robotoMono(
                fontSize: 14.sp,
              )),
          trailing: RichText(
              text: TextSpan(
                  text: 'Price ',
                  style: GoogleFonts.robotoMono(
                    fontSize: 13.sp,
                    color: black,
                  ),
                  children: [
                TextSpan(
                    text: '\$' + price.toString(),
                    style: GoogleFonts.robotoMono(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ))
              ])),
        ),
      ),
    );
  }
}

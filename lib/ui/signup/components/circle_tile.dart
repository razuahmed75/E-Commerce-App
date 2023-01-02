import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleTile extends StatelessWidget {
  final void Function()? onTap;
  final String imagePath;

  const CircleTile({
    super.key,
    required this.onTap,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue.withOpacity(0.2),
        highlightColor: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(50).w,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10).w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 0.5.w,
                color: Color.fromARGB(255, 144, 141, 141),
              )),
          child: Image.asset(
            imagePath,
            width: 30.w,
            height: 30.w,
          ),
        ),
      ),
    );
  }
}

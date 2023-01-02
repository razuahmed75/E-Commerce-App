import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(12.0).w,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 1.5,
      ),
      itemBuilder: ((context, index) => Padding(
            padding: const EdgeInsets.all(12.0).w,
            child: Container(
              padding: EdgeInsets.all(12).w,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          )),
    );
  }
}

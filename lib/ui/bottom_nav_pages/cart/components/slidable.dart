import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableWidget extends StatelessWidget {
  final void Function(BuildContext)? onPressed, toLeftSlidePressed;
  final Widget child;
  final String? toLeftSideLabel;
  final IconData? toLeftSideIconData;

  const SlidableWidget({
    super.key,
    required this.onPressed,
    required this.child,
    this.toLeftSlidePressed,
    this.toLeftSideLabel,
    this.toLeftSideIconData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20).r,
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: (context) {},
            icon: Icons.share,
            backgroundColor: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(12.r),
          ),
          SlidableAction(
            autoClose: true,
            onPressed: onPressed,
            icon: Icons.delete,
            backgroundColor: Color(0xFFFF6464),
            borderRadius: BorderRadius.circular(12.r),
          ),
        ]),
        startActionPane:
            ActionPane(extentRatio: 0.3, motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: toLeftSlidePressed,
            icon: toLeftSideIconData,
            backgroundColor: Color(0xFFFF6464),
            borderRadius: BorderRadius.circular(12.r),
          ),
        ]),
        child: child,
      ),
    );
  }
}

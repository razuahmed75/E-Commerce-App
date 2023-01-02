import 'package:flutter/material.dart';
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
    return Slidable(
      endActionPane: ActionPane(motion: DrawerMotion(), children: [
        SlidableAction(
          autoClose: true,
          onPressed: onPressed,
          label: 'Delete',
          icon: Icons.delete,
          backgroundColor: Colors.red,
        ),
        SlidableAction(
          onPressed: (context) {},
          label: 'Share',
          icon: Icons.share,
          backgroundColor: Colors.green,
        ),
      ]),
      startActionPane:
          ActionPane(extentRatio: 0.4, motion: StretchMotion(), children: [
        SlidableAction(
          onPressed: toLeftSlidePressed,
          label: toLeftSideLabel,
          icon: toLeftSideIconData,
          backgroundColor: Color(0xFFFF6464),
        ),
      ]),
      child: child,
    );
  }
}

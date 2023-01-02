import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:online_shop_app/logic/profile_manager.dart';
import 'package:online_shop_app/constants/svg/svg.dart';
import 'package:online_shop_app/ui/bottom_nav_pages/profile/profile_image_preview.dart';
import 'package:provider/provider.dart';
import '../../../../constants/my_colors.dart';
import 'profile_loader.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final getImageFromUserFrom = FirebaseFirestore.instance
      .collection('userForm')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPaddin).r,
      child: Consumer<ProfileManager>(builder: (context, provider, child) {
        return StreamBuilder(
            stream: getImageFromUserFrom,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return ProfileLoader();
              }
              if (snapshot.connectionState == ConnectionState.active) {
                var data = snapshot.data;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              Get.to(() => ProfileImagePreview(), arguments: [
                            {'image': data!['Profile']}
                          ]),
                          child: profilePHoto(provider, data),
                        ),

                        /// on clicked upload photo
                        choosePHoto(provider, context)
                      ],
                    ),
                  ],
                );
              }
              return Text('Something went wrong');
            });
      }),
    );
  }

  Material profilePHoto(
      ProfileManager provider, DocumentSnapshot<Map<String, dynamic>>? data) {
    return Material(
      elevation: 22,
      shadowColor: Colors.grey.shade800,
      color: Colors.transparent,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.w),
          borderSide: BorderSide(
            color: Colors.transparent,
          )),
      child: Container(
        width: 145.w,
        height: 145.w,
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade700,
          shape: BoxShape.circle,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(90.w),
          child: provider.image == null
              ? Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(data!['Profile'].toString()),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                      child: Icon(
                    Icons.error,
                    color: white,
                    size: 42,
                  )),
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.file(
                        fit: BoxFit.cover,
                        File(
                          provider.image,
                        )),
                    Center(child: CircularProgressIndicator()),
                  ],
                ),
        ),
      ),
    );
  }

  Positioned choosePHoto(ProfileManager provider, BuildContext context) {
    return Positioned(
        bottom: 10,
        right: 0,
        child: GestureDetector(
          onTap: () {
            provider.showBottomSheet(context: context);
          },
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade800, shape: BoxShape.circle),
              padding: EdgeInsets.all(kDefaultPaddin / 2.w),
              child: SvgPicture.asset(
                kCamera,
                color: white,
                height: 17.h,
              )),
        ));
  }
}

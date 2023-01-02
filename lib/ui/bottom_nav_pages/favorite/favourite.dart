import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop_app/constants/svg/svg.dart';
import 'package:online_shop_app/ui/bottom_nav_pages/cart/components/productTiles.dart';
import 'package:online_shop_app/ui/bottom_nav_pages/cart/components/slidable.dart';
import '../../../constants/my_colors.dart';
import '../../../firebase/addItemToFav.dart';
import '../../../utils/shimmer_loader.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// buildAppBar
      appBar: buildAppBar(),
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          /// fav items
          StreamBuilder(
              stream: userFavItems,
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return CardSkeleton();
                }
                if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.data != null) {
                  var getData = snapshot.data!.docs;

                  return Expanded(
                    child: ListView.builder(
                        itemCount: getData.length,
                        itemBuilder: ((context, index) {
                          var data = getData[index];

                          /// fav item tiles
                          return SlidableWidget(
                            toLeftSideLabel: 'addToCart',
                            toLeftSideIconData: Icons.add_shopping_cart,
                            toLeftSlidePressed: (context) {
                              Fav.addCartFromFav(
                                Photo: data['Photo'],
                                Name: data['Name'],
                                Price: data['Price'],
                              );
                            },
                            onPressed: (context) {
                              Fav.deleteFromFav(data.id);
                            },
                            child: ProductItemTiles(
                              photo: data['Photo'][0],
                              name: data['Name'],
                              price: data['Price'],
                            ),
                          );
                        })),
                  );
                }
                return Text('Something went wrong');
              })),
        ],
      ),
    );
  }

  /// variables

  final userFavItems = FirebaseFirestore.instance
      .collection('users-fav-items')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('itemFavs')
      .snapshots();

  /// build methods

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: white,
      elevation: 0,
      leading: IconButton(
          onPressed: () => Get.back(), icon: SvgPicture.asset(kArrow_back)),
      title: Text(
        'Favorite',
        style: GoogleFonts.actor(
          color: black,
          fontSize: 20.sp,
        ),
      ),
    );
  }
}

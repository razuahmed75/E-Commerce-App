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
import '../../../firebase/addItemToCart.dart';
import '../../../utils/cart_length_checker.dart';
import '../../../utils/shimmer_loader.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final userCartItems = FirebaseFirestore.instance
      .collection('users-cart-items')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('itemLists')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// buildAppBar
      appBar: buildAppBar(),
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          /// cart items
          StreamBuilder(
              stream: userCartItems,
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return CardSkeleton();
                }
                if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.data != null) {
                  // List<QueryDocumentSnapshot<Map<String, dynamic>>> getData =
                  //     snapshot.data!.docs;
                  var getData = snapshot.data!.docs;

                  return Expanded(
                      child: ListView.builder(
                          itemCount: Cartlength.checkLength = getData.length,
                          itemBuilder: ((context, index) {
                            var data = getData[index];

                            /// cart item tiles
                            return SlidableWidget(
                              toLeftSideLabel: 'Favorite',
                              toLeftSideIconData: Icons.favorite,
                              toLeftSlidePressed: (context) {
                                Cart.addFavFromCart(
                                  Photo: data['Photo'],
                                  Name: data['Name'],
                                  Price: data['Price'],
                                );
                              },
                              onPressed: (context) {
                                Cart.deleteFromCart(data.id);
                              },
                              child: ProductItemTiles(
                                photo: data['Photo'][0],
                                name: data['Name'],
                                price: data['Price'],
                              ),
                            );
                          })));
                }
                return Text('Something went wrong');
              })),

          /// pay option
          // PayNow(
          //   onPressed: () {},
          //   title: 'Pay Now',
          // )
        ],
      ),
    );
  }

  /// build methods

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: white,
      elevation: 0,
      leading: IconButton(
          onPressed: () => Get.back(), icon: SvgPicture.asset(kArrow_back)),
      title: Text(
        'My Cart',
        style: GoogleFonts.actor(
          color: black,
          fontSize: 20.sp,
        ),
      ),
    );
  }
}

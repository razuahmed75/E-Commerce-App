import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop_app/constants/my_colors.dart';
import 'package:online_shop_app/ui/details_page/components/name_and_price.dart';
import '../../firebase/addItemToCart.dart';
import '../../firebase/addItemToFav.dart';
import '../../utils/toast.dart';
import 'components/addtocart_btn.dart';
import 'components/appBar.dart';
import 'components/buy_now_btn.dart';
import 'components/cart_counter.dart';
import 'components/fav_button.dart';
import 'components/product_description.dart';
import 'components/product_slider.dart';

class DetailsScreen extends StatefulWidget {
  final Product;
  final tag;

  const DetailsScreen({super.key, this.Product, this.tag});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: buildAppbar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///product image slider
                ProductSlider(
                  carouselController: _carouselController,
                  urlImages: widget.Product['product-img'],
                  imageTag: widget.tag,
                ),
                SizedBox(height: 20.h),
                AspectRatio(
                  aspectRatio: 2 / 2.3,
                  child: Container(
                      alignment: Alignment.center,
                      width: ScreenUtil().screenWidth,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(45).w,
                        ),
                      ),
                      child: Column(
                        children: [
                          /// product name and price
                          NameAndPrice(
                            productName: widget.Product['product-name'],
                            productPrice: widget.Product['product-price'],
                          ),

                          /// product description
                          productDescription(
                            widget.Product['product-description'],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                              top: kDefaultPaddin,
                              left: kDefaultPaddin,
                              right: kDefaultPaddin,
                            ).r,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /// quantity and favorite buttons

                                CartCounter(),
                                StreamBuilder(
                                    stream: userFavItems
                                        .where('Name',
                                            isEqualTo:
                                                widget.Product['product-name'])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.data == null)
                                        return Text('');
                                      if (snapshot.connectionState ==
                                          ConnectionState.active) {
                                        var data = snapshot.data!.docs;
                                        return FavButton(
                                          onPressed: () {
                                            data.length == 0
                                                ? Fav.addToFav(
                                                    Product: widget.Product)
                                                : toast('Already added');
                                          },
                                          icon: Icon(
                                            data.length == 0
                                                ? Icons.favorite_outline
                                                : Icons.favorite,
                                            color: white,
                                          ),
                                        );
                                      }
                                      return Text('');
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: kDefaultPaddin * 1.2,
                              left: kDefaultPaddin,
                              right: kDefaultPaddin,
                            ).r,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /// addToCart button
                                StreamBuilder(
                                    stream: userCartItems
                                        .where('Name',
                                            isEqualTo:
                                                widget.Product['product-name'])
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.data == null)
                                        return Text('');
                                      if (snapshot.connectionState ==
                                          ConnectionState.active) {
                                        var data = snapshot.data.docs;
                                        return buildCartButton(
                                          onPressed: () {
                                            data.length == 0
                                                ? Cart.addToCart(
                                                    Product: widget.Product)
                                                : toast('Already added');
                                          },
                                          bgColor: data.length == 0
                                              ? white
                                              : Color(0xFF3D82AE),
                                          iconColor: data.length == 0
                                              ? Color(0xFF3D82AE)
                                              : white,
                                        );
                                      }
                                      return Text('');
                                    }),
                                SizedBox(width: 10.w),

                                /// buy now button
                                buildBuyNowButton(onPressed: () {}),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  /// variable

  final userFavItems = FirebaseFirestore.instance
      .collection('users-fav-items')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('itemFavs');

  final userCartItems = FirebaseFirestore.instance
      .collection('users-cart-items')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('itemLists');
}
